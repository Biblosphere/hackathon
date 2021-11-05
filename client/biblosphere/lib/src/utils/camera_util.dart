import 'dart:async';

import 'package:camera/camera.dart';

class CameraUtil {
  CameraUtil._internal();

  static final instance = CameraUtil._internal();

  late final CameraDescription frontCamera;
  late final CameraDescription backCamera;
  late final CameraDescription externalCamera;

  var _hasFrontCamera = false;
  var _hasBackCamera = false;
  var _hasExternalCamera = false;

  bool get hasFrontCamera => _hasFrontCamera;
  bool get hasBackCamera => _hasBackCamera;
  bool get hasExternalCamera => _hasExternalCamera;

  Future<void> initilize() async {
    final completer = Completer<void>();
    availableCameras().then((cameras) {
      for (final camera in cameras) {
        switch (camera.lensDirection) {
          case CameraLensDirection.front:
            frontCamera = camera;
            _hasFrontCamera = true;
            break;
          case CameraLensDirection.back:
            backCamera = camera;
            _hasBackCamera = true;
            break;
          case CameraLensDirection.external:
            externalCamera = externalCamera;
            _hasExternalCamera = true;
            break;
        }
      }
      completer.complete();
    }).onError((error, _) {
      completer.complete();
    });
    return completer.future;
  }
}
