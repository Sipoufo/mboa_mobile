import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../profile_types.dart';

/// « Mon profil » (CDC M02) for App Mboa users: the name, the email and the
/// phone (§40 A — each added or changed on its own code-verified screen),
/// the city. Built from the same pieces as the Pro's form.
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
  String? _searchCityId;

  @override
  void initState() {
    super.initState();
    final state = context.read<UserProfileBloc>().state;
    if (state is UserProfileReady) _hydrate(state.data);
  }

  /// What was read, so « Enregistrer » waits for a change.
  BaseProfile? _initial;

  void _hydrate(BaseProfile data) {
    _initial = data;
    _firstName.text = data.firstName ?? '';
    _lastName.text = data.lastName ?? '';
    _email.text = data.email ?? '';
    _phone.text = data.phoneNumber ?? '';
    _searchCity.text = data.searchCity ?? '';
    _searchCityId = data.searchCityId;
  }

  Future<void> _pickCity() async {
    final city = await showCityPicker(context, repository: getIt<LocationRepository>());
    if (city != null && mounted) {
      setState(() {
        _searchCity.text = city.name;
        _searchCityId = city.id;
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
    super.dispose();
  }

  void _save() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<UserProfileBloc>().add(
      ProfileSaveRequested(
        BaseProfileEdit(
          firstName: _firstName.text.trim(),
          lastName: _lastName.text.trim(),
          searchCityId: _searchCityId,
        ),
      ),
    );
  }

  /// §40 A — the email added or changed, the number added or changed: each
  /// on its own code-verified screen, the profile read again on return.
  Future<void> _changeEmail() async {
    await context.router.push(
      ChangeEmailRoute(currentEmail: _blank(_email.text), phoneNumber: _blank(_phone.text)),
    );
    if (mounted) context.read<UserProfileBloc>().add(const ProfileLoadRequested());
  }

  Future<void> _changePhone() async {
    await context.router.push(ChangePhoneRoute(adding: _blank(_phone.text) == null));
    if (mounted) context.read<UserProfileBloc>().add(const ProfileLoadRequested());
  }

  bool get _dirty {
    final initial = _initial;
    if (initial == null) return true;
    return _firstName.text.trim() != (initial.firstName ?? '') ||
        _lastName.text.trim() != (initial.lastName ?? '') ||
        _searchCityId != initial.searchCityId;
  }

  static String? _blank(String text) => text.trim().isEmpty ? null : text.trim();

  String? _required(String? value) => (value == null || value.trim().isEmpty) ? I18n.of(context).commonError : null;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<UserProfileBloc, ProfileState>(
      listenWhen: (prev, curr) => curr is UserProfileReady,
      listener: (context, state) {
        if (state is! UserProfileReady) return;
        // Changed on their own screens: shown as they now are.
        _email.text = state.data.email ?? '';
        _phone.text = state.data.phoneNumber ?? '';
        if (state.justSaved) {
          MboaToast.success(context: context, title: l10n.profileSaved);
          MboaHeaderBackButton.pop(context);
        } else if (state.saveFailed) {
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: l10n.commonError,
          );
        }
      },
      builder: (context, state) {
        final saving = state is UserProfileReady && state.saving;
        final data = state is UserProfileReady ? state.data : _initial;

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
                          // §40 A — each added or changed on its own
                          // code-verified screen.
                          ProfileFormSection(
                            title: l10n.profileSectionContact,
                            children: [
                              Input(
                                controller: _email,
                                readOnly: true,
                                enabled: !saving,
                                onTap: _changeEmail,
                                labelText: l10n.authEmailLabel,
                                suffixIcon: _Action(label: _email.text.isEmpty ? l10n.profileAdd : l10n.profileChange),
                              ),
                              Input(
                                controller: _phone,
                                readOnly: true,
                                enabled: !saving,
                                onTap: _changePhone,
                                labelText: l10n.loginPhoneLabel,
                                suffixIcon: _Action(label: _phone.text.isEmpty ? l10n.profileAdd : l10n.profileChange),
                              ),
                            ],
                          ),
                          ProfileFormSection(
                            title: l10n.profileLocation,
                            children: [
                              Input(
                                controller: _searchCity,
                                readOnly: true,
                                enabled: !saving,
                                onTap: _pickCity,
                                hintText: l10n.cityPickerSearchHint,
                                suffixIcon: Icon(LucideIcons.chevronDown, color: colors.textSecondary),
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
                    listenable: Listenable.merge([_firstName, _lastName]),
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

/// « Ajouter » or « Changer », at the end of the email's or the phone's row.
class _Action extends StatelessWidget {
  const _Action({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing),
    child: Center(
      widthFactor: 1,
      child: Text(label, style: context.mboaText.label.copyWith(color: context.mboaColors.primary)),
    ),
  );
}
