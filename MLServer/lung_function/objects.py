class LungOutputValues(object):
    def __init__(self, PEF, FVC, FEV1, flow_curve, volumes):
        self.PEF = PEF
        self.FVC = FVC
        self.FEV1 = FEV1
        self.flow_curve = flow_curve
        self.volumes = volumes

class DataEquationVisualization(object):
    def __init__(self, input_value, output_value):
        self.input_value = input_value
        self.output_value = output_value