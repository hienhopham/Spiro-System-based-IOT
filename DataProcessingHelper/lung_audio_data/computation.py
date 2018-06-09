import numpy as np
from scipy.signal import get_window
import baseFunctions as bF
import math
import constants

def smooth(y, box_pts):
	"""
	Smooth an energy curve by take the average of box_pts consecutive points
	"""
    box = np.ones(box_pts)/box_pts
    y_smooth = np.convolve(y, box, mode='same')
    return y_smooth

def cutFlow(flow, t_start, ratio_noise):
	"""
	Cut the flow from when the user starts exhaling to the end of the expiratory.
    flow: floating point array of one dimension
    ratio_noise: the rate that all the smaller values are noise.
	"""

    delta_t = float(constants.TOTAL_TIME)/float(flow.size)
    cutted_points = int(math.floor(t_start/delta_t) + 1)
    cutted_flow = flow[11:-11]

    global_max = np.max(cutted_flow)
    global_min = np.min(cutted_flow)
    i_max = np.where(flow == global_max)[0][0]

    # find the end point form the peak of the flow
    end = i_max
    while end < flow.size:
        if flow[end] <= ratio_noise * global_max + (1 - ratio_noise) * global_min:
            break
        else:
            end = end + 1
    if end == flow.size:
        end = flow.size - 5

    # then find the start point
    start = i_max
    while start > 0:
        if flow[start] < flow[end]:
            break
        else:
            start = start - 1

    return flow[start:end+1]

def getValues(pathFile, M, N, H):

    min_energy = -120
    engEnv, frmTime= bF.computeEngEnv(pathFile, 'hamming', M, N, H)
    engEnv[engEnv < min_energy] = min_energy

    max_energy = np.max(engEnv) - np.min(engEnv)
    max_energy_20 = np.min(engEnv) + 0.2*max_energy
    engEnv[engEnv < max_energy_20] = max_energy_20

    smth_engEnv = smooth(engEnv,constants.SMOOTH_PARAMETER)
    smth_cutted_engEnv = cutFlow(smth_engEnv, constants.START_TIME, constants.RATIO_NOISE)
    smth_cutted_engEnv = smth_cutted_engEnv + np.abs(np.min(smth_cutted_engEnv))
    cutted_frmTime = frmTime[:smth_cutted_engEnv.size]

    return smth_cutted_engEnv, cutted_frmTime
