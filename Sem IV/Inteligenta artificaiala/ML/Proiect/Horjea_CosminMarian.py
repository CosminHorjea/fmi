
from keras.utils import to_categorical
from keras.layers import Conv2D
from keras.layers import Dense
from keras.models import Sequential
from tensorflow.keras import layers
import tensorflow as tf
from tensorflow import keras
from sklearn.svm import SVC
from sklearn import preprocessing
from sklearn.naive_bayes import GaussianNB
from sklearn.neighbors import KNeighborsClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import SGDClassifier
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from sklearn.metrics import confusion_matrix, plot_confusion_matrix
from sklearn.neural_network import MLPClassifier
import pandas as pd

# Citire de date

X_train, y_train = [], []
with open('train.txt') as f:
    for l in f.readlines():
        img_id, label = l.split(',')
        curr_img = mpimg.imread('./train/'+img_id)
        X_train.append(curr_img)
        y_train.append(int(label[0]))
X_train = np.array(X_train)
y_train = np.array(y_train)
X_train = X_train.reshape(len(X_train), 32*32)

X_test, y_test = [], []
with open('validation.txt') as f:
    for l in f.readlines():
        img_id, label = l.split(',')
        curr_img = mpimg.imread('./validation/'+img_id)
        # print('./train/'+img_id)
        X_test.append(curr_img)
        y_test.append(int(label[0]))
X_test = np.array(X_test)
y_test = np.array(y_test)
X_test = X_test.reshape(len(X_test), 32*32)

print(len(X_test))

#Standardizam datele
scaler = preprocessing.StandardScaler()
scaler.fit(X_train)

X_train, X_test = scaler.fit_transform(X_train), scaler.fit_transform(X_test)

#Clasificator Naive Bayes
clfGaussian = GaussianNB()
clfGaussian.fit(X_train, y_train)

clfGaussian.score(X_test, y_test)

# Clasificator KNN
clfKNN = KNeighborsClassifier(n_neighbors=20)
clfKNN.fit(X_train, y_train)
clfKNN.score(X_test, y_test)

#variem parametrul n
for k in [1, 5, 10, 20, 50]:
    clfKNN = KNeighborsClassifier(n_neighbors=k)
    clfKNN.fit(X_train, y_train)
    print('k=', k, ' score=', clfKNN.score(X_test, y_test))

#Clasificator random forest
clfRandomForest = RandomForestClassifier(max_depth=50, random_state=1)
clfRandomForest.fit(X_train, y_train)
clfRandomForest.score(X_test, y_test)

#variem parametrul depth
for depth in [10, 25, 50, 100]:
    clfForest = RandomForestClassifier(max_depth=depth, random_state=1)
    clfForest.fit(X_train, y_train)

    print('d= ', depth, ' score= ', clfForest.score(X_test, y_test))

# Clasificator stochastic gradient descent
sgd_clf = SGDClassifier(random_state=1, verbose=10)
sgd_clf.fit(X_train, y_train)
sgd_clf.score(X_test, y_test)

#variem functiile de Loss
for lossFun in ['hinge', 'log', 'modified_huber', 'squared_hinge', 'perceptron']:
    sgd_clf = SGDClassifier(loss=lossFun, random_state=1, verbose=10)
    sgd_clf.fit(X_train, y_train)
    print('loss= ', lossFun, 'Score= ', sgd_clf.score(X_test, y_test))

#Clasificator cu multi layer perceptrons
clfMLP = MLPClassifier(hidden_layer_sizes=(
    100, 100, 100,), random_state=1, max_iter=100, verbose=10).fit(X_train, y_train)
clfMLP.score(X_test, y_test)

#afisam matricea de confuzie
# confMatrix = confusion_matrix(clfMLP.predict(X_test), y_test)
# plt.imshow(confMatrix)
plot_confusion_matrix(clfMLP, X_test, y_test)
plt.show()

#calsificator SVM
clfSVM = SVC(C=1.0, verbose=True, kernel='rbf')
clfSVM.fit(X_train, y_train)
clfSVM.score(X_test, y_test)

# confMatrix = confusion_matrix(clfSVM.predict(X_test), y_test)
# plt.imshow(confMatrix)
plot_confusion_matrix(clfSVM, X_test, y_test)
plt.show()

# Creeare fisier de Submit

X_final = []
names_final = []
with open('test.txt') as f:
    for l in f.readlines():
        img_id = l
        names_final.append(img_id[:-1])
        curr_img = mpimg.imread('./test/'+img_id[:-1])
        X_final.append(curr_img)

X_final = np.array(X_final)
X_final = X_final.reshape(len(X_final), 32*32)
X_final = scaler.transform(X_final)

#salvam predictiile intr-un array preds
preds = []
preds = clfSVM.predict(X_final)  # trebuie schimbat numele pentru clasificator
results = pd.DataFrame({'id': names_final, 'label': preds})#salvam un datafram cu id-ul imaginii si label-ul prezis

g = open("", "w")
g.write(results.to_csv(index=False))


# Tensorflow

X_train, y_train = [], []
with open('train.txt') as f:
    for l in f.readlines():
        img_id, label = l.split(',')
        curr_img = tf.keras.preprocessing.image.load_img(
            './train/'+img_id, color_mode="grayscale")
        curr_img = keras.preprocessing.image.img_to_array(curr_img)
        X_train.append(curr_img)
        y_train.append(int(label[0]))

X_test, y_test = [], []
with open('validation.txt') as f:
    for l in f.readlines():
        img_id, label = l.split(',')
        curr_img = tf.keras.preprocessing.image.load_img(
            './validation/'+img_id, color_mode="grayscale")
        curr_img = keras.preprocessing.image.img_to_array(curr_img)
        X_test.append(curr_img)
        y_test.append(int(label[0]))


X_train = np.array(X_train)
X_test = np.array(X_test)
y_train = np.array(y_train)
y_test = np.array(y_test)

# aducem valorile intre 0 si 1
X_train /= 255
X_test /= 255

#trebuie sa folosim to_categorical pentru a antrena modelul
y_train = to_categorical(y_train)
y_test = to_categorical(y_test)


clfKeras = Sequential()
clfKeras.add(Conv2D(32, (3, 3), activation='relu', padding='same'))
clfKeras.add(Conv2D(64, (3, 3), activation='relu', padding='same'))
clfKeras.add(keras.layers.Flatten())
clfKeras.add(Dense(100, activation='relu'))
clfKeras.add(Dense(9, activation='softmax'))

clfKeras.compile(loss='categorical_crossentropy',
                 optimizer='adam', metrics=['accuracy'])

clfKeras.fit(X_train, y_train, epochs=20, validation_data=(
    X_test, y_test), batch_size=512)

# Output keras
X_final = []
names_final = []
with open('test.txt') as f:
    for l in f.readlines():
        img_id = l[:-1]
        names_final.append(img_id[:-1])
        curr_img = tf.keras.preprocessing.image.load_img(
            './test/'+img_id, color_mode="grayscale")
        curr_img = keras.preprocessing.image.img_to_array(curr_img)
        X_final.append(curr_img)

X_final = np.array(X_final)

X_final /= 255

preds = []

predictss = np.argmax(clfKeras.predict(X_final), axis=1)

results = pd.DataFrame({'id': names_final, 'label': preds})
g = open("resultsKeras", "w")
g.write(results.to_csv(index=False))

confMatrix = confusion_matrix(preds, np.argmax(y_test, axis=-1))
plt.imshow(confMatrix)
