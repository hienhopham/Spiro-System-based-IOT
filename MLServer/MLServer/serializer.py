from rest_framework import serializers
from MLServer.models import User

class UserSerializer(serializers.ModelSerializer):
  class Meta:
    model = User
    fields = 'id', 'username', 'password'


# class EmailSerializer(serializers.ModelSerializer):
#     author = UserSerializer(required=False)
#     photos = serializers.HyperlinkedIdentityField(view_name='postphoto-list')
#     # author = serializers.HyperlinkedRelatedField(view_name='user-detail', lookup_field='username')

#     def get_validation_exclusions(self, *args, **kwargs):
#         # Need to exclude `user` since we'll add that later based off the request
#         exclusions = super(PostSerializer, self).get_validation_exclusions(*args, **kwargs)
#         return exclusions + ['author']

#     class Meta:
#         model = Post
#         fields = '__all__'