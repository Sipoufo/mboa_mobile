import 'package:equatable/equatable.dart';

/// A selectable city (from the locations catalogue). Domain model so the UI
/// never touches the generated API type.
class CityOption extends Equatable {
  const CityOption({required this.id, required this.name});

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
