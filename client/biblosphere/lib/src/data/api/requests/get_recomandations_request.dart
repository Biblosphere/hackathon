import 'dart:async';
import 'dart:convert';
import 'package:biblosphere/src/data/base_api_v1.dart';
import 'package:biblosphere/src/data/mapper/book_essentials_mapper.dart';
import 'package:biblosphere/src/data/mapper/book_mapper.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:http/http.dart' as http;
import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/book_essential.dart';

mixin GetRecomandationsRequest on BaseApiV1 {
  @override
  Future<Either<Iterable<Book>>> getRecomandations(
    Iterable<BookEssential> likeBooks,
    Iterable<BookEssential> dislikeBooks,
  ) {
    final completer = Completer<Either<Iterable<Book>>>();
    http
        .post(
      Uri.parse('$baseUrl/get_recomandations'),
      headers: defaultHeaders,
      body: jsonEncode({
        'like_books': likeBooks.map((e) => e.toJson()).toList(),
        'unlike_books': dislikeBooks.map((e) => e.toJson()).toList(),
      }),
    )
        .then((response) {
      if (response.statusCode == 200) {
        final books = BooksMapper.fromJson(jsonDecode(response.body));
        completer.complete(Either.success(books));
      } else {
        throw AppError.network;
      }
    }).catchError((e) {
      final error = (e is AppError) ? e : AppError.network;
      completer.complete(Either.error(error));
    });
    return completer.future;
  }
}
