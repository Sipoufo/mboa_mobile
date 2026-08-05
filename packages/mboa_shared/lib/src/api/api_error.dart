import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// A backend error, reduced to something the UI can act on.
///
/// **The OpenAPI spec documents no error schema** — only success responses — so
/// the body shape is inferred defensively from what backends of this kind
/// return. Parsing therefore accepts several shapes and never throws: an
/// unrecognised body yields an [ApiError] with a null [code], and the caller
/// falls back to a generic message.
class ApiError extends Equatable {
  const ApiError({this.code, this.message, this.statusCode});

  /// Machine-readable code, upper-cased — e.g. `RESIDENCE_UNIT_LIMIT`.
  final String? code;

  /// Human-readable text from the backend, if it sent one.
  final String? message;

  final int? statusCode;

  static ApiError from(Object error) {
    if (error is! DioException) return const ApiError();

    final response = error.response;
    final data = response?.data;
    final status = response?.statusCode;

    if (data is! Map) {
      // Some servers return a bare string body.
      final text = data is String && data.trim().isNotEmpty ? data.trim() : null;
      return ApiError(message: text, statusCode: status);
    }

    final map = Map<String, dynamic>.from(data);
    return ApiError(
      code: _firstString(map, const ['code', 'errorCode', 'error_code', 'error']),
      message: _firstString(map, const ['message', 'detail', 'error_description']),
      statusCode: status,
    );
  }

  /// True when the backend named [candidate], regardless of casing.
  bool hasCode(String candidate) =>
      code != null && code!.toUpperCase() == candidate.toUpperCase();

  static String? _firstString(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value is String && value.trim().isNotEmpty) {
        final text = value.trim();
        // Spring's default body puts the HTTP reason phrase in `error`; that is
        // not a code, so don't mistake it for one.
        if (key == 'error' && text.contains(' ')) continue;
        return text;
      }
    }
    return null;
  }

  @override
  List<Object?> get props => [code, message, statusCode];
}
