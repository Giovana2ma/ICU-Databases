import itertools
import concurrent.futures
import csv

class Model():
    def __init__(self,data,model,score,fit_predict,parameters):
        self.data = data
        self.model = model
        self.score = score
        self.fit_predict = fit_predict
        self.parameters = parameters
        self.best_score = -1
        self.best_params = None

    def get_param_comb(self):
        self.param_comb = list(itertools.product(*self.parameters.values()))
        return self.param_comb

    def set_train(self,X_train,y_train):
        self.X_train = X_train
        self.y_train = y_train
    
    def set_test(self,X_test,y_test):
        self.X_test = X_test
        self.y_test = y_test
    
    def evaluate_model(self, params):
        param_dict = dict(zip(self.parameters.keys(), params))

        # try: 
        labels = self.fit_predict(
            self.model.__class__() ,
            param_dict,
            X_test = self.X_test,
            X_train = self.X_train,
            y_train = self.y_train,
        )
        score = self.score(self.y_test, labels)
        
        return score, param_dict, labels
        
        # except Exception as e:
        #     print(self.model.__class__.__name__,param_dict)
        #     return 0,{},[]
        

    def grid_search(self,filename, n_jobs=16):
        self.get_param_comb()
        self.results = []

        with concurrent.futures.ProcessPoolExecutor(max_workers=n_jobs) as executor:
            results = list(executor.map(self.evaluate_model, self.param_comb))

        with open(filename, mode='w', newline='') as file:
            writer = csv.DictWriter(file, fieldnames=['params', 'score'])
            writer.writeheader()

            for score, param_dict, labels in results:
                writer.writerow({'params': str(param_dict), 'score': score})  

        for score, param_dict, labels in results:
            if score > self.best_score:
                self.best_score = score
                self.best_params = param_dict
                self.labels = labels

        return self.results
                

    



    






    