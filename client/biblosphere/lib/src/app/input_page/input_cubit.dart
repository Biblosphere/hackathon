import 'package:biblosphere/src/domain/entities/book_essential.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/domain/repo/book_essential_repo.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputState extends Equatable {
  const InputState({
    required this.likeBooks,
    required this.dislikeBooks,
    this.scanning = false,
    this.error,
  });

  final Set<BookEssential> likeBooks;
  final Set<BookEssential> dislikeBooks;
  final bool scanning;
  final AppError? error;

  InputState copyWith({
    Set<BookEssential>? likeBooks,
    Set<BookEssential>? dislikeBooks,
    bool? scanning,
    AppError? error,
  }) {
    return InputState(
      likeBooks: likeBooks ?? this.likeBooks,
      dislikeBooks: dislikeBooks ?? this.dislikeBooks,
      scanning: scanning ?? this.scanning,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        likeBooks,
        dislikeBooks,
        scanning,
      ];
}

class InputCubit extends Cubit<InputState> {
  InputCubit(this._bookEssentialRepo) : super(_initialState);

  final BookEssentialRepo _bookEssentialRepo;

  static const _initialState = InputState(
    likeBooks: {},
    dislikeBooks: {},
    scanning: false,
  );

  void handlePhoto(XFile file) async {
    emit(state.copyWith(scanning: true));
    final eitherBookEssentials = await _bookEssentialRepo.recognizePhoto(
      file.path,
    );
    if (eitherBookEssentials.success) {
      final likeBooks = {...state.likeBooks}..addAll(
          eitherBookEssentials.data!.where(
            (e) => !state.dislikeBooks.contains(e),
          ),
        );
      emit(state.copyWith(scanning: false, likeBooks: likeBooks));
    } else {
      emit(state.copyWith(scanning: false, error: eitherBookEssentials.error));
    }
  }

  void handleAddLikeBook(BookEssential book) {
    if (!state.dislikeBooks.contains(book)) {
      emit(state.copyWith(likeBooks: {...state.likeBooks}..add(book)));
    }
  }

  void handleAddDislikeBook(BookEssential book) {
    if (!state.likeBooks.contains(book)) {
      emit(state.copyWith(dislikeBooks: {...state.dislikeBooks}..add(book)));
    }
  }

  void handleReplaceBookToLike(BookEssential book) {
    emit(state.copyWith(
      likeBooks: {...state.likeBooks}..add(book),
      dislikeBooks: {...state.dislikeBooks}..remove(book),
    ));
  }

  void handleReplaceBookToDislike(BookEssential book) {
    emit(state.copyWith(
      likeBooks: {...state.likeBooks}..remove(book),
      dislikeBooks: {...state.dislikeBooks}..add(book),
    ));
  }

  void handleRemoveLikeBook(BookEssential book) {
    emit(state.copyWith(
      likeBooks: {...state.likeBooks}..remove(book),
      dislikeBooks: state.dislikeBooks,
    ));
  }

  void handleRemoveDislikeBook(BookEssential book) {
    emit(state.copyWith(
      likeBooks: state.likeBooks,
      dislikeBooks: {...state.dislikeBooks}..remove(book),
    ));
  }
}
