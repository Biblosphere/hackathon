import 'dart:async';
import 'dart:convert';

import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/data/base_api_v2.dart';
import 'package:biblosphere/src/data/mapper/book_mapper.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:http/http.dart' as http;

mixin GetNewBooksRequest on BaseApiV2 {
  @override
  Future<Either<Iterable<Book>>> getNewBooks(String id) {
    final completer = Completer<Either<Iterable<Book>>>();
    http
        .get(
      Uri.parse('${config.baseUrl}/recommend/$id'),
      headers: config.defaultHeaders,
    )
        .then((response) {
      if (response.statusCode == 200) {
        final json = (jsonDecode(response.body.replaceAll('NaN', '""')) as Map)
            .cast<String, dynamic>();
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
