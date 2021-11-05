import 'package:biblosphere/src/domain/entities/book_essential.dart';

extension BookEssentialApiMapper on BookEssential {
  static const _authorKey = 'author';
  static const _titleKey = 'title';

  static BookEssential fromJson(Map<String, dynamic> json) {
    return BookEssential(
      author: json[_authorKey] as String,
      title: json[_titleKey] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      _authorKey: author,
      _titleKey: title,
    };
  }
}

extension BookEssentialsApiMapper on Iterable<BookEssential> {
  static const _booksKey = 'books';

  static Iterable<BookEssential> fromJson(Map<String, dynamic> json) {
    final jsons = (json[_booksKey] as Iterable).cast<Map>();
    return jsons.map(
      (json) => BookEssentialApiMapper.fromJson(json.cast<String, dynamic>()),
    );
  }
}
