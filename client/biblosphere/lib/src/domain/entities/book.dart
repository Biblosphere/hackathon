import 'package:equatable/equatable.dart';

class Book extends Equatable {
  const Book({
    required this.author,
    required this.title,
    this.description,
    this.pages,
    this.imageUrl,
  });

  final String author;
  final String title;
  final String? description;
  final int? pages;
  final String? imageUrl;

  @override
  List<Object?> get props => [author, title, description, pages, imageUrl];
}
