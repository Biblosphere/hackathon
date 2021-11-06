import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:flutter/foundation.dart';

class Either<T> {
  const Either.success(this.data)
      : error = null,
        success = true;

  Either.error(this.error)
      : data = null,
        success = false {
    debugPrint('Either $T error: $error');
  }

  final T? data;
  final AppError? error;
  final bool success;
}
