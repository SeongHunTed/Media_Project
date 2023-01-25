from django.shortcuts import render
from accounts.models import User
from cake.models import *
from .serializers import *
import json
from rest_framework.renderers import JSONRenderer
from django.http import HttpResponse, JsonResponse
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view

@api_view(['POST', 'PUT'])
def update(request):
    try:
        data = json.loads(request.body)
        
        user_email = data['user_email'] # 차후에 jwt 인증방식으로 변경
        cake_name = data['cake_name']
        cake_price = data['cake_price']

        user = User.objects.get(email=user_email)
        store = Store.objects.get(user=user)

        # if CakeName.objects.filter(name=cake_name).exists():
        #     CakeName.objects.update(name=cake_name, store=store)
        
        cake = Cake.objects.update_or_create(name=cake_name, price=cake_price, store=store)[0]
        # cake = CakeName.objects.get(name=cake_name, store=store)
        basic_options = data['cake_basic_option'].keys()
        addtional_options = data['cake_additional_option'].keys()
        
        cake = Cake.objects.get(name=cake_name, store=store)
        # basic options = cake_size, cake falvor, cake color ....

        for basic_option in basic_options:
            options = data['cake_basic_option'][basic_option].keys()
            # option_key : 1, 2, 3
            for option_key in options:
                option = data['cake_basic_option'][basic_option][option_key]['option']
                price = data['cake_basic_option'][basic_option][option_key]['price']

                if basic_option == 'cake_size':
                    CakeSize.objects.update_or_create(size=option, price=price, cake=cake)
                elif basic_option == 'cake_flavor':
                    CakeFlavor.objects.update_or_create(flavor=option, price=price, cake=cake)
                elif basic_option == 'cake_color':
                    CakeColor.objects.update_or_create(color=option, price=price, cake=cake)
                elif basic_option == 'cake_design':
                    CakeDesign.objects.update_or_create(design=option, price=price, cake=cake)
        
        for addtional_option in addtional_options:
            options = data['cake_additional_option'][addtional_option].keys()
            for option_key in options:
                option = data['cake_additional_option'][addtional_option][option_key]['option']
                price = int(data['cake_additional_option'][addtional_option][option_key]['price'])

                if addtional_option == 'cake_sidedeco':
                    CakeSideDeco.objects.update_or_create(side_deco=option, price=price, cake=cake)
                elif addtional_option == 'cake_deco':
                    CakeDeco.objects.update_or_create(deco=option, price=price, cake=cake)
                elif addtional_option == 'cake_lettering':
                    CakeLettering.objects.update_or_create(lettering=option, price=price, cake=cake)
                elif addtional_option == 'cake_font':
                    CakeFont.objects.update_or_create(font=option, price=price, cake=cake)
                elif addtional_option == 'cake_picture':
                    CakePicture.objects.update_or_create(picture=option, price=price, cake=cake)
                elif addtional_option == 'cake_package':
                    CakePackage.objects.update_or_create(package=option, price=price, cake=cake)
                elif addtional_option == 'cake_candle':
                    CakeCandle.objects.update_or_create(candle=option, price=price, cake=cake)
            
        return JsonResponse({'message' : 'SUCCESS'}, status=200)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)

@api_view(['POST', 'PUT'])
def delete_detail(request):
    try:
        data = json.loads(request.body)
        user_email = data['user_email'] # 차후에 jwt 인증방식으로 변경
        cake_name = data['cake_name']
        option = data['option']
        detail = data['detail']

        user = User.objects.get(email=user_email)
        store = Store.objects.get(user=user)
        cake = Cake.objects.get(name=cake_name, store=store)

        if option == 'cake_size':
            CakeSize.objects.filter(cake=cake, size=detail).delete()
        elif option == 'cake_flavor':
            CakeFlavor.objects.filter(cake=cake, flavor=detail).delete()
        elif option == 'cake_color':
            CakeColor.objects.filter(cake=cake, color=detail).delete()
        elif option == 'cake_design':
            CakeDesign.objects.filter(cake=cake, design=detail).delete()
        elif option == 'cake_sidedeco':
            CakeSideDeco.objects.filter(cake=cake, side_deco=detail).delete()
        elif option == 'cake_deco':
            CakeDeco.objects.filter(cake=cake, deco=detail).delete()
        elif option == 'cake_lettering':
            CakeLettering.objects.filter(cake=cake, lettering=detail).delete()
        elif option == 'cake_font':
            CakeFont.objects.filter(cake=cake, font=detail).delete()
        elif option == 'cake_picture':
            CakePicture.objects.filter(cake=cake, picture=detail).delete()
        elif option == 'cake_package':
            CakePackage.objects.filter(cake=cake, package=detail).delete()
        elif option == 'cake_candle':
            CakeCandle.objects.filter(cake=cake, candle=detail).delete()

        return JsonResponse({'message' : 'SUCCESS'}, status=200)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)


