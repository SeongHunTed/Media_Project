from .models import Store
from accounts.models import User

from rest_framework import serializers


class StoreSerializer(serializers.ModelSerializer):

    image1 = serializers.ImageField(use_url=True)
    image2 = serializers.ImageField(use_url=True)
    image3 = serializers.ImageField(use_url=True)
    image4 = serializers.ImageField(use_url=True)
    image5 = serializers.ImageField(use_url=True)

    class Meta:
        model = Store
        fields = '__all__'
