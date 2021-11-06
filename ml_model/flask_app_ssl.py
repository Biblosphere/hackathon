# -*- coding: utf-8 -*-
import flask
from flask import Flask, request
from healthcheck import HealthCheck
import os, joblib, logging
import numpy as np
import pandas as pd
from implicit.nearest_neighbours import CosineRecommender
import json


logging.basicConfig(format='%(message)s', level=logging.INFO)
app = Flask(__name__)

logging.info('=== LOGGING: Start to load models')
books = pd.read_csv('data/books.csv', low_memory=False).drop('Unnamed: 0', axis=1)
books.set_index('recId', inplace=True)
interactions = pd.read_csv('data/interactions.csv', low_memory=False).drop(['Unnamed: 0', 'date'], axis=1)
model = joblib.load('model/model_cosine_k5')
model_similars = joblib.load('model/similars.als') 
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

def random_top5_predictions():
    books = [417745,
             324421,
             8440,
             2001117,
             1929725,
             1698929,
             64857,
             1559762,
             1869334,
             853191,
             2026753,
             324729,
             1794029,
             22839,
             321881,
             1139,
             1600049,
             11418,
             1282,
             57777,
             2114,
             1553823,
             1081090,
             1541464,
             1813722,
             1519330,
             63798,
             1599851,
             1554269,
             1772151,
             733483,
             617751,
             1554739,
             1554090,
             1847862,
             1159213,
             1127207,
             1697349,
             60804,
             1569093,
             31637,
             15572,
             1196114,
             66908,
             2102267,
             25630]
    
    return np.random.choice(books, 5)
    



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


def model_similarity(ids):
    
    res = []
    
    for id_ in ids:
        if id_ in itemid_to_id:
            similar_items = model.similar_items(itemid_to_id[id_], N=4)
            similar_items = similar_items[1:]
            similar_items = [id_to_itemid[sim[0]] for sim in similar_items]
            print('sims:', similar_items)
            res.append(similar_items)
    
    res = [i for sublist in res for i in sublist]
    return res


def get_history(use_id):
    return list(interactions.loc[interactions['user_id'] == use_id]['item_id'].values)


def get_json_books(ids: [int]):
    result = []
    for id in ids:
        book = books.loc[str(id)]
        result.append({"id": str(id), "title": book['title'], "author": book['aut']})
    return result


# api methods   

@app.route('/recommend/<user_id>', methods=['OPTIONS'])
def recommend_options(user_id):
    logging.info(f'=== LOGGING: METHOD recommend')  
    logging.info(f'=== LOGGING: Recieved method OPTIONS')  
    logging.info(f'=== LOGGING: Recieved user_id {user_id}')  
    headers = request.headers
    logging.info(f'=== LOGGING: Recieved headers {headers}') 
     
    resp = flask.jsonify("")
    resp.headers.add('Access-Control-Allow-Origin', 'https://biblosphere.web.app')
    resp.headers.add('Access-Control-Allow-Methods', 'POST, GET, OPTIONS')
    resp.headers.add('Access-Control-Allow-Headers', 'X-PINGOTHER, Content-Type')
    resp.headers.add('Access-Control-Max-Age', '86400')
    resp.headers.add('Vary', 'Accept-Encoding, Origin')
    
    # Access-Control-Allow-Origin: https://foo.example
    # Access-Control-Allow-Methods: POST, GET, OPTIONS
    # Access-Control-Allow-Headers: X-PINGOTHER, Content-Type
    # Access-Control-Max-Age: 86400
    # Vary: Accept-Encoding, Origin
    
    
    return resp

@app.route('/recommend/<user_id>', methods=['GET'])
def recommend(user_id):
    logging.info(f'=== LOGGING: METHOD recommend')  
    logging.info(f'=== LOGGING: Recieved user_id {user_id}')  
    
    user_id = int(user_id) 
    preds = model_predictions(user_id)
    logging.info(f'=== LOGGING: preds {preds}')  
    
    history = get_history(user_id)
    result = {"recommendations": get_json_books(preds), "history": get_json_books(history)}   
    logging.info(f'=== LOGGING: Prepared answer: {result}') 
     
    resp = flask.jsonify(result)
    resp.headers.add('Access-Control-Allow-Origin', '*')
    #resp.headers.add('Access-Control-Allow-Origin', 'https://biblosphere.web.app')
    
    return resp

