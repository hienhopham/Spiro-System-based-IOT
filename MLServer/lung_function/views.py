from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response

from .serializers import LungEquationSerializer, LungInputValuesSerializer, LungOutputValuesSerializer, PEFSerializer, FEFSerializer, FVCSerializer, FEV1Serializer, DataEquationVisualizationSerializer
from .objects import LungOutputValues
from .models import LungEquation, PEF, FEF, FVC, FEV1
from .computations import ExtractValues

import learning


class LungEquationView(APIView):

    def get(self, request):
        eqs = LungEquation.objects.all()
        serializer = LungEquationSerializer(eqs, many=True)

        return Response(serializer.data)

    def put(self, request):
        serializer = LungEquationSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class LungEquationDetailView(APIView):

    def get(self, request, pk):
        eq = get_object_or_404(LungEquation, pk=pk)
        serializer = LungEquationSerializer(eq)

        return Response(serializer.data)

    def delete(self, request, pk):
        eq = get_object_or_404(LungEquation, pk=pk)
        eq.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

class LungValuesView(APIView):

    def post(self, request):
        eng_curve = request.data["eng_curve"]
        frm_times = request.data["frm_times"]
        
        eq_pef = get_object_or_404(LungEquation, target_value='pef')
        eq_fef = get_object_or_404(LungEquation, target_value='fef')
        eq_fvc = get_object_or_404(LungEquation, target_value='fvc')
        eq_fev1 = get_object_or_404(LungEquation, target_value='fev1')

        PEF, FVC, FEV1, flow_curve, volumes = ExtractValues.getOutputValues(eq_pef, eq_fef, eq_fvc, eq_fev1, eng_curve, frm_times)
        output_data = LungOutputValues(PEF, FVC, FEV1, flow_curve, volumes)

        return JsonResponse(LungOutputValuesSerializer(output_data).data)

class DatasetView(APIView):

    model = None
    serializer = None

    def post(self, request):
        eqs = self.model.objects.all()
        serializers = self.serializer(eqs, many=True)

        return Response(serializers.data)

class PEFView(DatasetView):
    model = PEF
    serializer = PEFSerializer

class FEFView(DatasetView):
    model = FEF
    serializer = FEFSerializer

class FVCView(DatasetView):
    model = FVC
    serializer = FVCSerializer

class FEV1View(DatasetView):
    model = FEV1
    serializer = FEV1Serializer

class EquationVisualizationView(APIView):

    def post(self, req):
        eq = get_object_or_404(LungEquation, target_value=req.data["target_value"])
        lower_bound = float(req.data["lower_bound"])
        higher_bound = float(req.data["higher_bound"])
        num = int(req.data["num"])

        dataEquationVisualization = learning.getDataEquationVisualization(eq.params, lower_bound, higher_bound, num)
        serializers = DataEquationVisualizationSerializer(dataEquationVisualization, many=True)

        return Response(serializers.data)

