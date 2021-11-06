import 'package:biblosphere/src/domain/entities/book.dart';

mixin BookResource {
  final recommendedBooks = <Book>[
    const Book(
      id: 3967,
      author: 'Достоевский Федор Михайлович',
      title: 'Преступление и наказание',
    ),
    const Book(
      id: 55035,
      author: 'Андерсен Ханс Кристиан',
      title: 'Сказки',
    ),
    const Book(
      id: 53675,
      author: 'Сент-Экзюпери Антуан де',
      title: 'Маленький принц',
    ),
    const Book(
      id: 24301,
      author: 'Твен Марк',
      title: 'Приключения Тома Сойера',
    ),
    const Book(
      id: 417745,
      author: 'Водолазкин Евгений Германович',
      title: 'Брисбен',
    ),
    const Book(
      id: 1892,
      author: 'Драгунский Виктор Юзефович',
      title: 'Денискины рассказы',
    ),
    const Book(
      id: 5234,
      author: 'Сетон-Томпсон Эрнест',
      title: 'Рассказы о животных',
    ),
    const Book(
      id: 249165,
      author: 'Барба Стефан',
      title: 'Все о воспитании и здоровье ребенка от А до Я',
    ),
    const Book(
      id: 1912028,
      author: 'Спиридонов Максим Юрьевич',
      title: 'Стартап на миллиард',
    ),
    const Book(
      id: 1261447,
      author: 'Аузан Александр Александрович',
      title: 'Экономика всего',
    ),
    const Book(
      id: 213,
      author: 'Вентцель Елена Сергеевна',
      title: 'Теория вероятностей',
    ),
  ];
}
