import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/domain/entities/new_book.dart';

abstract class NewBookRepo {
  Future<Either<NewBooks>> getNewBooks(String id);
}
