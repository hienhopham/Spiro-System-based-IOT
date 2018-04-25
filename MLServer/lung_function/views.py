from django.shortcuts import get_object_or_404
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response

from lung_function.serializers import LungEquationSerializer, LungInputValuesSerializer
from lung_function.models import LungEquation


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
        serializer = LungInputValuesSerializer(data=request.data)
        eq_pef = get_object_or_404(LungEquation, target_value='pef')
        if serializer.is_valid():
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)