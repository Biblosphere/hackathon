import 'package:equatable/equatable.dart';

class BookEssential extends Equatable {
  const BookEssential({required this.author, required this.title});

  final String author;
  final String title;

  @override
  List<Object?> get props => [author, title];
}
