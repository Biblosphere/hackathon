import 'package:biblosphere/src/core/selectable_value.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/resource/resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColdStartState extends Equatable {
  const ColdStartState({
    required this.recommendedBooks,
    this.manualBooks = const {},
    this.error,
  });

  factory ColdStartState.initial() {
    final books = Resource.instance.recommendedBooks;
    final recommendedBooks = books.map(
      (book) => SelectableValue(
        value: book,
        isSelected: false,
      ),
    );
    return ColdStartState(recommendedBooks: recommendedBooks);
  }

  final Iterable<SelectableValue<Book>> recommendedBooks;
  final Set<Book> manualBooks;
  final AppError? error;

  @override
  List<Object?> get props => [recommendedBooks, manualBooks, error];
}

class ColdStartCubit extends Cubit<ColdStartState> {
  ColdStartCubit() : super(ColdStartState.initial());

  void onRecommendedBookChanged(Book book, bool isSelected) {
    final oldSelectableBook = state.recommendedBooks.firstWhere(
      (e) => e.value == book,
    );
    final newSelectableBook = SelectableValue(
      value: book,
      isSelected: isSelected,
    );
    emit(ColdStartState(
      recommendedBooks: {...state.recommendedBooks}
        ..remove(oldSelectableBook)
        ..add(newSelectableBook),
      manualBooks: state.manualBooks,
    ));
  }

  void onAddManualBook(Book book) {
    emit(ColdStartState(
      recommendedBooks: state.recommendedBooks,
      manualBooks: {...state.manualBooks, book},
    ));
  }

  void onRemoveManualBook(Book book) {
    emit(ColdStartState(
      recommendedBooks: state.recommendedBooks,
      manualBooks: {...state.manualBooks}..remove(book),
    ));
  }
}