@api_view(['POST', 'PUT'])
def delete_option(request):
    try:
        data = json.loads(request.body)
        user_email = data['user_email'] # 차후에 jwt 인증방식으로 변경
        cake_name = data['cake_name']
        option = data['option']
        
        user = User.objects.get(email=user_email)
        store = Store.objects.get(user=user)
        cake = Cake.objects.get(name=cake_name, store=store)

        if option == 'cake_size':
            CakeSize.objects.filter(cake=cake).delete()
        elif option == 'cake_flavor':
            CakeFlavor.objects.filter(cake=cake).delete()
        elif option == 'cake_color':
            CakeColor.objects.filter(cake=cake).delete()
        elif option == 'cake_design':
            CakeDesign.objects.filter(cake=cake).delete()
        elif option == 'cake_sidedeco':
            CakeSideDeco.objects.filter(cake=cake).delete()
        elif option == 'cake_deco':
            CakeDeco.objects.filter(cake=cake).delete()
        elif option == 'cake_lettering':
            CakeLettering.objects.filter(cake=cake).delete()
        elif option == 'cake_font':
            CakeFont.objects.filter(cake=cake).delete()
        elif option == 'cake_picture':
            CakePicture.objects.filter(cake=cake).delete()
        elif option == 'cake_package':
            CakePackage.objects.filter(cake=cake).delete()
        elif option == 'cake_candle':
            CakeCandle.objects.filter(cake=cake).delete()

        return JsonResponse({'message' : 'SUCCESS'}, status=200)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)


@api_view(['POST', 'PUT'])
def delete_all(request):
    try:
        data = json.loads(request.body)
        
        user_email = data['user_email'] # 차후에 jwt 인증방식으로 변경
        cake_name = data['cake_name']

        user = User.objects.get(email=user_email)
        store = Store.objects.get(user=user)

        cake = Cake.objects.get(name=cake_name, store=store)
        cake.delete()

        return JsonResponse({'message' : 'SUCCESS'}, status=200)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)


# 상품 상세 페이지용 - Option 제공
@api_view(['GET'])
def detail_page(request):
    try:

        price = Price.objects.all()
        locate = Location.objects.all()
        flavor = Flavor.objects.all()

        price_serializer = PriceSeiralizer(price, many=True).data
        locate_serializer = LocateSeiralizer(locate, many=True).data
        flavor_serializer = FlavorSeiralizer(flavor, many=True).data


        prices = []
        for price in price_serializer:
            prices.append(price['price_range'])

        locates = []
        for locate in locate_serializer:
            locates.append(locate['locate'])

        flavors = []
        for flavor in flavor_serializer:
            flavors.append(flavor['flavor'])

        content = {
            "price_range" : prices,
            "locate" : locates,
            "flavor" : flavors
        }

        return JsonResponse(content, safe=False, status=status.HTTP_201_CREATED)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)

@api_view(['POST', 'PUT'])
def detail_update(request):
    try:
        data = json.loads(request.body)

        user_email = data['user_email']
        locate = data['locate']
        flavor = data['flavor']
        price = data['price']
        info = data['info']
        cake_name = data['cake_name']

        user = User.objects.get(email=user_email)
        store = Store.objects.get(user=user)
        cake = Cake.objects.get(name=cake_name, store=store)

        CakeInfo.objects.update_or_create(locate=locate, flavor=flavor, price=price, info=info, cake=cake)

        return JsonResponse({'message' : 'SUCCESS'}, status=200)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)