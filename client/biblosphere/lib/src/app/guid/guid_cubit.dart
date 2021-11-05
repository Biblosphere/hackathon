import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/book_essential.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/domain/repo/book_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class GuidState extends Equatable {
  const GuidState();
}

class LoadingState extends GuidState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

class LoadedState extends GuidState {
  const LoadedState({required this.books});

  final Iterable<Book> books;

  @override
  List<Object?> get props => [books];
}

class ErrorState extends GuidState {
  const ErrorState({required this.error});

  final AppError error;

  @override
  List<Object?> get props => [error];
}

class GuidCubit extends Cubit<GuidState> {
  GuidCubit(
    this._likeBooks,
    this._dislikeBooks,
    this._bookRepo,
  ) : super(_initialState) {
    handleReloadTap();
  }

  final Iterable<BookEssential> _likeBooks;
  final Iterable<BookEssential> _dislikeBooks;
  final BookRepo _bookRepo;

  static const _initialState = LoadingState();

  void handleReloadTap() async {
    emit(const LoadingState());
    final eitherBooks =
        await _bookRepo.getRecomendedBooks(_likeBooks, _dislikeBooks);
    if (eitherBooks.success) {
      emit(LoadedState(books: eitherBooks.data!));
    } else {
      emit(ErrorState(error: eitherBooks.error!));
    }
  }
}
