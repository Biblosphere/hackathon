import 'package:biblosphere/src/resource/book_essential_resource.dart';

class Resource with BookEssentialResource {
  Resource._private();

  static final instance = Resource._private();
}
