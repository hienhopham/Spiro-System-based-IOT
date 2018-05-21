import numpy as np
import math
import os
import copy
from scipy.fftpack import fft, ifft
from scipy.io.wavfile import write, read
from scipy.signal import get_window
# import matplotlib.pyplot as plt
import constants
tol = 1e-14
norm_fact = {'int16': constants.INT16_FAC, 'int32': constants.INT32_FAC,
    'int64': constants.INT64_FAC, 'float32': 1.0, 'float64': 1.0}

def isPower2(num):
	"""
	Check if num is power of two
	"""
	return ((num & (num - 1)) == 0) and num > 0


def wavread(filename):
	"""
	Read a sound file and convert it to a normalized floating point array
	filename: name of file to read
	returns fs: sampling rate of file, x: floating point array
	"""

	if (os.path.isfile(filename) == False):                  # raise error if wrong input file
		raise ValueError("Input file is wrong")

	fs, x = read(filename)

	if (len(x.shape) != 1):                                   # raise error if more than one channel
		raise ValueError("Audio file should be mono")

	# scale down and convert audio into floating point number in range of -1 to 1
	x = np.float16(x) / norm_fact[x.dtype.name]
	return fs, x


def wavwrite(y, fs, filename):
	"""
	Write a sound file from an array with the sound and the sampling rate
	y: floating point array of one dimension, fs: sampling rate
	filename: name of file to create
	"""

	x = copy.deepcopy(y)                         # copy array
	# scaling floating point -1 to 1 range signal to int16 range
	x *= INT16_FAC
	x = np.int16(x)                              # converting to int16 type
	write(filename, fs, x)


