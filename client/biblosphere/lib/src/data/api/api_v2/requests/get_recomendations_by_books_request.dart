import 'dart:async';
import 'dart:convert';
import 'package:biblosphere/src/data/api/base_api.dart';
import 'package:biblosphere/src/data/mapper/book_mapper.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:http/http.dart' as http;
import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/domain/entities/book.dart';

mixin GetRecommendationsRequest on BaseApi {
  Future<Either<Iterable<Book>>> getRecomendationsByBooks(
    Iterable<Book> likeBooks,
  ) {
    final completer = Completer<Either<Iterable<Book>>>();
    http
        .post(
      Uri.parse('${config.baseUrl}/recommend_by_books/'),
      headers: config.defaultHeaders,
      body: jsonEncode({
        'like_books': likeBooks.map((e) => e.toJson()).toList(),
      }),
    )
        .then((response) {
      if (response.statusCode == 200) {
        final json = (jsonDecode(response.body) as Map).cast<String, dynamic>();
        final books = BooksMapper.fromJson('recommendations', json);
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
