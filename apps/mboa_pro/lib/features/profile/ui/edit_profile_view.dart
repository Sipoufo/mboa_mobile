import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../models/prestataire_type.dart';
import '../models/profile_data.dart';
import '../profile_types.dart';

/// Edit Profile (CDC M02): base user fields plus, for prestataires, the
/// business fields — the agent's « Informations personnelles » too. Email is
/// read-only; the phone opens its own change (RM-M02-02: never edited here).
class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _searchCity = TextEditingController();
  final _displayName = TextEditingController();
  final _mainCity = TextEditingController();
  final _registrationNumber = TextEditingController();
  PrestataireType _type = PrestataireType.particulier;
  String? _searchCityId;
  String? _mainCityId;

  bool _isPrestataire = false;
  bool _isAgent = false;

  /// What was read, so « Enregistrer » waits for a change.
  ProfileData? _initial;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProProfileBloc>().state;
    if (state is ProProfileReady) _hydrate(state.data);
  }

  void _hydrate(ProfileData data) {
    _initial = data;
    _phone.text = data.phoneNumber ?? '';
    _firstName.text = data.firstName ?? '';
    _lastName.text = data.lastName ?? '';
    _email.text = data.email ?? '';
    _searchCity.text = data.searchCity ?? '';
    _searchCityId = data.searchCityId;
    _displayName.text = data.displayName ?? '';
    _mainCity.text = data.mainCity ?? '';
    _mainCityId = data.mainCityId;
    _registrationNumber.text = data.registrationNumber ?? '';
    _type = data.type ?? PrestataireType.agence;
    _isPrestataire = data.isPrestataire;
    _isAgent = data.isAgent;
  }

  Future<void> _pickSearchCity() async {
    final city = await showCityPicker(context, repository: getIt<LocationRepository>());
    if (city != null && mounted) {
      setState(() {
        _searchCity.text = city.name;
        _searchCityId = city.id;
      });
    }
  }

  Future<void> _pickMainCity() async {
    final city = await showCityPicker(context, repository: getIt<LocationRepository>());
    if (city != null && mounted) {
      setState(() {
        _mainCity.text = city.name;
        _mainCityId = city.id;
      });
    }
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _phone.dispose();
    _searchCity.dispose();
    _displayName.dispose();
    _mainCity.dispose();
    _registrationNumber.dispose();
    super.dispose();
  }

  void _save() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<ProProfileBloc>().add(
      ProfileSaveRequested(
        ProfileEdit(
          firstName: _firstName.text.trim(),
          lastName: _lastName.text.trim(),
          searchCityId: _searchCityId,
          isPrestataire: _isPrestataire,
          isAgent: _isAgent,
          displayName: _isPrestataire ? _displayName.text.trim() : null,
          mainCityId: _isPrestataire ? _mainCityId : null,
          type: _isPrestataire ? _type : null,
          // Empty means "not given" rather than an empty string on the
          // contract's identity line.
          registrationNumber: _isPrestataire && _registrationNumber.text.trim().isNotEmpty
              ? _registrationNumber.text.trim()
              : null,
        ),
      ),
    );
  }

  /// Anything changed since it was read: the save has something to send.
  bool get _dirty {
    final initial = _initial;
    if (initial == null) return true;
    String text(TextEditingController c) => c.text.trim();
    return text(_firstName) != (initial.firstName ?? '') ||
        text(_lastName) != (initial.lastName ?? '') ||
        _searchCityId != initial.searchCityId ||
        (_isPrestataire &&
            (text(_displayName) != (initial.displayName ?? '') ||
                _mainCityId != initial.mainCityId ||
                text(_registrationNumber) != (initial.registrationNumber ?? '') ||
                _type != (initial.type ?? PrestataireType.agence)));
  }

  /// RM-M02-02 — its own two-code change; the number read again on return.
  Future<void> _changePhone() async {
    await context.router.push(const ChangePhoneRoute());
    if (mounted) context.read<ProProfileBloc>().add(const ProfileLoadRequested());
  }

  String? _required(String? value) => (value == null || value.trim().isEmpty) ? I18n.of(context).commonError : null;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<ProProfileBloc, ProfileState>(
      listenWhen: (prev, curr) => curr is ProProfileReady,
      listener: (context, state) {
        if (state is! ProProfileReady) return;
        // The number changed on its own screen: shown as it now is.
        _phone.text = state.data.phoneNumber ?? '';
        if (state.justSaved) {
          MboaToast.success(context: context, title: l10n.profileSaved);
          MboaHeaderBackButton.pop(context);
        } else if (state.saveFailed) {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError);
        }
      },
      builder: (context, state) {
        final saving = state is ProProfileReady && state.saving;
        final data = state is ProProfileReady ? state.data : _initial;

        return StackedLoaderView(
          isLoading: saving,
          child: Scaffold(
            backgroundColor: colors.background,
            body: Column(
              children: [
                ProfileFormHeader(
                  title: l10n.editProfileTitle,
                  name: data?.fullName,
                  avatarUrl: data?.avatarUrl,
                  initials: data?.initials,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(Dimens.spacing),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ProfileFormSection(
                            title: l10n.profileSectionIdentity,
                            children: [
                              Input(
                                controller: _firstName,
                                enabled: !saving,
                                labelText: l10n.profileFirstName,
                                textInputAction: TextInputAction.next,
                                validator: _required,
                              ),
                              Input(
                                controller: _lastName,
                                enabled: !saving,
                                labelText: l10n.profileLastName,
                                textInputAction: TextInputAction.next,
                                validator: _required,
                              ),
                            ],
                          ),
                          ProfileFormSection(
                            title: l10n.profileSectionContact,
                            children: [
                              Input(
                                controller: _email,
                                readOnly: true,
                                labelText: l10n.authEmailLabel,
                                suffixIcon: Icon(LucideIcons.lock, size: Dimens.icon, color: colors.textTertiary),
                              ),
                              Text(
                                l10n.profileEmailLocked,
                                style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                              ),
                              // RM-M02-02 — never edited here: its own two-code
                              // change, one tap away.
                              Input(
                                controller: _phone,
                                readOnly: true,
                                enabled: !saving,
                                onTap: _changePhone,
                                labelText: l10n.loginPhoneLabel,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing),
                                  child: Center(
                                    widthFactor: 1,
                                    child: Text(
                                      l10n.profileChange,
                                      style: context.mboaText.label.copyWith(color: colors.primary),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Doc 10 gives a prestataire "Ville principale"
                          // only; "Ville de recherche" belongs to the
                          // Utilisateur profile. Showing both here read as
                          // two fields doing the same thing.
                          //
                          // An agent's real field is "Zone d'intervention"
                          // (villes/quartiers, M15) — unmodelled in the API,
                          // so the single city stands in until it exists.
                          if (!_isPrestataire)
                            ProfileFormSection(
                              title: l10n.profileLocation,
                              children: [
                                Input(
                                  controller: _searchCity,
                                  readOnly: true,
                                  enabled: !saving,
                                  onTap: _pickSearchCity,
                                  hintText: l10n.cityPickerSearchHint,
                                  suffixIcon: Icon(LucideIcons.chevronDown, color: colors.textSecondary),
                                ),
                              ],
                            ),
                          if (_isPrestataire)
                            ProfileFormSection(
                              title: l10n.profileSectionBusiness,
                              children: [
                                Input(
                                  controller: _displayName,
                                  enabled: !saving,
                                  labelText: l10n.profileDisplayName,
                                  textInputAction: TextInputAction.next,
                                  validator: _required,
                                ),
                                Input(
                                  controller: _mainCity,
                                  readOnly: true,
                                  enabled: !saving,
                                  onTap: _pickMainCity,
                                  labelText: l10n.profileMainCity,
                                  hintText: l10n.cityPickerSearchHint,
                                  suffixIcon: Icon(LucideIcons.chevronDown, color: colors.textSecondary),
                                ),
                                Input(
                                  controller: _registrationNumber,
                                  enabled: !saving,
                                  labelText: l10n.profileRegistrationNumber,
                                  hintText: l10n.profileRegistrationNumberHint,
                                  textInputAction: TextInputAction.next,
                                ),
                                // M08 prints it on the contract next to the
                                // tenant's CNI; without it no Contrat Mboa is
                                // compliant, which is worth saying here rather
                                // than failing later.
                                Text(
                                  l10n.profileRegistrationNumberHelp,
                                  style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                                ),
                                Text(
                                  l10n.profileType,
                                  style: context.mboaText.label.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: colors.primaryDark,
                                  ),
                                ),
                                MboaSegmentedControl<PrestataireType>(
                                  value: _type,
                                  enabled: !saving,
                                  onChanged: (type) => setState(() => _type = type),
                                  segments: [
                                    MboaSegment(value: PrestataireType.particulier, label: l10n.profileTypeParticulier),
                                    MboaSegment(value: PrestataireType.agence, label: l10n.profileTypeAgence),
                                    MboaSegment(value: PrestataireType.promoteur, label: l10n.profileTypePromoteur),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Doc05 §6.1 — the one thing the screen expects.
                ProfileFormActionBar(
                  child: ListenableBuilder(
                    // Nothing changed, nothing to save.
                    listenable: Listenable.merge([_firstName, _lastName, _displayName, _registrationNumber]),
                    builder: (context, _) => Button.primary(
                      title: l10n.profileSave,
                      isLoading: saving,
                      onPressed: saving || !_dirty ? null : _save,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
