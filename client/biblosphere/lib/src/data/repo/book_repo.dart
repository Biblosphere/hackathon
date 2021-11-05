import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/data/base_api_v1.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/book_essential.dart';
import 'package:biblosphere/src/domain/repo/book_repo.dart';

class BookRepoImpl implements BookRepo {
  const BookRepoImpl(this._apiV1);

  final BaseApiV1 _apiV1;

  @override
  Future<Either<Iterable<Book>>> getRecomendedBooks(
    Iterable<BookEssential> likeBooks,
    Iterable<BookEssential> dislikeBooks,
  ) {
    return _apiV1.getRecomandations(likeBooks, dislikeBooks);
  }
}
