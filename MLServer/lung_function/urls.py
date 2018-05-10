from django.conf.urls import url

from lung_function.views import LungEquationView, LungEquationDetailView, LungValuesView, PEFView, FEFView, FVCView, FEV1View, EquationVisualizationView

urlpatterns = [
    url(r'^api/$', LungEquationView.as_view()), 
    url(r'^api/lung-equation', LungEquationDetailView.as_view()),
    url(r'^api/get-values', LungValuesView.as_view()),
    url(r'^api/get-dataset-pef', PEFView.as_view()),
    url(r'^api/get-dataset-fef', FEFView.as_view()),
    url(r'^api/get-dataset-fvc', FVCView.as_view()),
    url(r'^api/get-dataset-fev1', FEV1View.as_view()),
    url(r'^api/get-data-eq-visual', EquationVisualizationView.as_view())
]
