from rest_framework import serializers

class OutputValuesSeralizer(serializers.Serializer):
    eng_curve = serializers.ListField(
        child=serializers.FloatField()
    )
    frm_times = serializers.ListField(
        child=serializers.FloatField()
    )
