import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/domain/entities/book.dart';

abstract class BookRepo {
  Future<Either<Iterable<Book>>> searchTopBooks(
    String source,
    int count,
  );

  Future<Either<Iterable<Book>>> getRecomendedBooks(Iterable<Book> likeBooks);

  Future<Either<Iterable<Book>>> getNewBooks(String id);
}
