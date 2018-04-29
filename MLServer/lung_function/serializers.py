from rest_framework import serializers
from lung_function.models import LungEquation


class LungEquationSerializer(serializers.ModelSerializer):
    class Meta:
        model = LungEquation
        fields = 'id', 'target_value', 'order', 'params', 'learning_rate', 'iterations', 'error'


class LungInputValuesSerializer(serializers.Serializer):
    eng_curve = serializers.ListField(
        child=serializers.FloatField()
    )
    frm_times = serializers.ListField(
        child=serializers.FloatField()
    )


class LungOutputValuesSeralizer(serializers.Serializer):
    PEF = serializers.FloatField()
    FVC = serializers.FloatField()
    FEV1 = serializers.FloatField()
    flow_curve = serializers.ListField(
        child=serializers.FloatField()
    )
    volumes = serializers.ListField(
        child=serializers.FloatField()
    )
