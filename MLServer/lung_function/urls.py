from django.conf.urls import url
from lung_function.views import LungEquationView, LungEquationDetailView, LungValuesView, PEFView, FEFView, FVCView, FEV1View, EquationVisualizationView

urlpatterns = [
    url(r'^api/$', LungEquationView.as_view()), 
    url(r'^api/(?P<pk>[0-9]+)/$', LungEquationDetailView.as_view()),
    url(r'^api/get_values', LungValuesView.as_view()),
    url(r'^api/get_dataset_pef', PEFView.as_view()),
    url(r'^api/get_dataset_fef', FEFView.as_view()),
    url(r'^api/get_dataset_fvc', FVCView.as_view()),
    url(r'^api/get_dataset_fev1', FEV1View.as_view()),
    url(r'^api/get_data_eq_visual', EquationVisualizationView.as_view())
]
