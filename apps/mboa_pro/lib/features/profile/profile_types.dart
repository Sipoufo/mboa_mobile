import 'package:mboa_shared/mboa_shared.dart';

import 'models/profile_data.dart';

/// App Mboa Pro extends the shared base profile with business fields. These
/// aliases keep the generic types readable at call sites.
typedef ProProfileBloc = ProfileBloc<ProfileData, ProfileEdit>;
typedef ProProfileReady = ProfileReady<ProfileData>;
