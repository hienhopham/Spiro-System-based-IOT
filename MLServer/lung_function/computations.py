import numpy as np

import learning

class ExtractValues():

    @staticmethod
    def computeVolume(flr1, flr2, delta_t):
        a = float(flr2 - flr1) / float(delta_t)
        return (flr1 * delta_t + a * (delta_t**2) / 2)

    @classmethod
    def getInputValues(cls, pef_model, fef_model, eng_curve, frm_times):
        max_eng = np.max(eng_curve)
        delta_t = frm_times[1] - frm_times[0]

        total_eng_arr = []
        total_eng = 0
        for i in np.arange(eng_curve.size - 1):
            total_eng = total_eng + \
                cls.computeVolume(eng_curve[i], eng_curve[i + 1], delta_t)
            total_eng_arr.append(total_eng)

        total_eng_arr = np.array(total_eng_arr)
        total_eng_25 = 0.25 * total_eng
        total_eng_50 = 0.5 * total_eng
        total_eng_75 = 0.75 * total_eng

        gap_arr_25 = np.abs(total_eng_arr - total_eng_25)
        gap_arr_50 = np.abs(total_eng_arr - total_eng_50)
        gap_arr_75 = np.abs(total_eng_arr - total_eng_75)

        i_max = np.where(eng_curve == max_eng)[0][0]
        i_25 = np.where(gap_arr_25 == np.min(gap_arr_25))[0][0] + 1
        if(i_25 == i_max):
            i_25 = i_max - 1
        i_50 = np.where(gap_arr_50 == np.min(gap_arr_50))[0][0] + 1
        i_75 = np.where(gap_arr_75 == np.min(gap_arr_75))[0][0] + 1

        eng_25 = eng_curve[i_25]
        eng_50 = eng_curve[i_50]
        eng_75 = eng_curve[i_75]

        PEF = learning.predict_2(max_eng, pef_model.params)
        FEF_25 = learning.predict_2(eng_25, fef_model.params)
        FEF_50 = learning.predict_2(eng_50, fef_model.params)
        FEF_75 = learning.predict_2(eng_75, fef_model.params)

        times = np.array([0, frm_times[i_25], frm_times[i_max], frm_times[i_50], frm_times[i_75], frm_times[frm_times.size - 1]])
        flow_rates = np.array([0, FEF_25, PEF, FEF_50, FEF_75, 0])

        total_volume = 0
        for i in np.arange(times.size - 1):
            total_volume = total_volume + cls.computeVolume(flow_rates[i], flow_rates[i + 1], times[i + 1] - times[i])

        return max_eng, total_volume

    @classmethod
    def getOutputValues(cls, pef_model, fef_model, fvc_model, fev1_model, eng_curve, frm_times):
        eng_curve = np.array(eng_curve)
        frm_times = np.array(frm_times)
        max_eng, total_volume = cls.getInputValues(pef_model, fef_model, eng_curve, frm_times)

        PEF = learning.predict_2(max_eng, pef_model.params)
        FVC = learning.predict_2(total_volume, fvc_model.params)
        FEV1 = learning.predict_2(total_volume, fev1_model.params)

        flow_curve = eng_curve * PEF / max_eng
        volumes = np.linspace(0, FVC, eng_curve.size)

        return PEF, FVC, FEV1, flow_curve, volumes
