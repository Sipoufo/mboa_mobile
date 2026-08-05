import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// A backend error, reduced to something the UI can act on.
///
/// The wire shape, confirmed by the backend team:
///
/// ```json
/// { "timestamp": "...", "status": 409, "error": "LISTING_LIMIT_REACHED",
///   "message": "...", "path": "/api/v1/annonces/{id}/publish" }
/// ```
///
/// **The machine code lives in `error`.** `message` is prose for a human and
/// gets reworded — never branch on it. The other key names are still accepted
/// because this parser predates the contract being documented and costs nothing
/// to keep; parsing never throws, and an unrecognised body yields a null [code].
class ApiError extends Equatable {
  const ApiError({
    this.code,
    this.message,
    this.statusCode,
    this.fields = const [],
  });

  /// Machine-readable code, upper-cased — e.g. `RESIDENCE_UNIT_LIMIT`.
  final String? code;

  /// Human-readable text from the backend, if it sent one.
  final String? message;

  final int? statusCode;

  /// Per-field complaints from a `VALIDATION_ERROR`, in wire order.
  final List<({String field, String message})> fields;

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
      // `error` is the documented key; the rest are legacy tolerance.
      code: _firstString(map, const ['error', 'code', 'errorCode', 'error_code']),
      message: _firstString(map, const ['message', 'detail', 'error_description']),
      statusCode: status,
      fields: _fields(map),
    );
  }

  /// The first per-field complaint, which is the most useful thing to surface
  /// on a form.
  String? get firstFieldMessage =>
      fields.isEmpty ? null : fields.first.message;

  /// True when the backend named [candidate], regardless of casing.
  bool hasCode(String candidate) =>
      code != null && code!.toUpperCase() == candidate.toUpperCase();

  static List<({String field, String message})> _fields(
    Map<String, dynamic> map,
  ) {
    final raw = map['fields'];
    if (raw is! List) return const [];
    return [
      for (final entry in raw)
        if (entry is Map &&
            entry['field'] is String &&
            entry['message'] is String)
          (field: entry['field'] as String, message: entry['message'] as String),
    ];
  }

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
  List<Object?> get props => [code, message, statusCode, fields];
}
