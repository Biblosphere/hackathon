import 'dart:async';
import 'dart:convert';
import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/data/base_api_v1.dart';
import 'package:biblosphere/src/data/mapper/book_essentials_mapper.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:http/http.dart' as http;
import 'package:biblosphere/src/domain/entities/book_essential.dart';
import 'package:http_parser/http_parser.dart';

mixin RecognizePhotoRequest on BaseApiV1 {
  @override
  Future<Either<Iterable<BookEssential>>> recognizePhoto(
    String path,
  ) {
    final completer = Completer<Either<Iterable<BookEssential>>>();

    http.MultipartFile.fromPath(
      'photo',
      path,
      contentType: MediaType('image', 'jpeg'),
    ).then((file) {
      http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/recognize_photo'),
      )
        ..files.add(file)
        ..headers.addAll(defaultHeaders)
        ..send().then((response) {
          if (response.statusCode == 200) {
            response.stream.transform(utf8.decoder).listen((source) {
              final jsons = (jsonDecode(source) as List).cast<Map>();
              final books = jsons.map(
                (json) => BookEssentialApiMapper.fromJson(json.cast()),
              );
              completer.complete(Either.success(books));
            });
          } else {
            throw AppError.network;
          }
        }).catchError((e) {
          final error = (e is AppError) ? e : AppError.network;
          completer.complete(Either.error(error));
        });
    });

    return completer.future;
  }
}
