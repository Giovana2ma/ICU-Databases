from model import *
import numpy as np
import pandas as pd
from sklearn.cluster import KMeans
from sklearn.cluster import DBSCAN
from hdbscan import HDBSCAN
from sklearn.mixture import GaussianMixture
from sklearn.metrics import silhouette_score

def generate_data(n_samples=30, n_features=5, random_state=42):
    np.random.seed(random_state)
    X = np.random.rand(n_samples, n_features)
    return pd.DataFrame(X, columns=[f'feature_{i}' for i in range(n_features)])
    
def prepare_model(model,parameters,**kwargs):
    model.set_params(**parameters)
    X_train = kwargs.get("X_train")
    return model.fit_predict(X_train)

def define_model(data,model,parameters):
    model = Model(data,model,silhouette_score,prepare_model,parameters)
    model.set_train(data,data)
    model.set_test(data,data)
    return model

def train_models():
    data = generate_data()
    
    models = [
        (KMeans(), {
            'n_clusters': list(range(2, 11)),
            'init': ['k-means++', 'random'],
            'max_iter': [100, 200, 300],
            'tol': [1e-4, 1e-3, 1e-2],
            'algorithm': ['elkan', 'lloyd']
        }),
        (DBSCAN(), {
            'eps': [0.1, 0.3, 0.5, 0.7, 1.0],
            'min_samples': [3, 5, 10, 15],
            'metric': ['euclidean', 'manhattan', 'cosine'],
            'algorithm': ['auto', 'ball_tree', 'kd_tree', 'brute']
        }),
        (HDBSCAN(), {
            'min_cluster_size': [5, 10, 15, 20],
            'min_samples': [None, 3, 5, 10],
            'cluster_selection_method': ['eom', 'leaf'],
            'metric': ['euclidean', 'manhattan', 'cosine']
        }),
        (GaussianMixture(), {
            'n_components': list(range(2, 11)),
            'covariance_type': ['full', 'tied', 'diag', 'spherical'],
            'tol': [1e-3, 1e-4, 1e-5],
            'max_iter': [100, 200, 300]
        })
    ]

    for model, params in models:
        m = define_model(data, model, params)
        m.grid_search('nome_do_arquivo')  

def main():

    train_models()
 

if __name__ == '__main__':
    main()
