import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/domain/entities/book.dart';

abstract class BookRepo {
  Future<Either<Iterable<Book>>> searchBooks(String source, int count);

  Future<Either<Iterable<Book>>> getRecomendationsByBooks(Iterable<int> ids);

  Future<Either<Iterable<Book>>> getRecommendationsById(String id);
}
