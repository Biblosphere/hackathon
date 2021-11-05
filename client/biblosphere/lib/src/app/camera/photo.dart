import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  const Photo({required this.id, required this.photo});

  final int id;
  final XFile photo;

  @override
  List<Object?> get props => [id];
}
