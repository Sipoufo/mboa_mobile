import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

class MockMediaApi extends Mock implements MediaApi {}

class MockImagePicker extends Mock implements ImagePicker {}

class MockDio extends Mock implements Dio {}

/// **A photo just sent is not fetched back.**
///
/// The public R2 host answers in 3 to 7 seconds and is never cached at the
/// edge, and every thumbnail shown after an upload asks it for the photo the
/// phone has just sent: a visit report's photos sat grey while the tenant
/// wondered whether they had gone. The uploader now files the bytes it holds
/// under the public URL, in the cache every `MboaNetworkImage` reads first.
void main() {
  late MockDioClient dioClient;
  late MockMediaApi media;
  late MockImagePicker picker;
  late MockDio r2;
  late List<(String, Uint8List)> remembered;

  final bytes = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xD9]);

  setUpAll(() {
    registerFallbackValue(CreateUploadRequest((b) => b
      ..category = CreateUploadRequestCategoryEnum.VISIT_REPORT
      ..contentType = 'image/jpeg'
      ..contentLength = 1));
    registerFallbackValue(Uri());
    registerFallbackValue(ImageSource.gallery);
    registerFallbackValue(Options());
  });

  setUp(() {
    dioClient = MockDioClient();
    media = MockMediaApi();
    picker = MockImagePicker();
    r2 = MockDio();
    remembered = [];

    final api = MockApiClient();
    when(() => dioClient.api).thenReturn(api);
    when(api.getMediaApi).thenReturn(media);
    when(() => picker.pickImage(
          source: any(named: 'source'),
          maxWidth: any(named: 'maxWidth'),
          maxHeight: any(named: 'maxHeight'),
          imageQuality: any(named: 'imageQuality'),
        )).thenAnswer((_) async => XFile('/picked.jpg'));
    when(() => media.createMediaUpload(createUploadRequest: any(named: 'createUploadRequest')))
        .thenAnswer((invocation) async {
      final request = invocation.namedArguments[#createUploadRequest] as CreateUploadRequest;
      final prefix = request.category == CreateUploadRequestCategoryEnum.KYC_DOCUMENT ? 'kyc' : 'visits';
      return Response(
        requestOptions: RequestOptions(),
        data: PresignedUpload((b) => b
          ..uploadUrl = 'https://r2.example/put'
          ..method = 'PUT'
          ..objectKey = '$prefix/u-1/p-1.jpg'),
      );
    });
    when(() => r2.requestUri<void>(any(), data: any(named: 'data'), options: any(named: 'options')))
        .thenAnswer((_) async => Response<void>(requestOptions: RequestOptions(), statusCode: 200));
  });

  MediaUploader uploader({Future<void> Function(String, Uint8List)? remember}) => MediaUploader(
        dioClient: dioClient,
        uploadClient: r2,
        picker: picker,
        compress: (_) async => bytes,
        remember: remember ?? (url, sent) async => remembered.add((url, sent)),
      );

  test('the bytes sent are filed under the URL the thumbnail will ask for', () async {
    final key = await uploader().captureAndUpload(
      source: ImageSource.gallery,
      category: CreateUploadRequestCategoryEnum.VISIT_REPORT,
    );

    expect(key, 'visits/u-1/p-1.jpg');
    expect(remembered, hasLength(1));
    expect(remembered.single.$1, BaseProfile.mediaUrl(key));
    expect(remembered.single.$2, bytes);
  });

  test('an identity document is never kept in an image cache', () async {
    final key = await uploader().captureAndUpload(
      source: ImageSource.camera,
      category: CreateUploadRequestCategoryEnum.KYC_DOCUMENT,
    );

    expect(key, 'kyc/u-1/p-1.jpg');
    expect(remembered, isEmpty);
  });

  test('a cache that cannot be written costs a download, never the upload', () async {
    final key = await uploader(remember: (_, _) async => throw Exception('disk full')).captureAndUpload(
      source: ImageSource.gallery,
      category: CreateUploadRequestCategoryEnum.VISIT_REPORT,
    );

    expect(key, 'visits/u-1/p-1.jpg');
  });

  test('nothing is remembered when the upload itself failed', () async {
    when(() => r2.requestUri<void>(any(), data: any(named: 'data'), options: any(named: 'options')))
        .thenThrow(DioException(requestOptions: RequestOptions()));

    await expectLater(
      uploader().captureAndUpload(
        source: ImageSource.gallery,
        category: CreateUploadRequestCategoryEnum.VISIT_REPORT,
      ),
      throwsA(isA<DioException>()),
    );
    expect(remembered, isEmpty);
  });
}
