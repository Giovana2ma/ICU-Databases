import itertools
import concurrent.futures
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
    
    def set_train(self,train):
        self.data_train = train

    def set_test(self,X_test,y_test):
        self.X_test = X_test
        self.y_test = y_test
    
    def fit(self,parameters):
        self.model.set_params(**parameters)  # Set model parameters
        self.model.fit(*self.data_train)  # Fit the model

    def predict(self):
        return self.model.predict(self.X_test)
    
    def evaluate_model(self, params):
        param_dict = dict(zip(self.parameters.keys(), params))

        model_clone = self.model.__class__()  # Create a new instance of the model
        model_clone.set_params(**param_dict)
        model_clone.fit(*self.data_train)
        labels = model_clone.predict(self.X_test)
        score = self.score(self.y_test, labels)
        
        return score, param_dict, labels

    def grid_search(self, n_jobs=16):
        self.get_param_comb()
        self.results = []

        with concurrent.futures.ProcessPoolExecutor(max_workers=n_jobs) as executor:
            results = list(executor.map(self.evaluate_model, self.param_comb))

        for score, param_dict, labels in results:
            self.results.append({'params': param_dict, 'score': score}) 

        for score, param_dict, labels in results:
            if score > self.best_score:
                self.best_score = score
                self.best_params = param_dict
                self.labels = labels

        return self.results
                

    



    






    