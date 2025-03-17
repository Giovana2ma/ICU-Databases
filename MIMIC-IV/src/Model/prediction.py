from model import *
import numpy as np
import pandas as pd
from xgboost import XGBClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.neural_network import MLPClassifier
from sklearn.metrics import silhouette_score
from sklearn.datasets import make_classification, make_blobs
from sklearn.model_selection import train_test_split



def generate_data(n_samples=1000, n_features=10, n_classes=2, n_clusters=3, random_state=42):
    np.random.seed(random_state)

    # Generate classification data
    X_class, y_target = make_classification(n_samples=n_samples, n_features=n_features, 
                                            n_classes=n_classes, random_state=random_state)

    # Generate clustering data (only two features for clustering visualization)
    X_cluster, y_cluster = make_blobs(n_samples=n_samples, centers=n_clusters, 
                                      n_features=2, random_state=random_state)

    # Convert to DataFrame
    feature_columns = [f'feature_{i}' for i in range(n_features)]
    df = pd.DataFrame(X_class, columns=feature_columns)

    # Add target and cluster columns
    df['target'] = y_target
    df['cluster'] = y_cluster

    return df

    
def prepare_model(model,parameters,**kwargs):
    model.set_params(**parameters)
    X_train = kwargs.get("X_train")
    y_train = kwargs.get("y_train")
    X_test = kwargs.get("X_test")
    model.fit(X_train,y_train)
    return model.predict(X_test)

def define_model(data,model,parameters):
    model = Model(data,model,silhouette_score,prepare_model,parameters)

    X = data.drop(columns=['target', 'cluster'])
    y = data['target']

    X_train, X_test,y_train,y_test = train_test_split(X,y,test_size=0.2, random_state=42)
    model.set_train(X_train,y_train)
    model.set_test(X_test,y_test)
    return model

def train_models():
    data = generate_data()
    
    models = [
        (XGBClassifier(), {
            'n_estimators': [50, 100, 200, 300],
            'max_depth': [3, 5, 7, 10],
            'learning_rate': [0.01, 0.05, 0.1, 0.2],
            'subsample': [0.7, 0.8, 0.9, 1.0],
            'colsample_bytree': [0.7, 0.8, 0.9, 1.0],
            'gamma': [0, 1, 5, 10]
        }),

        (RandomForestClassifier(), {
            'n_estimators': [50, 100, 200, 300],
            'max_depth': [None, 10, 20, 30],
            'min_samples_split': [2, 5, 10],
            'min_samples_leaf': [1, 2, 4],
            'bootstrap': [True, False]
        }),

        (LogisticRegression(), {
            'penalty': ['l1', 'l2', 'elasticnet', None],
            'C': [0.01, 0.1, 1, 10, 100],
            'solver': ['liblinear', 'lbfgs', 'saga'],
            'max_iter': [100, 200, 300]
        }),

        (MLPClassifier(), {
            'hidden_layer_sizes': [(50,), (100,), (50, 50), (100, 100)],
            'activation': ['relu', 'tanh', 'logistic'],
            'solver': ['adam', 'sgd'],
            'alpha': [0.0001, 0.001, 0.01],
            'learning_rate': ['constant', 'adaptive'],
            'max_iter': [200, 300, 500]
        }),
    ]

    for model, params in models:
        for cluster in data['cluster'].unique():
            m = define_model(data[data['cluster'] == cluster], model, params)
            m.grid_search('nome_do_arquivo')  

def main():

    train_models()
 

if __name__ == '__main__':
    main()
