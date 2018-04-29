from django.conf.urls import url
from django.contrib import admin
from lung_audio_data.views import AudioFileProccessingView

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^lung_audio_data/api/get_values', AudioFileProccessingView.as_view())
]
