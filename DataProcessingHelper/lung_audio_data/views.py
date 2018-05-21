import datetime
import base64
import os

from django.http import JsonResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from lung_audio_data.serializers import OutputValuesSeralizer
from lung_audio_data.objects import OutputValues

import baseFunctions as bfs
import computation as cp
import constants
import referenceValues


class DataProcessingView(APIView):

    def post(self, request):

        user_infos = ['age', 'height', 'weight']
        results = {}
        
        if 'stream_file' not in request.data:
            return JsonResponse({"error": "stream_file is required"})
        
        if all(info in request.data for info in user_infos):
            age = float(request.data["age"])
            ht = float(request.data["height"])
            wt = float(request.data["weight"])

            results["pred_PEF"] = referenceValues.getPEF(age, ht)
            results["pred_FVC"] = referenceValues.getFVC(age, ht, wt)
            results["pred_FEV1"] = referenceValues.getFEV1(age, ht)

        stream_file = base64.b64decode(request.data["stream_file"])
        now = datetime.datetime.now().strftime('%H.%M.%S')
        filename = constants.AUDIO_FOLDER + '/' + now + '_tmp.wav'

        with open(filename, 'wb+') as f:
            f.write(stream_file)

        eng_curve, frm_times = cp.getValues(filename, constants.WINDOW_SIZE, constants.FFT_SIZE, constants.HOP_SIZE)
        audio_data = OutputValuesSeralizer(OutputValues(eng_curve, frm_times)).data

        results["eng_curve"] = audio_data["eng_curve"]
        results["frm_times"] = audio_data["eng_curve"]

        os.remove(filename)

        return JsonResponse(results)
