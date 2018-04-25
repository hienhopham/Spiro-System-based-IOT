from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth import authenticate, login


class UserView(APIView):

    def post(self, request):
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(username=username, password=password)

        if user is not None:
            login(request, user)
            return Response({'status':'ok'})
        else:
            return Response({'status':'fail'})
