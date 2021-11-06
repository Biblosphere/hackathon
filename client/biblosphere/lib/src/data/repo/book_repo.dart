import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/data/api/api_v1/api_v1.dart';
import 'package:biblosphere/src/data/api/api_v2/api_v2.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/repo/book_repo.dart';

class BookRepoImpl implements BookRepo {
  const BookRepoImpl(this._apiV1, this._apiV2);

  final ApiV1 _apiV1;
  final ApiV2 _apiV2;

  @override
  Future<Either<Iterable<Book>>> getRecommendationsById(String id) {
    return _apiV2.getRecommendationsById(id);
  }

  @override
  Future<Either<Iterable<Book>>> getRecomendationsByBooks(
      Iterable<Book> likeBooks) {
    return _apiV2.getRecomendationsByBooks(likeBooks);
  }

  @override
  Future<Either<Iterable<Book>>> searchBooks(String source, int count) {
    return _apiV1.searchBooks(source, count);
  }
}
