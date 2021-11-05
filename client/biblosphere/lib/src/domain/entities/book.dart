import 'package:equatable/equatable.dart';

class Book extends Equatable {
  const Book({
    required this.title,
    required this.author,
    required this.description,
    required this.pages,
    required this.imageUrl,
  });

  final String title;
  final String author;
  final String description;
  final int pages;
  final String? imageUrl;

  @override
  List<Object?> get props => [title, author, description, pages, imageUrl];
}
