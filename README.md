# hackathon
__Biblosphere team__

Code for book recommendation solution for Moscow mayor hackathon 2021

## Running app
Running ml model is working in Google cloud platform (GCP)

Link example: `http://35.209.30.42:5000/recommend/1188`

## Source

1. `ml_model/` - contains code for build, train and deploy ML model

2. `ml_model/train_model.ipynb` - contans general algorithm description, model trainig and testing

3. `ml_model/build_dataset.ipynb` - contains code for prepare datasets for train ml model

4. `ml_model\flask_app.py` - flask app code

5. `ml_model/check.ipynb` - contains code for check how app works in realtime

6. `create_tables_MySQL.ipynb` - contains code for creation MySQL database

7. `filter_predictions.ipynb` - contains code for filtration for recommendations

There are not datasets, trained models in this repository 
