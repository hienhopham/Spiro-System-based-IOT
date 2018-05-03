from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response

from lung_function.serializers import LungEquationSerializer, LungInputValuesSerializer, LungOutputValuesSeralizer
from lung_function.objects import LungOutputValues
from lung_function.models import LungEquation
from lung_function.computations import ExtractValues


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

        return JsonResponse(LungOutputValuesSeralizer(output_data).data)