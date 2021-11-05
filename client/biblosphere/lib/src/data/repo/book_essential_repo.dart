import 'package:biblosphere/src/data/base_api_v1.dart';
import 'package:biblosphere/src/domain/entities/book_essential.dart';
import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/domain/repo/book_essential_repo.dart';

class BookEssentialRepoImpl implements BookEssentialRepo {
  const BookEssentialRepoImpl(this._apiV1);

  final BaseApiV1 _apiV1;

  @override
  Future<Either<Iterable<BookEssential>>> recognizePhoto(
    String path,
  ) {
    return _apiV1.recognizePhoto(path);
  }

  @override
  Future<Either<Iterable<BookEssential>>> searchTopBooks(
    String source,
    int count,
  ) {
    return _apiV1.searchTopBooks(source, count);
  }
}
