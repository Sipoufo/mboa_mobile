#!/usr/bin/env ruby
# Adds the dev / staging / production flavours to both iOS projects.
#
# Flutter picks a flavour by scheme name and expects one build configuration
# per (build type, flavour) pair, named "<BuildType>-<flavour>". Each one
# carries its own bundle id, display name and icon set, which is what lets the
# three builds sit side by side on one phone.
#
# Written with the `xcodeproj` gem (it ships with CocoaPods) rather than by
# editing project.pbxproj as text: the file is a plist with cross-references,
# and a hand edit that looks right usually opens as a broken project.
require 'xcodeproj'

ROOT = File.expand_path('../..', __dir__)
BASE_CONFIGS = %w[Debug Release Profile].freeze
FLAVORS = {
  'production' => { suffix: '',          icon: 'AppIcon' },
  'staging'    => { suffix: '.staging',  icon: 'AppIconStaging' },
  'dev'        => { suffix: '.dev',      icon: 'AppIconDev' },
}.freeze
NAMES = {
  'mboa_user' => { 'production' => 'Mboa',     'staging' => 'Mboa Staging', 'dev' => 'Mboa Dev' },
  'mboa_pro'  => { 'production' => 'Mboa Pro', 'staging' => 'Mboa Pro Stg', 'dev' => 'Mboa Pro Dev' },
}.freeze

NAMES.each_key do |app|
  path = "#{ROOT}/apps/#{app}/ios/Runner.xcodeproj"
  project = Xcodeproj::Project.open(path)
  runner = project.targets.find { |t| t.name == 'Runner' }
  base_id = runner.build_configurations.first
                  .build_settings['PRODUCT_BUNDLE_IDENTIFIER'].sub(/\.(dev|staging)\z/, '')

  FLAVORS.each do |flavor, spec|
    BASE_CONFIGS.each do |base|
      name = "#{base}-#{flavor}"
      template = project.build_configurations.find { |c| c.name == base }

      unless project.build_configurations.any? { |c| c.name == name }
        added = project.add_build_configuration(name, template.type)
        added.base_configuration_reference = template.base_configuration_reference
        added.build_settings = template.build_settings.dup
      end

      project.targets.each do |target|
        existing = target.build_configurations.find { |c| c.name == name }
        unless existing
          source = target.build_configurations.find { |c| c.name == base }
          existing = target.add_build_configuration(name, source.type)
          existing.base_configuration_reference = source.base_configuration_reference
          existing.build_settings = source.build_settings.dup
        end
        next unless target.name == 'Runner'

        existing.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = base_id + spec[:suffix]
        existing.build_settings['ASSETCATALOG_COMPILER_APPICON_NAME'] = spec[:icon]
        # Read by Info.plist through $(APP_DISPLAY_NAME).
        existing.build_settings['APP_DISPLAY_NAME'] = NAMES[app][flavor]
      end
    end

    scheme_path = "#{path}/xcshareddata/xcschemes/#{flavor}.xcscheme"
    scheme = Xcodeproj::XCScheme.new
    scheme.add_build_target(runner)
    scheme.set_launch_target(runner)
    scheme.launch_action.build_configuration = "Debug-#{flavor}"
    scheme.test_action.build_configuration = "Debug-#{flavor}"
    scheme.profile_action.build_configuration = "Profile-#{flavor}"
    scheme.analyze_action.build_configuration = "Debug-#{flavor}"
    scheme.archive_action.build_configuration = "Release-#{flavor}"
    scheme.save_as(path, flavor, true)
  end

  project.save
  puts "#{app}: #{project.build_configurations.map(&:name).join(', ')}"
end
