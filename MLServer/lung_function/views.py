from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response

from .serializers import LungEquationSerializer, LungInputValuesSerializer, LungOutputValuesSerializer, PEFSerializer, FEFSerializer, FVCSerializer, FEV1Serializer, DataEquationVisualizationSerializer
from .objects import LungOutputValues
from .models import LungEquation, PEF, FEF, FVC, FEV1

import learning
import computations
import poly_regres as poly
import math


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

    def post(self, request):
        target_value = request.data["target_value"]
        eq = get_object_or_404(LungEquation, target_value=target_value)
        serializer = LungEquationSerializer(eq)

        return Response(serializer.data)


class LungValuesView(APIView):

    def post(self, request):
        if 'eng_curve' not in request.data:
            return JsonResponse({"error": "eng_curve is required"})
        if 'frm_times' not in request.data:
            return JsonResponse({"error": "frm_times is required"})

        eng_curve = request.data["eng_curve"]
        frm_times = request.data["frm_times"]

        eq_pef = get_object_or_404(LungEquation, target_value='pef')
        eq_fef = get_object_or_404(LungEquation, target_value='fef')
        eq_fvc = get_object_or_404(LungEquation, target_value='fvc')
        eq_fev1 = get_object_or_404(LungEquation, target_value='fev1')

        PEF, FVC, FEV1, flow_curve, volumes = computations.getOutputValues(
            eq_pef, eq_fef, eq_fvc, eq_fev1, eng_curve, frm_times)
        output_data = LungOutputValues(PEF, FVC, FEV1, flow_curve, volumes)

        return JsonResponse(LungOutputValuesSerializer(output_data).data)


class DatasetView(APIView):

    model = None
    serializer = None

    def post(self, request):
        eqs = self.model.objects.all()
        serializers = self.serializer(eqs, many=True)

        return Response(serializers.data)


class EquationVisualizationView(APIView):

    def post(self, req):
        if 'target_value' not in req.data:
            return JsonResponse({"error": "target_value is required"})

        eq = get_object_or_404(
            LungEquation, target_value=req.data["target_value"])
        lower_bound = float(req.data["lower_bound"])
        higher_bound = float(req.data["higher_bound"])
        num = int(req.data["num"])

        dataEquationVisualization = learning.getDataEquationVisualization(
            eq.params, lower_bound, higher_bound, num)
        serializers = DataEquationVisualizationSerializer(
            dataEquationVisualization, many=True)

        return Response(serializers.data)


class TrainingView(DatasetView):

    model = None

    def post(self, req):

        if 'new_learning_rate' not in req.data:
            return JsonResponse({"error": "new_learning_rate is required"})
        if 'new_iterations' not in req.data:
            return JsonResponse({"error": "new_iterations is required"})
        if 'lower_bound' not in req.data:
            return JsonResponse({"error": "lower_bound is required"})
        if 'higher_bound' not in req.data:
            return JsonResponse({"error": "lower_bound is required"})
        if 'num' not in req.data:
            return JsonResponse({"error": "num is required"})

        new_learning_rate = float(req.data["new_learning_rate"])
        new_iterations = int(req.data["new_iterations"])
        lower_bound = float(req.data["lower_bound"])
        higher_bound = float(req.data["higher_bound"])
        num = int(req.data["num"])

        trained_data = self.model.objects.filter(trained=True)
        test_data = self.model.objects.filter(trained=False)

        trained_dataset = poly.readData(trained_data)
        test_dataset = poly.readData(test_data)
        w_out, u_out, b_out, mse = poly.training(
            trained_dataset, new_learning_rate, new_iterations)

        if (math.isnan(w_out)):
            return Response({"error": "Bad parameters."})
        elif (len(test_dataset) == 0):
            test_err = 0
        else:
            test_err = poly.getTestError(w_out, u_out, b_out, test_dataset)

        dataEquationVisualization = learning.getDataEquationVisualization(
            str([w_out, u_out, b_out]), lower_bound, higher_bound, num)
        serializers = DataEquationVisualizationSerializer(
            dataEquationVisualization, many=True)

        return Response({"regressData": serializers.data, "mse": mse, "test_err": test_err, "params": [w_out, u_out, b_out]})


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


class PEFTrainingView(TrainingView):
    model = PEF


class FEFTrainingView(TrainingView):
    model = FEF


class FVCTrainingView(TrainingView):
    model = FVC


class FEV1TrainingView(TrainingView):
    model = FEV1
