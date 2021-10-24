import flask
from flask import Flask, request
from healthcheck import HealthCheck
import os, joblib, logging
import numpy as np
import pandas as pd
from implicit.nearest_neighbours import CosineRecommender


logging.basicConfig(format='%(message)s', level=logging.INFO)
app = Flask(__name__)

logging.info('=== LOGGING: Start to load models')
books = pd.read_csv('data/books.csv', low_memory=False).drop('Unnamed: 0', axis=1)
books.set_index('recId', inplace=True)
interactions = pd.read_csv('data/interactions.csv', low_memory=False).drop(['Unnamed: 0', 'date'], axis=1)
model = joblib.load('model/model_cosine_k5')
id_to_itemid = joblib.load('model/id_to_itemid')
id_to_userid = joblib.load('model/id_to_userid')
itemid_to_id = joblib.load('model/itemid_to_id')
userid_to_id = joblib.load('model/userid_to_id')
sparse_user_item = joblib.load('model/sparse_user_item')
logging.info('=== LOGGING: All models loaded succcessfully')



def howami():
    return True, "I'm Biblosphere Team's application. I am alive. Thanks for checking.."

health = HealthCheck(app, "/hcheck")
health.add_check(howami)


@app.route('/')
def hello():
    return "Welcome to Biblosphere Team's application. You can find documentation hear:..."


def model_predictions(user_id):
    try:
        id = userid_to_id[user_id]
    except:
        return [] # для пользователей о ком ничего не делаем рекомендаций. В будущем можно будет рекомендовать топ или собирать их предпочтения
    
    recs = model.recommend(userid=id, 
                        user_items=sparse_user_item.tocsr(),   # на вход user-item matrix
                        N=5, 
                        filter_already_liked_items=True, 
                        filter_items=None, 
                        recalculate_user=False)
    return [id_to_itemid[rec[0]] for rec in recs]



def get_history(use_id):
    return list(interactions.loc[interactions['user_id'] == use_id]['item_id'].values)


def get_json_books(ids: [int]):
    result = []
    for id in ids:
        book = books.loc[str(id)]
        result.append({"id": str(id), "title": book['title'], "author": book['aut']})
    return result


# api methods   

@app.route('/recommend/<user_id>', methods=['GET'])
def recommend(user_id):
    logging.info(f'=== LOGGING: Recieved user_id {user_id}')  
    
    user_id = int(user_id) 
    preds = model_predictions(user_id)
    logging.info(f'=== LOGGING: preds {preds}')  
    
    history = get_history(user_id)
    result = {"recommendations": get_json_books(preds), "history": get_json_books(history)}   
    logging.info(f'=== LOGGING: Prepared answer: {result}') 
     
    resp = flask.jsonify(result)
    resp.headers.add('Access-Control-Allow-Origin', '*')
    
    return resp
    



if __name__ == "__main__":
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 5000)))
