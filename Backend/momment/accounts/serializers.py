from rest_framework.serializers import ModelSerializer, ReadOnlyField
from .models import Account

class LoginSerializer(ModelSerializer):
    
    class Meta:
        model = Account
        fields = ['email', 'name']