import 'package:biblosphere/src/domain/entities/new_book.dart';

extension NewBookMapper on NewBook {
  static const _idKey = 'id';
  static const _authorkey = 'author';
  static const _titleKey = 'title';

  static NewBook fromJson(Map<String, dynamic> json) {
    final author = json[_authorkey];
    final title = json[_titleKey];
    return NewBook(
      id: json[_idKey] as String,
      author: author is String ? author : '',
      title: title is String ? title : '',
    );
  }
}

extension NewBooksMapper on NewBooks {
  static const _historyKey = 'history';
  static const _recommendationsKey = 'recommendations';
  static NewBooks fromJson(Map<String, dynamic> json) {
    final historyJson = (json[_historyKey] as List).cast<Map>();
    final recommendationsJson = (json[_recommendationsKey] as List).cast<Map>();
    return NewBooks(
      history: historyJson.map(
        (e) => NewBookMapper.fromJson(e.cast<String, dynamic>()),
      ),
      recommendations: recommendationsJson.map(
        (e) => NewBookMapper.fromJson(e.cast<String, dynamic>()),
      ),
    );
  }
}
