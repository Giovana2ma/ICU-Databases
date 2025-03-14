import numpy as np
import pandas as pd
from autoencoder import *

np.random.seed(42)
X = np.random.rand(1000, 20)  # Generate random features between 0 and 1
data = pd.DataFrame(X, columns=[f'feature_{i}' for i in range(20)])

optimizer = 'adam'
activation = 'linear'
loss = 'mse'
epochs = 20
batch_size = 10

autoencoder = Autoencoder(data,optimizer,activation,loss,epochs,batch_size)
autoencoder.get_autoencoder()
autoencoder.fit_autoencoder()