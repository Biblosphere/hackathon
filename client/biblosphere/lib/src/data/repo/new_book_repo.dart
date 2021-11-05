import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/data/base_api_v2.dart';
import 'package:biblosphere/src/domain/entities/new_book.dart';
import 'package:biblosphere/src/domain/repo/new_book_repo.dart';

class NewBookRepoImpl implements NewBookRepo {
  const NewBookRepoImpl(this._apiV2);

  final BaseApiV2 _apiV2;

  @override
  Future<Either<NewBooks>> getNewBooks(String id) {
    return _apiV2.getNewBooks(id);
  }
}
