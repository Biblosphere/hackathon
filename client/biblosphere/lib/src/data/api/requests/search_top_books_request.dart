import 'dart:async';
import 'dart:convert';
import 'package:biblosphere/src/data/base_api_v1.dart';
import 'package:biblosphere/src/data/mapper/book_essentials_mapper.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:http/http.dart' as http;
import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/domain/entities/book_essential.dart';

mixin SearchTopBooksRequest on BaseApiV1 {
  @override
  Future<Either<Iterable<BookEssential>>> searchTopBooks(
    String source,
    int count,
  ) {
    final completer = Completer<Either<Iterable<BookEssential>>>();
    http
        .post(
      Uri.parse('$baseUrl/search_top_books'),
      headers: defaultHeaders,
      body: jsonEncode(
        {
          'search_string': source,
          'count': count,
        },
      ),
    )
        .then((response) {
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map;
        final bookEssentials = BookEssentialsApiMapper.fromJson(json.cast());
        completer.complete(Either.success(bookEssentials));
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
