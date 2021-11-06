import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/domain/repo/book_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class InitialState extends SearchState {
  const InitialState();

  @override
  List<Object?> get props => [];
}

class LoadingState extends SearchState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

class LoadedState extends SearchState {
  const LoadedState({
    required this.book,
    required this.loading,
    required this.finish,
  });

  final Iterable<Book> book;
  final bool loading;
  final bool finish;

  @override
  List<Object?> get props => [book, loading, finish];
}

class ErrorState extends SearchState {
  const ErrorState({required this.error});

  final AppError error;

  @override
  List<Object?> get props => [error];
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._bookRepo) : super(const InitialState());

  final BookRepo _bookRepo;

  static const _initialBookCount = 3;
  static const _stepBookCount = 3;

  var _search = '';

  Future<void> onSearchChanged(String search) async {
    _search = search;
    if (search.isEmpty) return emit(const InitialState());
    emit(const LoadingState());
    final either = await _bookRepo.searchBooks(search, _initialBookCount);
    if (search == _search) {
      if (either.success) {
        emit(LoadedState(
          book: either.data!,
          loading: false,
          finish: false,
        ));
      } else {
        emit(ErrorState(error: either.error!));
      }
    }
  }

  Future<void> onLoadUpBooks() async {
    final state = this.state as LoadedState;
    final currentSearch = _search;
    emit(LoadedState(
      book: state.book,
      loading: true,
      finish: false,
    ));
    final either = await _bookRepo.searchBooks(
      _search,
      state.book.length + _stepBookCount,
    );
    if (currentSearch == _search) {
      if (either.success) {
        emit(LoadedState(
          book: either.data!,
          loading: false,
          finish: state.book.length == either.data!.length,
        ));
      } else {
        emit(ErrorState(error: either.error!));
      }
    }
  }
}
