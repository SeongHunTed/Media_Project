from rest_framework import serializers
from .models import *
from stores.models import Store
from stores.serializers import StoreSerializer


class PriceSeiralizer(serializers.ModelSerializer):

    class Meta:
        model = Price
        fields = ['price_range']

class LocateSeiralizer(serializers.ModelSerializer):

    class Meta:
        model = Location
        fields = ['locate']

class FlavorSeiralizer(serializers.ModelSerializer):

    class Meta:
        model = Flavor
        fields = ['flavor']

class CakeSizeSerializer(serializers.ModelSerializer):

    class Meta:
        model = CakeSize
        fields = ('size', 'price')

class CakeFlavorSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = CakeFlavor
        fields = ['flavor', 'price']

class CakeColorSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = CakeColor
        fields = ['color', 'price']

class CakeDesignSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = CakeDesign
        fields = ['design', 'price']

class CakeSideDecoSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = CakeSideDeco
        fields = ['side_deco', 'price']

class CakeDecoSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = CakeDeco
        fields = ['deco', 'price']

class CakeLetteringSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = CakeLettering
        fields = ['lettering', 'price']

class CakeFontSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = CakeFont
        fields = ['font', 'price']

class CakePictureSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = CakePicture
        fields = ['picture', 'price']

class CakePackageSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = CakePackage
        fields = ['package', 'price']

class CakeCandleSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = CakeCandle
        fields = ['candle', 'price']

class CakeSerializer(serializers.ModelSerializer):

    size = CakeSizeSerializer(many=True)
    flavor = CakeFlavorSerializer(many=True)
    color = CakeColorSerializer(many=True)
    design = CakeDesignSerializer(many=True)
    side_deco = CakeSideDecoSerializer(many=True)
    deco = CakeDecoSerializer(many=True)
    lettering = CakeLetteringSerializer(many=True)
    font = CakeFontSerializer(many=True)
    picture = CakePictureSerializer(many=True)
    package = CakePackageSerializer(many=True)
    candle = CakeCandleSerializer(many=True)

    class Meta:
        model = Cake
        fields = ['name', 'store', 'price', 
        'size', 'flavor', 'color', 'design', 'side_deco', 'deco',
        'lettering', 'font', 'picture', 'package', 'candle']

class CakeOnlySerializer(serializers.ModelSerializer):

    class Meta:
        model = Cake
        fields = ('name', 'price',)

# 메인 페이지에 케이크 보내줄 때 스토어 정보는 어떻게 보낼 것인가?
class StoreCakeSerializer(serializers.ModelSerializer):

    cake = CakeOnlySerializer(many=True)

    class Meta:
        model = Store
        fields = ['store_name', 'id', 'cake']

class CakeSearchSerializer(serializers.ModelSerializer):

    store_name = serializers.CharField(source='cake.store.store_name')
    cake_name = serializers.CharField(source='cake.name')
    cake_price = serializers.CharField(source='cake.price')

    class Meta:
        model = CakeInfo
        fields = ['cake_name', 'cake_price', 'store_name']