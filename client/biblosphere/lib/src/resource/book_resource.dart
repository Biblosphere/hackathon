import 'package:biblosphere/src/domain/entities/book.dart';

mixin BookResource {
  final recommendedBooks = <Book>[
    const Book(
      author: 'Водолазкин Евгений Германович',
      title: 'Брисбен',
    ),
    const Book(
      author: 'Роулинг Джоан Кэтлин',
      title: 'Гарри Поттер и Кубок огня',
    ),
    const Book(
      author: 'Брэдбери Рэй Дуглас',
      title: 'О скитаньях вечных и о Земле',
    ),
    const Book(
      author: 'Акунин Борис',
      title: 'Просто Маса',
    ),
    const Book(
      author: 'Боуэн Риз',
      title: 'На поле Фарли',
    ),
    const Book(
      author: 'Пушкин Александр Сергеевич',
      title: 'Стихотворения',
    ),
    const Book(
      author: 'Гачев Георгий Дмитриевич',
      title: 'Философия быта как бытия',
    ),
    const Book(
      author: 'Пришвин Михаил Михайлович',
      title: 'Кладовая солнца',
    ),
    const Book(
      author: 'Мамин-Сибиряк Дмитрий Наркисович',
      title: 'Аленушкины сказки',
    ),
    const Book(
      author: 'Каплан Макс',
      title: 'Свен - храброе сердце',
    ),
  ];
}
