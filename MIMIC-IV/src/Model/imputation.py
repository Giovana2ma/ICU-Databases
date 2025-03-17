from model import *
import numpy as np
import pandas as pd
from sklearn.experimental import enable_iterative_imputer
from sklearn.impute import SimpleImputer, KNNImputer, IterativeImputer
import miceforest as mf
from missingpy import MissForest
from sklearn.experimental import enable_iterative_imputer  
from sklearn.impute import IterativeImputer  
from sklearn.linear_model import LinearRegression  
from sklearn.ensemble import RandomForestRegressor  
from sklearn.tree import DecisionTreeRegressor  
from sklearn.neighbors import KNeighborsRegressor  
from xgboost import XGBRegressor 

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
    X_train = X.melt(id_vars=['stay_id'])
    X_train = X_train.dropna()

    np.random.seed(random_state)  
    n_missing = int(len(X_train) * test_size)
    missing_indices = np.random.choice(X_train.index, n_missing, replace=False)
    X_test = X_train.copy()
    X_test = X_test.loc[missing_indices]
    X_train.loc[missing_indices, 'value'] = np.nan
    
    X_train = X_train.pivot(index='stay_id', columns='variable', values='value')
    X_train = X_train.reset_index()


    return X_train, X_test

def score(y_test,y_pred):
    # print(y_pred)
    y_pred = y_pred.melt(id_vars=['stay_id'])
    merged = y_test.merge(y_pred, on=['stay_id', 'variable'], suffixes=('_true', '_pred'))
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
    data_bin = pd.read_csv('MIMIC-IV/Data/Base/base_bin.csv')
    data_bin = data_bin.drop(columns = ['subject_id','hadm_id','antibiotic_time', 'culture_time','suspected_infection_time'])
    
    models = [
        
        # # KNN Imputer
        # (KNNImputer(), {
        #     'n_neighbors': [3, 5, 7, 10],
        #     'weights': ['uniform', 'distance'],
        #     'metric': ['nan_euclidean']
        # }),

        # Iterative Imputer (MICE - Multiple Imputation by Chained Equations)
        (IterativeImputer(), {
            'estimator': [
                None,  # Usa BayesianRidge() como padrão
                LinearRegression(),
                RandomForestRegressor(n_estimators=100),
                DecisionTreeRegressor(),
                KNeighborsRegressor(n_neighbors=5),
                XGBRegressor(objective='reg:squarederror', n_estimators=100)
            ],
            'max_iter': [5, 10]
        }),
        
        # (mf.ImputationKernel(data_bin), {
        #     'n_estimators': [50, 100, 200],  # Número de árvores no Random Forest
        #     'max_depth': [None, 10, 20],  # Profundidade máxima das árvores
        #     'max_features': ['sqrt', 'log2', None]
        # }),
        (MissForest(), {
            'n_estimators': [50, 100, 200],  # Número de árvores na floresta
            'max_depth': [None, 10, 20]  # Profundidade máxima das árvores
        })
    ]


    for model, params in models:
        m = define_model(data_bin, model, params)
        m.grid_search(f'MIMIC-IV/Data/Results/{model.__class__.__name__}_bin.csv')  

def main():

    train_models()
 

if __name__ == '__main__':
    main()
