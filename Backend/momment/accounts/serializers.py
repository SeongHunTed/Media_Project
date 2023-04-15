from rest_framework.serializers import ModelSerializer, ReadOnlyField
from .models import User
from rest_framework import serializers

class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        exclude = ('password', 'is_admin', 'is_staff', 'is_superuser', 'is_active', 'create_at', 'last_login')