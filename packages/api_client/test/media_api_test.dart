import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for MediaApi
void main() {
  final instance = ApiClient().getMediaApi();

  group(MediaApi, () {
    // Get a pre-signed URL to upload a file directly to storage
    //
    //Future<PresignedUpload> createMediaUpload(CreateUploadRequest createUploadRequest) async
    test('test createMediaUpload', () async {
      // TODO
    });

  });
}
