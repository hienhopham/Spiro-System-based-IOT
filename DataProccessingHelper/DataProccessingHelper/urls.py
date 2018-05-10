from django.conf.urls import url
from django.contrib import admin
from lung_audio_data.views import AudioFileProccessingView

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^lung-audio-data/api/get-values', AudioFileProccessingView.as_view())
]
