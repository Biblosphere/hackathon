import 'package:biblosphere/src/domain/entities/book_essential.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/domain/repo/book_essential_repo.dart';
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
    required this.bookEssentials,
    required this.loading,
    required this.finish,
  });

  final Iterable<BookEssential> bookEssentials;
  final bool loading;
  final bool finish;

  @override
  List<Object?> get props => [bookEssentials, loading, finish];
}

class ErrorState extends SearchState {
  const ErrorState({required this.error});

  final AppError error;

  @override
  List<Object?> get props => [error];
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required BookEssentialRepo bookEssentialRepo})
      : _bookEssentialRepo = bookEssentialRepo,
        super(const InitialState());

  final BookEssentialRepo _bookEssentialRepo;

  static const _initialBookCount = 3;
  static const _stepBookCount = 3;

  var _search = '';

  Future<void> onSearchChanged(String search) async {
    search = search.trim();
    _search = search;
    if (search.isEmpty) return emit(const InitialState());
    emit(const LoadingState());
    final either =
        await _bookEssentialRepo.searchTopBooks(search, _initialBookCount);
    if (search == _search) {
      if (either.success) {
        emit(LoadedState(
          bookEssentials: either.data!,
          loading: false,
          finish: false,
        ));
      } else {
        emit(ErrorState(error: either.error!));
      }
    }
  }

  Future<void> onMoreButtonTap() async {
    final state = this.state as LoadedState;
    final currentSearch = _search;
    emit(LoadedState(
      bookEssentials: state.bookEssentials,
      loading: true,
      finish: false,
    ));
    final either = await _bookEssentialRepo.searchTopBooks(
      _search,
      state.bookEssentials.length + _stepBookCount,
    );
    if (currentSearch == _search) {
      if (either.success) {
        emit(LoadedState(
          bookEssentials: either.data!,
          loading: false,
          finish: state.bookEssentials.length == either.data!.length,
        ));
      } else {
        emit(ErrorState(error: either.error!));
      }
    }
  }
}
