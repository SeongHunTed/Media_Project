from rest_framework.serializers import ModelSerializer, ReadOnlyField
from .models import User
from rest_framework import serializers

class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        # fields = ('name', 'digit', 'birth', 'address')
        # read_only_fields = ('email', 'password')
        exclude = ('password',)