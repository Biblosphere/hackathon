import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/domain/entities/book_essential.dart';

abstract class BookEssentialRepo {
  Future<Either<Iterable<BookEssential>>> recognizePhoto(
    String path,
  );

  Future<Either<Iterable<BookEssential>>> searchTopBooks(
    String source,
    int count,
  );
}
