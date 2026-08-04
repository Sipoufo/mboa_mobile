import 'package:mboa_shared/mboa_shared.dart';

/// App Mboa uses the shared base profile directly (no business/KYC fields).
/// These aliases keep the generic types readable at call sites.
typedef UserProfileBloc = ProfileBloc<BaseProfile, BaseProfileEdit>;
typedef UserProfileReady = ProfileReady<BaseProfile>;
