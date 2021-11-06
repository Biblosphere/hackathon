import 'package:biblosphere/src/resource/book_resource.dart';

class Resource with BookResource {
  Resource._private();

  static final instance = Resource._private();
}
