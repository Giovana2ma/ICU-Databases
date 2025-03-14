import pandas as pd
import numpy as np
import itertools
from sklearn.model_selection import train_test_split

class Model():
    def __init__(self,data,model,score,parameters):
        self.data = data
        self.model = model
        self.score = score
        self.parameters = parameters
        self.best_score = -1
        self.best_params = None

    def get_param_comb(self):
        self.param_comb = list(itertools.product(*self.parameters.values()))
        return self.param_comb
    
    def split_data(self,target):
        X = self.data.drop(columns=[target])
        y = self.data[target]
        X_train, self.X_test, y_train, self.y_test = train_test_split(X, y, test_size=0.2, random_state=42)
        self.data_train = (X_train, y_train)
        return self.data_train, self.X_test, self.y_test
    
    def get_train_test(self):
        self.data_train = (self.data)
        self.y_test = self.data
        self.X_test = self.data

    def fit(self,parameters):
        self.model.set_params(**parameters)  # Set model parameters
        self.model.fit(*self.data_train)  # Fit the model

    def predict(self):
        return self.model.predict(self.X_test)
    
    def grid_search(self):
        self.get_param_comb()

        for params in self.param_comb:
            param_dict = dict(zip(self.parameters.keys(), params))
            
            self.fit(param_dict)
            labels = self.predict()
            score = self.score(self.y_test, labels)
            
            if score > self.best_score:
                self.best_score = score
                self.best_params = param_dict


    






    