@app.route('/recommend_by_books/', methods=['OPTIONS'])
def recommend_by_books_options():
    logging.info(f'=== LOGGING: METHOD recommend')  
    logging.info(f'=== LOGGING: Recieved method OPTIONS')  
    headers = request.headers
    logging.info(f'=== LOGGING: Recieved headers {headers}') 
     
    resp = flask.jsonify("")
    resp.headers.add('Access-Control-Allow-Origin', 'https://biblosphere.web.app')
    resp.headers.add('Access-Control-Allow-Methods', 'POST, GET, OPTIONS')
    resp.headers.add('Access-Control-Allow-Headers', 'X-PINGOTHER, Content-Type')
    resp.headers.add('Access-Control-Max-Age', '86400')
    resp.headers.add('Vary', 'Accept-Encoding, Origin')
    
    return resp

@app.route('/recommend_by_books/', methods=['POST'])
def recommend_by_books():
    logging.info(f'=== LOGGING: METHOD recommend_by_books')  
    logging.info(f'=== LOGGING: {request.data}')  
    headers = request.headers
    ## logging.info(f'=== LOGGING: Recieved headers {headers}')
    
    params = request.get_json()
    if params is None or 'ids' not in params:
        params = json.loads(request.data)
    print('!!!DEBUG:input params:', params)
    
    ids = params['ids']
    print('!!!DEBUG:input ids:', ids)
    
    # Please replace hardcoded predictions with REAL ONES
    # preds = model_predictions(user_id)
    # preds = [862378, 468165, 733184, 2881187, 2884177]
    #preds = random_top5_predictions()
    
    #ids = [862378, 468165, 733184, 2881187, 2884177] 
    preds2 = model_similarity(ids)
    preds = preds2
    
    if len(preds) == 0:
        preds = random_top5_predictions()
    
    logging.info(f'=== LOGGING: testing preds2 {preds2}') 
    
    logging.info(f'=== LOGGING: preds {preds}')  
    
    result = {"recommendations": get_json_books(preds), "history": []}   
    logging.info(f'=== LOGGING: Prepared answer: {result}') 
     
    resp = flask.jsonify(result)
    resp.headers.add('Access-Control-Allow-Origin', '*')
    #resp.headers.add('Access-Control-Allow-Origin', 'https://biblosphere.web.app')
    
    return resp


# @app.route('/recommend_by_books/', methods=['POST'])
# def recommend_by_books():
#     logging.info(f'=== LOGGING: METHOD recommend_by_books')  
#     logging.info(f'=== LOGGING: {request.data}')  
    
#     # Please replace hardcoded predictions with REAL ONES
#     # preds = model_predictions(user_id)
#     # preds = [862378, 468165, 733184, 2881187, 2884177]
#     preds = random_top5_predictions()
#     logging.info(f'=== LOGGING: preds {preds}')  
    
#     result = {"recommendations": get_json_books(preds), "history": []}   
#     logging.info(f'=== LOGGING: Prepared answer: {result}') 
     
#     resp = flask.jsonify(result)
#     resp.headers.add('Access-Control-Allow-Origin', '*')
#     #resp.headers.add('Access-Control-Allow-Origin', 'https://biblosphere.web.app')
    
#     return resp



if __name__ == "__main__":
    # To support adhock SSL
    #app.run(ssl_context='adhoc', host='0.0.0.0', port=int(os.environ.get('PORT', 5001)))
    # To support real SSL certificate (waiting for cert file)
    app.run(ssl_context=('ssl.cert', 'ssl.key'), host='0.0.0.0', port=int(os.environ.get('PORT', 5001)))
    #app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 5001)))
