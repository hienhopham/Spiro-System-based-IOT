from django.conf.urls import url
from lung_function.views import LungEquationView, LungEquationDetailView, LungValuesView

urlpatterns = [
    url(r'^api/$', LungEquationView.as_view()), 
    url(r'^api/(?P<pk>[0-9]+)/$', LungEquationDetailView.as_view()),
    url(r'^api/get_values/$', LungValuesView.as_view())
]
