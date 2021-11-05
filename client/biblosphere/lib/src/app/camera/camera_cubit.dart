import 'package:biblosphere/src/app/camera/photo.dart';
import 'package:biblosphere/src/app/input_page/input_cubit.dart';
import 'package:biblosphere/src/utils/id_util.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraState extends Equatable {
  const CameraState({required this.photos});

  final List<Photo> photos;

  @override
  List<Object?> get props => [photos];
}

class CameraCubit extends Cubit<CameraState> {
  CameraCubit(this._inputCubit) : super(_initialState);

  final InputCubit _inputCubit;
  static const _initialState = CameraState(photos: []);

  void handlePhoto(XFile photo) {
    emit(CameraState(photos: [
      ...state.photos,
      Photo(id: _createId(), photo: photo),
    ]));
    _inputCubit.handlePhoto(photo);
  }

  int _createId() {
    final id = IdUtil.createId();
    if (state.photos.where((e) => e.id == id).isEmpty) return id;
    return _createId();
  }
}
