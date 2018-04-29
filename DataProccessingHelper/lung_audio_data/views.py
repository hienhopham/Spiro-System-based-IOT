import datetime

from rest_framework.views import APIView
from rest_framework.response import Response
from lung_audio_data.serializers import OutputValuesSeralizer
from lung_audio_data.objects import OutputValues

import baseFunctions as bfs
import computation as cp
import constants


class AudioFileProccessingView(APIView):

    def post(self, request):
        stream_file = request.data["stream_file"]

        now = datetime.datetime.now().strftime('%H.%M.%S')
        filename = constants.AUDIO_FOLDER + '/' + now + '_tmp.wav'

        with open(filename, 'wb+') as f:
            for chunk in stream_file:
                f.write(chunk)
        
        eng_curve, frm_times = cp.getValues(filename, constants.WINDOW_SIZE, constants.FFT_SIZE, constants.HOP_SIZE)
        outputValuesSerializer = OutputValuesSeralizer(OutputValues(eng_curve, frm_times))

        return Response(outputValuesSerializer.data)
