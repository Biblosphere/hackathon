import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/domain/entities/new_book.dart';
import 'package:biblosphere/src/domain/repo/new_book_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NewGuidState extends Equatable {
  const NewGuidState();
}

class LoadingState extends NewGuidState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

class LoadedState extends NewGuidState {
  const LoadedState({required this.newBooks});

  final Iterable<NewBook> newBooks;

  @override
  List<Object?> get props => [newBooks];
}

class ErrorState extends NewGuidState {
  const ErrorState({required this.error});

  final AppError error;

  @override
  List<Object?> get props => [error];
}

class NewGuidCubit extends Cubit<NewGuidState> {
  NewGuidCubit(this._userId, this._newBookRepo) : super(_initialState) {
    _initilize();
  }

  final String _userId;
  final NewBookRepo _newBookRepo;

  static const _initialState = LoadingState();

  Future<void> _initilize() async {
    emit(const LoadingState());
    final either = await _newBookRepo.getNewBooks(_userId);
    if (either.success) {
      emit(LoadedState(newBooks: either.data!.recommendations));
    } else {
      emit(ErrorState(error: either.error!));
    }
  }

  Future<void> handleReloadButtonTap() async {
    return _initilize();
  }
}
