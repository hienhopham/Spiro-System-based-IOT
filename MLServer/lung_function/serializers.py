from rest_framework import serializers
from lung_function.models import LungEquation

class LungEquationSerializer(serializers.ModelSerializer):
  class Meta:
    model = LungEquation
    fields = 'id', 'target_value', 'order', 'params'

class LungInputValuesSerializer(serializers.Serializer):
   """Your data serializer, define your fields here."""
   eng_curve = serializers.ListField(
     child=serializers.FloatField()
   )
   frm_times = serializers.ListField(
     child=serializers.FloatField()
   )