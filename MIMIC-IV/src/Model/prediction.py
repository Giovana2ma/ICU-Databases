from model import *
import pandas as pd
from sklearn.cluster import KMeans
from sklearn.cluster import DBSCAN
from hdbscan import HDBSCAN
from sklearn.mixture import GaussianMixture
from sklearn.metrics import silhouette_score

def define_model(data,model,parameters):
    model = Model(data,model,silhouette_score,parameters)
    model.set_train((data,))
    model.set_test(data,data)
    return model

def train_models():
    data = pd.read_csv('/scratch/haniel.botelho/physionet.org/files/mimiciv/2.2/Data24h/variables_count.csv')
    
    models = [
        (KMeans(), {
            'n_clusters': list(range(2, 11)),
            'init': ['k-means++', 'random'],
            'max_iter': [100, 200, 300],
            'tol': [1e-4, 1e-3, 1e-2],
            'algorithm': ['auto', 'full', 'elkan']
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
        results = m.grid_search()  

        results = pd.DataFrame(results)
        results.to_csv(f'MIMIC-IV/Data/Results/clustering_results_{model.__class__.__name__}.csv', index=False)



def main():

    data = pd.read_csv('/scratch/haniel.botelho/physionet.org/files/mimiciv/2.2/Data24h/variables_count.csv')
    param_kmeans = {'n_clusters': [2, 3, 4], 'init': ['k-means++', 'random']}
    kmeans = define_model(data,KMeans(),param_kmeans)
    kmeans.grid_search()

    return 

if __name__ == '__main__':
    main()
