# Lab 6  |  6 Ianuarie 2022
# Horjea Cosmin-Marian 343
# Grupa 3a
import numpy as np
from dictlearn import DictionaryLearning, methods
from matplotlib import image
from sklearn.feature_extraction.image import extract_patches_2d, reconstruct_from_patches_2d
from sklearn.preprocessing import normalize
p = 8
s = 6 
N = 1000
n = 256
K = 50
sigma = 0.075

def psnr(img1,img2):
	mse = np.mean((img1-img2)**2)
	if mse == 0:
		return 0
	max_pixel = 255
	psnr= 20 * np.log10(max_pixel / np.sqrt(mse))
	return psnr


I = image.imread('barbara.png')
print(len(I),len(I[0]))


Inoisy = I + sigma*np.random.randn(I.shape[0],I.shape[1])

Ynoisy = extract_patches_2d(I, (8,8))

Ynoisy = Ynoisy.reshape(Ynoisy.shape[0],-1)

Y = np.random.choice(Ynoisy.shape[1],N)

D0 = np.random.randn(Ynoisy.shape[0],n)
# np.random.randn()
# dict are aacelasi nr de linii ca y noisy iar nr de colone e nr de atomi "n" adica 256
# D0 = normalize(D0,axis=0,norm='max')

dl = DictionaryLearning(
	n_components=n,
	max_iter=K,
	fit_algorithm='ksvd',
	n_nonzero_coefs=s,
	code_init=None,
	dict_init=D0,
	params=None,
	data_sklearn_compat=False
)


dl.fit(Ynoisy[:,Y])
D = dl.D_
# Y = Y.reshape(-1,1)
# dl.fit(Y)
# D= dl.D_
# Xc = reconstruct_from_patches_2d(Ynoisy[:,Y], Ynoisy.shape)

Xc, err = methods.omp(Ynoisy, D, algorithm='omp',n_nonzero_coefs = s)


Xc = Xc.reshape(I.shape)


print(psnr(I,Xc))