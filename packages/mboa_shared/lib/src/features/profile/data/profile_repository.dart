/// The contract the shared [ProfileBloc] drives: load the aggregated profile
/// [D] and persist an edit [E]. Each app provides an implementation ([D]/[E]
/// being its own profile / edit types).
abstract interface class ProfileRepository<D, E> {
  Future<D> load();
  Future<D> save(E edit);

  /// Persists a newly-uploaded profile photo object key and returns the
  /// refreshed profile.
  Future<D> updatePhoto(String objectKey);
}
