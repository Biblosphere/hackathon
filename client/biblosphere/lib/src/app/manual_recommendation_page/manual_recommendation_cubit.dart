import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/domain/repo/book_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ManualRecommendationState extends Equatable {
  const ManualRecommendationState();
}

class LoadingState extends ManualRecommendationState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

class LoadedState extends ManualRecommendationState {
  const LoadedState({required this.books});

  final Iterable<Book> books;

  @override
  List<Object?> get props => [books];
}

class ErrorState extends ManualRecommendationState {
  const ErrorState({required this.error});

  final AppError error;

  @override
  List<Object?> get props => [error];
}

class ManualRecommendationCubit extends Cubit<ManualRecommendationState> {
  ManualRecommendationCubit(
    this._books,
    this._bookRepo,
  ) : super(const LoadingState()) {
    onReload();
  }

  final Iterable<Book> _books;
  final BookRepo _bookRepo;

  void onReload() async {
    emit(const LoadingState());
    final eitherBooks = await _bookRepo.getRecomendationsByBooks(_books);
    if (eitherBooks.success) {
      emit(LoadedState(books: eitherBooks.data!));
    } else {
      emit(ErrorState(error: eitherBooks.error!));
    }
  }
}
