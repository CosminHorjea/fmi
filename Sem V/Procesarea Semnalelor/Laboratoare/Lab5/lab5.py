# Horjea Cosmin-Marian
# Grupa 343, Laborator 5, 16 Dec, ora 18:00

import numpy as np
import matplotlib.pyplot as plt
import scipy.signal as sig

# ex 1


def dreptunghiulara(N):
    return np.ones(N)


def hanning(N):
    return 0.5 * (1 - np.cos(2 * np.pi * np.arange(N) / N))


def hamming(N):
    return 0.54 - 0.46 * np.cos(2 * np.pi * np.arange(N) / N)


def blackman(N):
    return (
        0.42
        - 0.5 * np.cos(2 * np.pi * np.arange(N) / N)
        + 0.08 * np.cos(4 * np.pi * np.arange(N) / N)
    )


def flattop(N):
    return (
        0.22
        - 0.42 * np.cos(2 * np.pi * np.arange(N) / N)
        + 0.28 * np.cos(4 * np.pi * np.arange(N) / N)
        - 0.08 * np.cos(6 * np.pi * np.arange(N) / N)
        + 0.007 * np.cos(8 * np.pi * np.arange(N) / N)
    )


def sine(freq, time):
    return np.sin(2 * np.pi * freq * time)


N = 64
rectangle_window = dreptunghiulara(N)
hanning_window = hanning(N)
hamming_window = hamming(N)
blackman_window = blackman(N)
flattop_window = flattop(N)

windows = [
    (rectangle_window, "Dreptunghiulara"),
    (hanning_window, "Hanning"),
    (hamming_window, "Hamming"),
    (blackman_window, "Blackman"),
    (flattop_window, "Flattop"),
]

plt.subplots_adjust(hspace=1.0)

for i, (win, name) in enumerate(windows):
    w, h = sig.freqz(win)
    plt.subplot(3, 2, i + 1)
    plt.title(name)
    plt.plot(w, 20 * np.log10(np.abs(h) + 1))

plt.show()

# ex 2
f = open("trafic.csv", "r", encoding="utf-8-sig")
data = list(map(int, f.readlines()))

# a)
data_fft = np.abs(np.fft.fft(data))

plt.plot(data_fft)
plt.show()

# b)
# Un semnal este esationat o data la 3600 de secunde
# frecventa fs este de 1/3600
# frecventa de Nyquist este fs/2 => 1/7200
# 
# putem considera orele mai aglomerate din zi atunci cand oamenii merg/ies de la serviciu, deci orele 8 si 17 sunt mai aglomerate
# adica sunt doua ore de aglomeratie in fiecare zi
# care ar fi 1/12 din toate zilele esationate

cut_off = (1 / 3600) * (1 / 12)
cut_off_normalized = cut_off / (1/7200)
print(cut_off_normalized)

# c)
order = 5
rp = 5
butter_1, butter_2 = sig.butter(order, cut_off_normalized)
cheby_1, cheby_2 = sig.cheby1(order, rp, cut_off_normalized)

# d)
plt.subplots_adjust(hspace=1.0)

w,h = sig.freqz(butter_1,butter_2)
plt.subplot(3,1,1)
plt.title("Butterworth")
plt.plot(w,20*np.log10(abs(h)+1))
w,h = sig.freqz(cheby_1,cheby_2)
plt.subplot(3,1,2)
plt.title("Chebyshev")
plt.plot(w,20*np.log10(abs(h)+1))
plt.show()

#e)


data_butter = sig.filtfilt(butter_1, butter_2, data)
data_cheby = sig.filtfilt(cheby_1, cheby_2, data)

# alegem doar 200 de esantioane
plt.plot(data[0:200])
plt.plot(data_cheby[0:200])
plt.plot(data_butter[0:200])
plt.legend(["Original", "Chebyshev", "Butter"])


# f

for order in [3,4,5,6]:
    butter_1, butter_2 = sig.butter(order, cut_off_normalized)
    cheby_1, cheby_2 = sig.cheby1(order, rp, cut_off_normalized)
    data_butter = sig.filtfilt(butter_1, butter_2, data)
    data_cheby = sig.filtfilt(cheby_1, cheby_2, data)
    plt.subplot(2, 2, order-2)
    plt.title("Butterworth order: " + str(order))
    plt.plot(data[0:200])
    plt.plot(data_butter[0:200])
    plt.plot(data_cheby[0:200])
    plt.legend(["Original","Butter", "Chebyshev"])
plt.show()

# ordinul 5 pare sa produca resultatele cele mai bune
order = 5

for (i,rp) in enumerate([3,5,7,9]):
    cheby_1, cheby_2 = sig.cheby1(order, rp, cut_off_normalized)
    data_cheby = sig.filtfilt(cheby_1, cheby_2, data)   
    plt.subplot(2, 2, i+1)
    plt.title("Chebyshev rp: " + str(rp))
    plt.plot(data[0:200])
    plt.plot(data_cheby[0:200])
    plt.legend(["Original","Chebyshev"])
plt.show()

#pentru parametrul rp, valuare 7 pare sa produca resultatele cele mai bune
