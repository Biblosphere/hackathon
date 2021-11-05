import 'package:biblosphere/src/domain/entities/book_essential.dart';

mixin BookEssentialResource {
  final recBooks = <BookEssential>[
    const BookEssential(
      author: 'Водолазкин Евгений Германович',
      title: 'Брисбен',
    ),
    const BookEssential(
      author: 'Роулинг Джоан Кэтлин',
      title: 'Гарри Поттер и Кубок огня',
    ),
    const BookEssential(
      author: 'Брэдбери Рэй Дуглас',
      title: 'О скитаньях вечных и о Земле',
    ),
    const BookEssential(
      author: 'Акунин Борис',
      title: 'Просто Маса',
    ),
    const BookEssential(
      author: 'Боуэн Риз',
      title: 'На поле Фарли',
    ),
    const BookEssential(
      author: 'Пушкин Александр Сергеевич',
      title: 'Стихотворения',
    ),
    const BookEssential(
      author: 'Гачев Георгий Дмитриевич',
      title: 'Философия быта как бытия',
    ),
    const BookEssential(
      author: 'Пришвин Михаил Михайлович',
      title: 'Кладовая солнца',
    ),
    const BookEssential(
      author: 'Мамин-Сибиряк Дмитрий Наркисович',
      title: 'Аленушкины сказки',
    ),
    const BookEssential(
      author: 'Каплан Макс',
      title: 'Свен - храброе сердце',
    ),
  ];
}
