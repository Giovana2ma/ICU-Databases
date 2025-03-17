from model import *
import numpy as np
import pandas as pd
from sklearn.experimental import enable_iterative_imputer
from sklearn.impute import SimpleImputer, KNNImputer, IterativeImputer
import miceforest as mf
from sklearn.metrics import silhouette_score
from sklearn.datasets import make_classification, make_blobs
from sklearn.model_selection import train_test_split

def generate_data(rows=1000, cols=5, missing_percentage=0.1, seed=None):
    """
    Generates a dataset with missing values.
    
    Parameters:
    - rows: Number of rows in the dataset.
    - cols: Number of columns in the dataset.
    - missing_percentage: Fraction of values to be set as NaN (between 0 and 1).
    - seed: Random seed for reproducibility.

    Returns:
    - DataFrame with missing values.
    """
    if seed is not None:
        np.random.seed(seed)

    # Generate random data
    data = np.random.rand(rows, cols)

    # Introduce missing values
    total_values = rows * cols
    missing_count = int(total_values * missing_percentage)
    
    # Select random indices to replace with NaN
    missing_indices = np.random.choice(total_values, missing_count, replace=False)
    data.ravel()[missing_indices] = np.nan
    
    # Create DataFrame
    df = pd.DataFrame(data, columns=[f'feature_{i+1}' for i in range(cols)])
    df.insert(0, 'id', np.arange(1, rows + 1))
    
    return df

def split_data(X,test_size=0.3, random_state=42):
    X_train = X.melt(id_vars=['id'])
    X_train = X_train.dropna()

    np.random.seed(random_state)  
    n_missing = int(len(X_train) * test_size)
    missing_indices = np.random.choice(X_train.index, n_missing, replace=False)
    X_test = X_train.copy()
    X_test = X_test.loc[missing_indices]
    X_train.loc[missing_indices, 'value'] = np.nan
    
    X_train = X_train.pivot(index='id', columns='variable', values='value')
    X_train = X_train.reset_index()


    return X_train, X_test

def score(y_test,y_pred):
    # print(y_pred)
    y_pred = y_pred.melt(id_vars=['id'])
    merged = y_test.merge(y_pred, on=['id', 'variable'], suffixes=('_true', '_pred'))
    return np.sqrt(np.mean((merged['value_true'] - merged['value_pred']) ** 2))

def prepare_model(model,parameters,**kwargs):
    model.set_params(**parameters)
    X_train = kwargs.get("X_train")
    
    transformed = model.fit_transform(X_train)
    transformed = pd.DataFrame(transformed,columns = X_train.columns)
    return transformed

def define_model(data,model,parameters):
    model = Model(data,model,score,prepare_model,parameters)

    X_train,X_test = split_data(data,test_size=0.2, random_state=42)
    model.set_train(X_train,X_train)
    model.set_test(X_test,X_test)
    return model

def train_models():
    data = generate_data()
    
    models = [
        
        # KNN Imputer
        (KNNImputer(), {
            'n_neighbors': [3, 5, 7, 10],
            'weights': ['uniform', 'distance'],
            'metric': ['nan_euclidean']
        }),

        # Iterative Imputer (MICE - Multiple Imputation by Chained Equations)
        (IterativeImputer(), {
            'max_iter': [5, 10, 20],
            'initial_strategy': ['mean', 'median', 'most_frequent'],
            'imputation_order': ['ascending', 'descending', 'random']
        }),
        
        # MICEForest (Multiple Imputation using LightGBM)
        # (mf.ImputationKernel, {
        #     'datasets': [1, 3, 5],  # Number of datasets to generate
        #     'categorical_feature': [None],  # List of categorical column names
        #     'save_all_iterations': [True, False],  # Whether to keep all iterations
        #     'mean_match_candidates': [5, 10],  # Number of closest matches for filling missing values
        #     'random_state': [42]  # Ensures reproducibility
        # })
    ]


    for model, params in models:
        m = define_model(data, model, params)
        m.grid_search('nome_do_arquivo')  

def main():

    train_models()
 

if __name__ == '__main__':
    main()