def dftAnal(x, w, N):
	"""
	Analysis of a signal using the discrete Fourier transform
	x: input signal, w: analysis window, N: FFT size
	returns mX, pX: magnitude and phase spectrum
	"""

	if not(isPower2(N)):                                 # raise error if N not a power of two
		raise ValueError("FFT size (N) is not a power of 2")

	if (w.size > N):                                        # raise error if window size bigger than fft size
		raise ValueError("Window size (M) is bigger than FFT size")

	# size of positive spectrum, it includes sample 0
	hN = (N // 2) + 1
	# half analysis window size by rounding
	hM1 = (w.size + 1) // 2
	# half analysis window size by floor
	hM2 = w.size // 2
	# initialize buffer for FFT
	fftbuffer = np.zeros(N)
	# normalize analysis window
	w = w / sum(w)
	xw = x * w                                                # window the input sound
	# zero-phase window in fftbuffer
	fftbuffer[:hM1] = xw[hM2:]
	fftbuffer[-hM2:] = xw[:hM2]
	X = fft(fftbuffer)                                      # compute FFT
	# compute ansolute value of positive side
	absX = abs(X[:hN])
	absX[absX < np.finfo(float).eps] = np.finfo(
	    float).eps    # if zeros add epsilon to handle log
	# magnitude spectrum of positive frequencies in dB
	mX = 20 * np.log10(absX)
	# for phase calculation set to 0 the small values
	X[:hN].real[np.abs(X[:hN].real) < tol] = 0.0
	# for phase calculation set to 0 the small values
	X[:hN].imag[np.abs(X[:hN].imag) < tol] = 0.0
	# unwrapped phase spectrum of positive frequencies
	pX = np.unwrap(np.angle(X[:hN]))
	return mX, pX


def dftSynth(mX, pX, M):
	"""
	Synthesis of a signal using the discrete Fourier transform
	mX: magnitude spectrum, pX: phase spectrum, M: window size
	returns y: output signal
	"""

	# size of positive spectrum, it includes sample 0
	hN = mX.size
	N = (hN - 1) * 2                                            # FFT size
	# raise error if N not a power of two, thus mX is wrong
	if not(isPower2(N)):
		raise ValueError("size of mX is not (N/2)+1")

	# half analysis window size by rounding
	hM1 = int(math.floor((M + 1) / 2))
	# half analysis window size by floor
	hM2 = int(math.floor(M / 2))
	# initialize buffer for FFT
	fftbuffer = np.zeros(N)
	# initialize output array
	y = np.zeros(M)
	Y = np.zeros(N, dtype=complex)                        # clean output spectrum
	# generate positive frequencies
	Y[:hN] = 10**(mX / 20) * np.exp(1j * pX)
	# generate negative frequencies
	Y[hN:] = 10**(mX[-2:0:-1] / 20) * np.exp(-1j * pX[-2:0:-1])
	fftbuffer = np.real(ifft(Y))                            # compute inverse FFT
	# undo zero-phase window
	y[:hM2] = fftbuffer[-hM2:]
	y[hM2:] = fftbuffer[:hM1]
	return y


def stftAnal(x, w, N, H):
	"""
	Analysis of a sound using the short-time Fourier transform
	x: input array sound, w: analysis window, N: FFT size, H: hop size
	returns xmX, xpX: magnitude and phase spectra
	"""
	if (H <= 0):                                   # raise error if hop size 0 or negative
		raise ValueError("Hop size (H) smaller or equal to 0")

	M = w.size                                      # size of analysis window
	# half analysis window size by rounding
	hM1 = (M + 1) // 2
	# half analysis window size by floor
	hM2 = M // 2
	# add zeros at beginning to center first window at sample 0
	x = np.append(np.zeros(hM2), x)
	# add zeros at the end to analyze last sample
	x = np.append(x, np.zeros(hM2))
	# initialize sound pointer in middle of analysis window
	pin = hM1
	pend = x.size - hM1                               # last sample to start a frame
	w = w / sum(w)                                  # normalize analysis window
	while pin <= pend:                                # while sound pointer is smaller than last sample
		# select one frame of input sound
		x1 = x[pin - hM1:pin + hM2]
		mX, pX = dftAnal(x1, w, N)              # compute dft
		if pin == hM1:                              # if first frame create output arrays
			xmX = np.array([mX])
			xpX = np.array([pX])
		else:                                       # append output to existing array
			xmX = np.vstack((xmX, np.array([mX])))
			xpX = np.vstack((xpX, np.array([pX])))
		pin += H                                    # advance sound pointer
	return xmX, xpX


def stftSynth(mY, pY, M, H):
	"""
	Synthesis of a sound using the short-time Fourier transform
	mY: magnitude spectra, pY: phase spectra, M: window size, H: hop-size
	returns y: output sound
	"""
	hM1 = (M + 1) // 2                                   # half analysis window size by rounding
	# half analysis window size by floor
	hM2 = M // 2
	nFrames = mY[:, 0].size                           # number of frames
	y = np.zeros(nFrames * H + hM1 + hM2)              # initialize output array
	pin = hM1
	for i in range(nFrames):                         # iterate over all frames
		y1 = dftSynth(mY[i, :], pY[i, :], M)       # compute idft
		# overlap-add to generate output sound
		y[pin - hM1:pin + hM2] += H * y1
		pin += H                                     # advance sound pointer
	# delete half of first window which was added in stftAnal
	y = np.delete(y, range(hM2))
	# delete the end of the sound that was added in stftAnal
	y = np.delete(y, range(y.size - hM1, y.size))
	return y

def energy(mX):
    linear = 10 ** (mX/20)
    min_linear = -1e-6
    linear[abs(linear) < 1e-6] = 1e-6
    e = np.sum(linear**2, 1)
    eDB = 10 * np.log10(e)
    return eDB

def computeEngEnv(inputFile, window, M, N, H):

    (fs, x) = wavread(inputFile)
    w = get_window(window, M)

    low_bound = int(math.ceil(float(constants.LOWER_BOUND_FREQ) * N/fs))
    high_bound = int(math.ceil(float(constants.HIGHER_BOUND_FREQ) * N/fs))

    mX, pX = stftAnal(x, w, N, H)

    mX[:,:low_bound] = -120
    mX[:,high_bound:] = -120
    pX[:,:low_bound] = 0
    pX[:,high_bound:] = 0

    # y = stftSynth(mX, pX, M, H)
    # wavwrite(y, fs, '/home/hienpham/'+os.path.basename(inputFile)[:-4] + '_synth.wav')

    engEnv = energy(mX)
    frmTime = H*np.arange(int(mX.shape[0]))/float(fs) 

    return engEnv,frmTime
