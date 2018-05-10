from rest_framework import serializers
from lung_function.models import LungEquation, PEF, FEF, FVC, FEV1


class LungEquationSerializer(serializers.ModelSerializer):
    class Meta:
        model = LungEquation
        fields = 'id', 'target_value', 'order', 'params', 'learning_rate', 'iterations', 'ms_error', 'dataset_size', 'proportion', 'test_err'


class LungInputValuesSerializer(serializers.Serializer):
    eng_curve = serializers.ListField(
        child=serializers.FloatField()
    )
    frm_times = serializers.ListField(
        child=serializers.FloatField()
    )


class LungOutputValuesSerializer(serializers.Serializer):
    PEF = serializers.FloatField()
    FVC = serializers.FloatField()
    FEV1 = serializers.FloatField()
    flow_curve = serializers.ListField(
        child=serializers.FloatField()
    )
    volumes = serializers.ListField(
        child=serializers.FloatField()
    )

class Dataset(serializers.ModelSerializer):
    class Meta:
        fields = 'id', 'input_value', 'output_value', 'trained'
        abstract = True

class PEFSerializer(Dataset):
    class Meta:
        model = PEF
        fields = Dataset.Meta.fields

class FEFSerializer(Dataset):
    class Meta:
        model = FEF
        fields = Dataset.Meta.fields

class FVCSerializer(Dataset):
    class Meta:
        model = FVC
        fields = Dataset.Meta.fields

class FEV1Serializer(Dataset):
    class Meta:
        model = FEV1
        fields = Dataset.Meta.fields

class DataEquationVisualizationSerializer(serializers.Serializer):
    input_value = serializers.FloatField()
    output_value = serializers.FloatField()