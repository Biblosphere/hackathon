import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/book_essential.dart';

abstract class BookRepo {
  Future<Either<Iterable<Book>>> getRecomendedBooks(
    Iterable<BookEssential> likeBooks,
    Iterable<BookEssential> dislikeBooks,
  );
}
