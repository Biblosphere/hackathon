import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/domain/repo/book_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IdRecommendationState extends Equatable {
  const IdRecommendationState();
}

class LoadingState extends IdRecommendationState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

class LoadedState extends IdRecommendationState {
  const LoadedState({required this.books});

  final Iterable<Book> books;

  @override
  List<Object?> get props => [books];
}

class ErrorState extends IdRecommendationState {
  const ErrorState({required this.error});

  final AppError error;

  @override
  List<Object?> get props => [error];
}

class IdRecommendationCubit extends Cubit<IdRecommendationState> {
  IdRecommendationCubit(this._id, this._bookRepo)
      : super(const LoadingState()) {
    _initilize();
  }

  final String _id;
  final BookRepo _bookRepo;

  Future<void> _initilize() async {
    emit(const LoadingState());
    final either = await _bookRepo.getRecommendationsById(_id);
    if (either.success) {
      emit(LoadedState(books: either.data!));
    } else {
      emit(ErrorState(error: either.error!));
    }
  }

  Future<void> onReload() async {
    return _initilize();
  }
}
