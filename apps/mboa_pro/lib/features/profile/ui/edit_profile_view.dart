import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../models/prestataire_type.dart';
import '../models/profile_data.dart';
import '../profile_types.dart';

/// Edit Profile (CDC M02): base user fields plus, for prestataires, the
/// business fields. Email is read-only (not updatable via the API).
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
  final _searchCity = TextEditingController();
  final _displayName = TextEditingController();
  final _mainCity = TextEditingController();
  PrestataireType _type = PrestataireType.particulier;
  String? _searchCityId;
  String? _mainCityId;

  bool _isPrestataire = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProProfileBloc>().state;
    if (state is ProProfileReady) _hydrate(state.data);
  }

  void _hydrate(ProfileData data) {
    _firstName.text = data.firstName ?? '';
    _lastName.text = data.lastName ?? '';
    _email.text = data.email ?? '';
    _searchCity.text = data.searchCity ?? '';
    _searchCityId = data.searchCityId;
    _displayName.text = data.displayName ?? '';
    _mainCity.text = data.mainCity ?? '';
    _mainCityId = data.mainCityId;
    _type = data.type ?? PrestataireType.agence;
    _isPrestataire = data.isPrestataire;
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
    _searchCity.dispose();
    _displayName.dispose();
    _mainCity.dispose();
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
              displayName: _isPrestataire ? _displayName.text.trim() : null,
              mainCityId: _isPrestataire ? _mainCityId : null,
              type: _isPrestataire ? _type : null,
            ),
          ),
        );
  }

  String? _required(String? value) =>
      (value == null || value.trim().isEmpty) ? I18n.of(context).commonError : null;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<ProProfileBloc, ProfileState>(
      listenWhen: (prev, curr) =>
          curr is ProProfileReady && (curr.justSaved || curr.saveFailed),
      listener: (context, state) {
        if (state is! ProProfileReady) return;
        if (state.justSaved) {
          MboaToast.success(context: context, title: l10n.profileSaved);
          Navigator.of(context).maybePop();
        } else if (state.saveFailed) {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError);
        }
      },
      builder: (context, state) {
        final saving = state is ProProfileReady && state.saving;

        return StackedLoaderView(
          isLoading: saving,
          child: Scaffold(
            backgroundColor: colors.surface,
            body: SafeArea(
              child: Column(
                children: [
                  _TopBar(title: l10n.editProfileTitle),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(Dimens.spacingLg),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Input(
                              controller: _firstName,
                              enabled: !saving,
                              labelText: l10n.profileFirstName,
                              variant: InputVariant.underline,
                              textInputAction: TextInputAction.next,
                              validator: _required,
                            ),
                            const SizedBox(height: Dimens.spacingLg),
                            Input(
                              controller: _lastName,
                              enabled: !saving,
                              labelText: l10n.profileLastName,
                              variant: InputVariant.underline,
                              textInputAction: TextInputAction.next,
                              validator: _required,
                            ),
                            const SizedBox(height: Dimens.spacingLg),
                            Input(
                              controller: _email,
                              readOnly: true,
                              labelText: l10n.authEmailLabel,
                              variant: InputVariant.underline,
                            ),
                            // Doc 10 gives a prestataire "Ville principale"
                            // only; "Ville de recherche" belongs to the
                            // Utilisateur profile. Showing both here read as
                            // two fields doing the same thing.
                            //
                            // An agent's real field is "Zone d'intervention"
                            // (villes/quartiers, M15) — unmodelled in the API,
                            // so the single city stands in until it exists.
                            if (!_isPrestataire) ...[
                              const SizedBox(height: Dimens.spacingLg),
                              Input(
                                controller: _searchCity,
                                readOnly: true,
                                enabled: !saving,
                                onTap: _pickSearchCity,
                                labelText: l10n.profileLocation,
                                hintText: l10n.cityPickerSearchHint,
                                variant: InputVariant.underline,
                                suffixIcon: Icon(LucideIcons.chevronDown, color: colors.textSecondary),
                              ),
                            ],
                            if (_isPrestataire) ...[
                              const SizedBox(height: Dimens.spacingLg),
                              Input(
                                controller: _displayName,
                                enabled: !saving,
                                labelText: l10n.profileDisplayName,
                                variant: InputVariant.underline,
                                textInputAction: TextInputAction.next,
                                validator: _required,
                              ),
                              const SizedBox(height: Dimens.spacingLg),
                              Input(
                                controller: _mainCity,
                                readOnly: true,
                                enabled: !saving,
                                onTap: _pickMainCity,
                                labelText: l10n.profileMainCity,
                                hintText: l10n.cityPickerSearchHint,
                                variant: InputVariant.underline,
                                suffixIcon: Icon(LucideIcons.chevronDown, color: colors.textSecondary),
                              ),
                              const SizedBox(height: Dimens.spacingLg),
                              Text(
                                l10n.profileType,
                                style: context.mboaText.label.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: colors.primaryDark,
                                ),
                              ),
                              const SizedBox(height: Dimens.spacingXs),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Dimens.spacingLg),
                    child: Button.primary(
                      title: l10n.profileSave,
                      icon: const Icon(LucideIcons.save, size: Dimens.icon),
                      iconAlignment: IconAlignment.start,
                      isCenter: true,
                      isLoading: saving,
                      onPressed: saving ? null : _save,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing, vertical: Dimens.spacingSm),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(LucideIcons.arrowLeft, color: colors.primary),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: context.mboaText.h3.copyWith(color: colors.primary),
            ),
          ),
          const SizedBox(width: Dimens.iconLg),
        ],
      ),
    );
  }
}
