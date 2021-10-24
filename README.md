# hackathon
__Biblosphere team__

Code for book recommendation solution for Moscow mayor hackathon 2021

## Запущенное приложение для проверки
Запущенное приложение работает на Google Cloud Platform (GCP). Но может быть легко развернуто на других облачных платформах.

Пример ссылки: `http://35.209.30.42:5000/recommend/2222`

`2222` - это id читателя.

Инструкция по установке и запуску: `install.md`

## Предсказания

`recommendations.csv` - содержит 5 рекомендаций для каждого пользователя.


## Исходный код

1. `ml_model/` - Содержит код для формирования датасетов, обучения модели и развертывания модели.

2. `ml_model/train_model.ipynb` - Содержит описание общего алгоритма решения, а также код по тренировке и тестированию модели.

3. `ml_model/build_dataset.ipynb` - Содержит код подготовки датасетов для обучения модели.

4. `ml_model/flask_app.py` - Приложение на Flask, которое обеспечивает работу модели в виде REST API сервиса.

5. `ml_model/check.ipynb` - Содержит ноутбук для удобной проверки работающего приложения. 



## Датасеты и сохраненная модель

Файлы `data/data_1.zip`, `data/data_2.zip` содержит наши датасеты, сформированные для обучения модели (после распаковки из архива файлы должны лежать в директории `data/`):

1. `books.csv` - свернутый датасет книг

2. `books_map.csv` - соответствие recId каждой книги из исходного датасета в recId в свернутом датасете

3. `interactions.csv` - датасет взаимодействий пользователей и книг


Файл `model/model.zip` содержит файлы модели, используемые для предсказания в приложении flask (после распаковки из архива файлы должны лежать в директории `model/`):

1. `model_cosine_k5` - обученная модель

2. `sparse_user_item` - матрица users-items построенная на основании датасета `interactions.csv`

3. `userid_to_id`, `id_to_userid` - в модели id пользователей были перекодированы, файлы содержат соответствия для кодирования и раскодирования этих id

4. `itemid_to_id`, `id_to_itemid` - в модели id книг были перекодированы, файлы содержат соответствия для кодирования и раскодирования этих id

## Инструкция по запуску приложения
Наше приложение развернуто на GCP и доступно по ссылке http://35.209.30.42:5000

Пример предсказания: http://35.209.30.42:5000/recommend/2222

Но это приложение также легко можно запустить Yandex.Cloud, AWS или на собственном сервере.

Для удобства использования в продакшене удобнее будет упаковать приложение в контейнер Docker или упаковать в Kubernates. В нашей реализации мы этого не делали.

Как запустить текущее приложение
Установить библиотеки в файле ml_model/requirements.txt

Скопировать на сервер необходимые файлы:

ml_model/flask_app.py - скрипт приложения
архивы data.zip, model.zip и распаковать их
Запустить приложение командой python flask_app.py.

На запускаемом сервере должен быть открыт порт 5000

Проверить, что приложение откликается по адресу <your_url:5000> или <your_url:5000/hcheck>. Выполнить тестовую рекомендацию по ссылке http://35.209.30.42:5000/recommend/2222
