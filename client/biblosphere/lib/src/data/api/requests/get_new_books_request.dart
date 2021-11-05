import 'dart:async';
import 'dart:convert';

import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/data/base_api_v2.dart';
import 'package:biblosphere/src/data/mapper/new_book_mapper.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/domain/entities/new_book.dart';
import 'package:http/http.dart' as http;

mixin GetNewBooksRequest on BaseApiV2 {
  @override
  Future<Either<NewBooks>> getNewBooks(String id) {
    final completer = Completer<Either<NewBooks>>();
    http
        .get(Uri.parse('$baseUrl/recommend/$id'), headers: defaultHeaders)
        .then((response) {
      if (response.statusCode == 200) {
        final books = NewBooksMapper.fromJson(
            jsonDecode(response.body.replaceAll('NaN', '""')));
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
