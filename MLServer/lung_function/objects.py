class LungOutputValues(object):
    def __init__(self, PEF, FVC, FEV1, flow_curve, volumes):
        self.PEF = PEF
        self.FVC = FVC
        self.FEV1 = FEV1
        self.flow_curve = flow_curve
        self.volumes = volumes
