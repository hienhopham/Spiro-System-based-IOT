import datetime, base64, os

from django.http import JsonResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from lung_audio_data.serializers import OutputValuesSeralizer
from lung_audio_data.objects import OutputValues

import baseFunctions as bfs
import computation as cp
import constants


class AudioFileProccessingView(APIView):

    def post(self, request):

        stream_file = base64.b64decode(request.data["stream_file"])
        now = datetime.datetime.now().strftime('%H.%M.%S')
        filename = constants.AUDIO_FOLDER + '/' + now + '_tmp.wav'

        with open(filename, 'wb+') as f:
            # for chunk in stream_file:
            f.write(stream_file)
        
        # filename = '/home/hienpham/nct/best/DoanAnhTuan_02.wav'
        eng_curve, frm_times = cp.getValues(filename, constants.WINDOW_SIZE, constants.FFT_SIZE, constants.HOP_SIZE)
        outputValuesSerializer = OutputValuesSeralizer(OutputValues(eng_curve, frm_times))

        os.remove(filename)

        return JsonResponse(outputValuesSerializer.data)
