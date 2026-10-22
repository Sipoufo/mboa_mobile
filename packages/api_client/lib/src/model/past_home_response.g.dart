// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_home_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PastHomeResponse extends PastHomeResponse {
  @override
  final HomeSummary? home;
  @override
  final bool? listingOnline;
  @override
  final String? verificationCode;
  @override
  final PastHomeExpenses? expenses;
  @override
  final int? requestCount;
  @override
  final int? openRequestCount;
  @override
  final PropertyRating? rating;
  @override
  final PastHomeReview? myReview;

  factory _$PastHomeResponse([
    void Function(PastHomeResponseBuilder)? updates,
  ]) => (PastHomeResponseBuilder()..update(updates))._build();

  _$PastHomeResponse._({
    this.home,
    this.listingOnline,
    this.verificationCode,
    this.expenses,
    this.requestCount,
    this.openRequestCount,
    this.rating,
    this.myReview,
  }) : super._();
  @override
  PastHomeResponse rebuild(void Function(PastHomeResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PastHomeResponseBuilder toBuilder() =>
      PastHomeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PastHomeResponse &&
        home == other.home &&
        listingOnline == other.listingOnline &&
        verificationCode == other.verificationCode &&
        expenses == other.expenses &&
        requestCount == other.requestCount &&
        openRequestCount == other.openRequestCount &&
        rating == other.rating &&
        myReview == other.myReview;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, home.hashCode);
    _$hash = $jc(_$hash, listingOnline.hashCode);
    _$hash = $jc(_$hash, verificationCode.hashCode);
    _$hash = $jc(_$hash, expenses.hashCode);
    _$hash = $jc(_$hash, requestCount.hashCode);
    _$hash = $jc(_$hash, openRequestCount.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, myReview.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PastHomeResponse')
          ..add('home', home)
          ..add('listingOnline', listingOnline)
          ..add('verificationCode', verificationCode)
          ..add('expenses', expenses)
          ..add('requestCount', requestCount)
          ..add('openRequestCount', openRequestCount)
          ..add('rating', rating)
          ..add('myReview', myReview))
        .toString();
  }
}

class PastHomeResponseBuilder
    implements Builder<PastHomeResponse, PastHomeResponseBuilder> {
  _$PastHomeResponse? _$v;

  HomeSummaryBuilder? _home;
  HomeSummaryBuilder get home => _$this._home ??= HomeSummaryBuilder();
  set home(HomeSummaryBuilder? home) => _$this._home = home;

  bool? _listingOnline;
  bool? get listingOnline => _$this._listingOnline;
  set listingOnline(bool? listingOnline) =>
      _$this._listingOnline = listingOnline;

  String? _verificationCode;
  String? get verificationCode => _$this._verificationCode;
  set verificationCode(String? verificationCode) =>
      _$this._verificationCode = verificationCode;

  PastHomeExpensesBuilder? _expenses;
  PastHomeExpensesBuilder get expenses =>
      _$this._expenses ??= PastHomeExpensesBuilder();
  set expenses(PastHomeExpensesBuilder? expenses) =>
      _$this._expenses = expenses;

  int? _requestCount;
  int? get requestCount => _$this._requestCount;
  set requestCount(int? requestCount) => _$this._requestCount = requestCount;

  int? _openRequestCount;
  int? get openRequestCount => _$this._openRequestCount;
  set openRequestCount(int? openRequestCount) =>
      _$this._openRequestCount = openRequestCount;

  PropertyRatingBuilder? _rating;
  PropertyRatingBuilder get rating =>
      _$this._rating ??= PropertyRatingBuilder();
  set rating(PropertyRatingBuilder? rating) => _$this._rating = rating;

  PastHomeReviewBuilder? _myReview;
  PastHomeReviewBuilder get myReview =>
      _$this._myReview ??= PastHomeReviewBuilder();
  set myReview(PastHomeReviewBuilder? myReview) => _$this._myReview = myReview;

  PastHomeResponseBuilder() {
    PastHomeResponse._defaults(this);
  }

  PastHomeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _home = $v.home?.toBuilder();
      _listingOnline = $v.listingOnline;
      _verificationCode = $v.verificationCode;
      _expenses = $v.expenses?.toBuilder();
      _requestCount = $v.requestCount;
      _openRequestCount = $v.openRequestCount;
      _rating = $v.rating?.toBuilder();
      _myReview = $v.myReview?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PastHomeResponse other) {
    _$v = other as _$PastHomeResponse;
  }

  @override
  void update(void Function(PastHomeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PastHomeResponse build() => _build();

  _$PastHomeResponse _build() {
    _$PastHomeResponse _$result;
    try {
      _$result =
          _$v ??
          _$PastHomeResponse._(
            home: _home?.build(),
            listingOnline: listingOnline,
            verificationCode: verificationCode,
            expenses: _expenses?.build(),
            requestCount: requestCount,
            openRequestCount: openRequestCount,
            rating: _rating?.build(),
            myReview: _myReview?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'home';
        _home?.build();

        _$failedField = 'expenses';
        _expenses?.build();

        _$failedField = 'rating';
        _rating?.build();
        _$failedField = 'myReview';
        _myReview?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PastHomeResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
