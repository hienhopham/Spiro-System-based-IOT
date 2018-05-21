from django.conf.urls import url
from django.contrib import admin
from lung_audio_data.views import DataProcessingView

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^lung-audio-data/api/get-values', DataProcessingView.as_view())
]
