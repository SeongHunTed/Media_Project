from django.shortcuts import render
from accounts.models import User
from cakes.models import *
from .serializers import *
import json
from rest_framework.renderers import JSONRenderer
from django.http import JsonResponse
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view


@api_view(['GET'])
def show(request):
    try:
        data = json.loads(request.body)
        user_email = data['user_email']

        user = User.objects.get(email=user_email)
        store = Store.objects.get(user=user)
        cakes = Cake.objects.filter(store=store)

        cake_size = CakeSerializer(cakes, many=True)

        return Response(cake_size.data,status=200)


    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)

# 케이크 생성, 수정, 삭제
@api_view(['POST', 'PUT', 'DELETE'])
def cake(request):
    try:
        if request.method == 'POST' or request.method == 'PUT':
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
        
        elif request.method == 'DELETE':
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

@api_view(['PUT'])
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

@api_view(['PUT'])
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

# 상품 상세 페이지
@api_view(['GET', 'POST', 'PUT'])
def detail(request):
    try:
        if request.method == 'GET':
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

            return JsonResponse(content, safe=False, status=status.HTTP_200_OK)
        
        elif request.method == 'POST' or request.method == 'PUT':
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
            locate = Location.objects.get(locate=locate)
            price = Price.objects.get(price_range=price)
            flavor = Flavor.objects.get(flavor=flavor)

            if CakeInfo.objects.filter(cake=cake).exists():
                CakeInfo.objects.update(locate=locate, flavor=flavor, price_range=price, info=info, cake=cake)
            else:
                CakeInfo.objects.create(locate=locate, flavor=flavor, price_range=price, info=info, cake=cake)

            return JsonResponse({'message' : 'SUCCESS'}, status=status.HTTP_201_CREATED)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)

# 메인 페이지에 넘겨줄 처음 케이크 6개
# 차후 어떤 케이크 넘겨 줄지 정해야함
@api_view(['GET'])
def main(request, page):
    try:
        # 차후 인기 있는 케이크를 보여줄 때 order_by 메소드 이용
        # 6개씩 보여주는 로직
        # cakes = Cake.objects.all()[:page*6]
        store = Store.objects.all()[:page*6]
        cake = StoreCakeSerializer(store, many=True)

        return Response(cake.data, status=status.HTTP_201_CREATED)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)