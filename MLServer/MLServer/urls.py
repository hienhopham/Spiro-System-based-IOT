from django.conf.urls import url, include
from django.contrib import admin

from django.views.generic import TemplateView
from rest_framework_jwt.views import refresh_jwt_token
from MLServer.views import UserView
# import rest_auth.urls

class SimpleStaticView(TemplateView):
    def get_template_names(self):
        return [self.kwargs.get('template_name') + ".html"]


urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^$', TemplateView.as_view(template_name='index.html')),
    url(r'^user/api/$', UserView.as_view()),
    url(r'^auth/login', include('rest_auth.urls')),
    url(r'^lung_function/', include('lung_function.urls')),    
    url(r'^(?P<template_name>\w+)/$', SimpleStaticView.as_view(), name='example'),
]
