import 'package:biblosphere/src/domain/entities/book.dart';

extension BookMapper on Book {
  static const _authorKey = 'author';
  static const _titleKey = 'title';
  static const _descriptionKey = 'description';
  static const _pagesKey = 'pages';
  static const _imageUrlKey = 'image';

  static Book fromJson(Map<String, dynamic> json) {
    return Book(
      author: json[_authorKey] as String,
      title: json[_titleKey] as String,
      description: json[_descriptionKey] as String?,
      pages: json[_pagesKey] as int?,
      imageUrl: json[_imageUrlKey] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _authorKey: author,
      _titleKey: title,
      if (description != null) _descriptionKey: description,
      if (pages != null) _pagesKey: pages,
      if (imageUrl != null) _imageUrlKey: imageUrl,
    };
  }
}

extension BooksMapper on Iterable<Book> {
  static Iterable<Book> fromJson(String key, Map<String, dynamic> json) {
    final internalJsons = (json[key] as List).cast<Map>();
    return internalJsons.map((e) => BookMapper.fromJson(e.cast()));
  }
}
