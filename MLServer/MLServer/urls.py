from django.conf.urls import url, include
from django.contrib import admin
from django.contrib.auth import views as auth_views

from django.views.generic import TemplateView
from rest_framework_jwt.views import refresh_jwt_token

from rest_framework_nested import routers
from authentication.views import AccountViewSet, LoginView, LogoutView


router = routers.SimpleRouter()
router.register(r'accounts', AccountViewSet)

class SimpleStaticView(TemplateView):
    def get_template_names(self):
        return [self.kwargs.get('template_name') + ".html"]


urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^lung-function/', include('lung_function.urls')),
    url(r'^api/v1/', include(router.urls)),
    url(r'^api/v1/auth/login/$', LoginView.as_view(), name='login'),
    url(r'^api/v1/auth/logout/$', LogoutView.as_view(), name='logout'),
    url('^.*$', TemplateView.as_view(template_name='index.html'))
]
