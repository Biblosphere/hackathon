import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/data/base_api.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/book_essential.dart';

abstract class BaseApiV1 extends BaseApi {
  const BaseApiV1({
    required String baseUrl,
    required Map<String, String> defaultHeaders,
  }) : super(baseUrl: baseUrl, defaultHeaders: defaultHeaders);

  Future<Either<Iterable<Book>>> getRecomandations(
    Iterable<BookEssential> likeBooks,
    Iterable<BookEssential> dislikeBooks,
  );

  Future<Either<Iterable<BookEssential>>> recognizePhoto(
    String path,
  );

  Future<Either<Iterable<BookEssential>>> searchTopBooks(
    String source,
    int count,
  );
}
