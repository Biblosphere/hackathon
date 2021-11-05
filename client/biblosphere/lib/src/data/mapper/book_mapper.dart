import 'package:biblosphere/src/domain/entities/book.dart';

extension BookMapper on Book {
  static const _titleKey = 'title';
  static const _authorKey = 'author';
  static const _descriptionKey = 'description';
  static const _pagesKey = 'pages';
  static const _imageUrlKey = 'image';

  static Book fromJson(Map json) {
    return Book(
      title: json[_titleKey] as String,
      author: json[_authorKey] as String,
      description: json[_descriptionKey] as String,
      pages: json[_pagesKey] as int,
      imageUrl: json[_imageUrlKey] as String?,
    );
  }
}

extension BooksMapper on Iterable<Book> {
  static const _booksKey = 'books';

  static Iterable<Book> fromJson(Map json) {
    return (json[_booksKey] as List).map((e) => BookMapper.fromJson(e));
  }
}
