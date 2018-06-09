import os

INT16_FAC = (2**15)-1
INT32_FAC = (2**31)-1
INT64_FAC = (2**63)-1

AUDIO_FOLDER = os.path.normpath(os.path.join(os.path.abspath(os.path.dirname(__file__)), 'spiro_wave'))

# For extracting curve
TOTAL_TIME = 4 # Audio file long
START_TIME = 0.3 # 
RATIO_NOISE = 0.09
SMOOTH_PARAMETER = 5

# For audio processing
LOWER_BOUND_FREQ = 100
HIGHER_BOUND_FREQ = 3000

WINDOW_SIZE = 401
FFT_SIZE = 4096
HOP_SIZE = 200

