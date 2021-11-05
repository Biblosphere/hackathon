import 'package:equatable/equatable.dart';

class NewBook extends Equatable {
  const NewBook({
    required this.id,
    required this.author,
    required this.title,
  });

  final String id;
  final String author;
  final String title;

  @override
  List<Object?> get props => [id, author, title];
}

class NewBooks extends Equatable {
  const NewBooks({required this.history, required this.recommendations});

  final Iterable<NewBook> history;
  final Iterable<NewBook> recommendations;
  @override
  List<Object?> get props => [history, recommendations];
}
