import 'dart:math';

abstract class IdUtil {
  static int createId() {
    return Random().nextInt(100);
  }
}
