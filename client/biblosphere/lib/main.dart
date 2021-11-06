import 'dart:async';
import 'package:biblosphere/src/app/app.dart';
import 'package:biblosphere/src/data/api/api_v1.dart';
import 'package:biblosphere/src/data/api/api_v2.dart';
import 'package:biblosphere/src/data/repo/book_repo.dart';
import 'package:biblosphere/src/domain/entities/config.dart';
import 'package:biblosphere/src/domain/repo/book_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(
    () {
      final config = Config.dev();
      return runApp(MultiRepositoryProvider(
        providers: [
          RepositoryProvider<BookRepo>(
            create: (_) => BookRepoImpl(
              ApiV1Impl(config: config.apiConfigV1),
              ApiV2Impl(config: config.apiConfigV2),
            ),
          ),
        ],
        child: const App(),
      ));
    },
    (error, stackTrace) => debugPrint('$error'),
  );
}
