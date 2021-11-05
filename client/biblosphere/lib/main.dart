import 'dart:async';
import 'package:biblosphere/src/app/app.dart';
import 'package:biblosphere/src/data/api/api_v1.dart';
import 'package:biblosphere/src/data/api/api_v2.dart';
import 'package:biblosphere/src/data/repo/book_essential_repo.dart';
import 'package:biblosphere/src/data/repo/book_repo.dart';
import 'package:biblosphere/src/data/repo/new_book_repo.dart';
import 'package:biblosphere/src/domain/entities/config.dart';
import 'package:biblosphere/src/domain/repo/book_essential_repo.dart';
import 'package:biblosphere/src/domain/repo/book_repo.dart';
import 'package:biblosphere/src/domain/repo/new_book_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
    () {
      final config = Config.dev();
      final apiV1 = ApiV1Impl(
        baseUrl: config.baseUrlV1,
        defaultHeaders: {...config.defaultHeaders, 'Host': config.hostV1},
      );
      final apiV2 = ApiV2Impl(
        baseUrl: config.baseUrlV2,
        defaultHeaders: {...config.defaultHeaders, 'Host': config.hostV2},
      );
      return runApp(MultiRepositoryProvider(
        providers: [
          RepositoryProvider<NewBookRepo>(
            create: (_) => NewBookRepoImpl(apiV2),
          ),
          RepositoryProvider<BookEssentialRepo>(
            create: (_) => BookEssentialRepoImpl(apiV1),
          ),
          RepositoryProvider<BookRepo>(
            create: (_) => BookRepoImpl(apiV1),
          ),
        ],
        child: const App(),
      ));
    },
    (error, stackTrace) => debugPrint('$error'),
  );
}
