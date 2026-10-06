#!/usr/bin/env ruby
# Points each flavour configuration at its own xcconfig in ios/Flutter/.
#
# The "Flutter" group is a logical group with no path of its own, so a file
# added to it by name alone lands at ios/<name>.xcconfig — one directory too
# high. Xcode then finds nothing, PODS_ROOT comes out empty, and the build
# fails on a file list path that starts with a bare slash. The reference has to
# carry the directory.
require 'xcodeproj'

ROOT = File.expand_path('../..', __dir__)

%w[mboa_user mboa_pro].each do |app|
  path = "#{ROOT}/apps/#{app}/ios/Runner.xcodeproj"
  project = Xcodeproj::Project.open(path)
  group = project.main_group.find_subpath('Flutter', true)

  %w[production staging dev].each do |flavor|
    %w[Debug Release Profile].each do |base|
      name = "#{base}-#{flavor}"
      relative = "Flutter/#{name}.xcconfig"

      # Drop any earlier reference that pointed at the wrong directory.
      group.files.select { |f| f.path == "#{name}.xcconfig" }.each(&:remove_from_project)

      ref = group.files.find { |f| f.path == relative } || group.new_file(relative)
      project.build_configurations.find { |c| c.name == name }
             &.base_configuration_reference = ref
      project.targets.each do |target|
        next unless target.name == 'Runner'
        target.build_configurations.find { |c| c.name == name }
              &.base_configuration_reference = ref
      end
    end
  end

  project.save
  runner = project.targets.find { |t| t.name == 'Runner' }
  shown = runner.build_configurations.find { |c| c.name == 'Debug-dev' }
  puts "#{app}: Debug-dev -> #{shown.base_configuration_reference.real_path}"
end
