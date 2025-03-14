import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '1' 
from tensorflow.keras.models import Model
from tensorflow.keras.layers import Input,Dense,LeakyReLU,BatchNormalization
from sklearn.model_selection import train_test_split
from matplotlib import pyplot

class Autoencoder:

    def __init__(self,data,optimizer,activation,loss,epochs,batch_size):
        self.data = data
        self.optimizer = optimizer
        self.activation = activation
        self.loss = loss
        self.epochs = epochs
        self.batch_size = batch_size
    
    def add_dense_layer(self,size):
        def layer(x):
            x = Dense(size)(x)
            x = BatchNormalization()(x)
            x = LeakyReLU()(x)
            return x
        return layer
    
    def add_bootleneck_layer(self,size):
        def layer(x):
            x = Dense(size)(x)
            return x
        return layer
    
    def add_input_layer(self,n_inputs):
        return Input(shape=(n_inputs,))
    
    def add_output_layer(self,n_outputs):
        def layer(x):
            x = Dense(n_outputs, activation=self.activation)(x)
            return x
        return layer
    
    def get_autoencoder(self):
        n_inputs = self.data.shape[1]
        
        #endcoder
        input = self.add_input_layer(n_inputs)
        e = self.add_dense_layer(n_inputs*2)(input)
        e = self.add_dense_layer(n_inputs)(e)

        n_bottleneck = round(float(n_inputs) / 10.0)
        e = self.add_bootleneck_layer(n_bottleneck)(e)

        #decoder
        d = self.add_dense_layer(n_inputs)(e)
        d = self.add_dense_layer(n_inputs*2)(d)
        output = self.add_output_layer(n_inputs)(d)

        model = Model(inputs=input, outputs=output)
        model.compile(optimizer=self.optimizer, loss=self.loss)
        self.autoencoder = model

        return model
    
    def split_data(self):
        X_train, X_test = train_test_split(self.data, test_size=0.2, random_state=42)
        return X_train, X_test
    
    def fit_autoencoder(self):
        X_train, X_test = self.split_data()
        history = self.autoencoder.fit(X_train, X_train, epochs=self.epochs, batch_size=self.batch_size, verbose=2, validation_data=(X_test,X_test))
        
        pyplot.plot(history.history['loss'], label='train')
        pyplot.plot(history.history['val_loss'], label='test')
        pyplot.legend()
        pyplot.show()



    
