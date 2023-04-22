from django.shortcuts import render
from accounts.models import User
from cakes.models import *
from .serializers import *
from stores.serializers import StoreSerializer
import json
from rest_framework.renderers import JSONRenderer
from django.http import JsonResponse, HttpResponse
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.decorators import permission_classes
from rest_framework.permissions import IsAuthenticated
from django.shortcuts import get_object_or_404


@api_view(['GET'])
def main_menu_cake_list(request):
    cakes = Cake.objects.all().order_by('?')[:10]
    data = CakeOnlySerializer(cakes, many=True).data
    return Response(data, status=status.HTTP_200_OK)

# 10개씩 끊어서 케이크 주는 API
@api_view(['GET',])
def cake_list_filterd(request, page):
    cakes = Cake.objects.all()[page*10:(page+1)*10]
    data = CakeOnlySerializer(cakes, many=True).data
    return Response(data, status=status.HTTP_200_OK)

# popup view에 들어갈 이미지와 케이크 정보
@api_view(['GET', ])
def cake_pop_up(request):
    cake_name = request.GET.get('cake_name')
    cake = get_object_or_404(Cake, name=cake_name)
    data = DetailCakeSerializer(cake).data
    return Response(data, status=status.HTTP_200_OK)

@api_view(['POST', 'DELETE'])
@permission_classes([IsAuthenticated])
def cake_pop_up_set(request):
    data = request.data
    info_image = request.FILES.get('images')
    cake_name = data['cake_name']
    cake = Cake.objects.get(name=cake_name)

    if request.method == 'DELETE':
        CakeInfoImage.objects.filter(cake=cake).delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
    
    CakeInfoImage.objects.create(cake=cake, info_image=info_image)

    return Response(status=status.HTTP_201_CREATED)

@api_view(['GET', ])
def cake_per_store(request):
    store_name = request.GET.get('store_name')
    store = Store.objects.get(store_name=store_name)
    cakes = Cake.objects.filter(store=store)
    print(cakes)
    data = CakeOnlySerializer(cakes, many=True).data
    return Response(data, status=status.HTTP_200_OK)



# 판매자에게 모든 케이크 보여줌
# @api_view(['GET'])
# def show(request):
#     try:
#         data = json.loads(request.body)
#         user_email = data['user_email']

#         user = User.objects.get(email=user_email)
#         store = Store.objects.get(user=user)
#         cakes = Cake.objects.filter(store=store)

#         cake_size = CakeSerializer(cakes, many=True)

#         return Response(cake_size.data,status=200)

#     except KeyError:
#         return JsonResponse({'message' : 'KEY_ERROR'}, status=400)
    
# @api_view(['POST', 'PUT', 'DELETE'])
# def cake_image(request):
#     try:
#         data = request.data
#         user_email = data['user_email']
#         cake_name = data['cake_name']
        
#         user = User.objects.get(email=user_email)
#         store = Store.objects.get(user=user)
#         cake = Cake.objects.get(name=cake_name, store=store)

#         if request.method == 'POST' or request.method == 'PUT':
#             images = request.FILES.getlist('images')

#             for image in images:
#                 CakeImage.objects.update_or_create(cake=cake, image=image)
            
#             return Response(status=status.HTTP_201_CREATED)
        
#         else:
#             cake.delete()

#             return Response(status=status.HTTP_200_OK)

#     except KeyError:
#         return Response(status=status.HTTP_400_BAD_REQUEST)

# 케이크 생성, 수정, 삭제
@api_view(['POST', 'PUT', 'DELETE'])
def cake(request):
    try:
        if request.method == 'POST' or request.method == 'PUT':
            data = json.loads(request.body)
            
            user = request.user # 차후에 jwt 인증방식으로 변경
            cake_name = data['cake_name']
            cake_price = data['cake_price']

            store = Store.objects.get(user=user)
            
            cake = Cake.objects.update_or_create(name=cake_name, price=cake_price, store=store)[0]
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
                cake_info = CakeInfo.objects.get(cake=cake)
                cake_info.locate = locate
                cake_info.flavor = flavor
                cake_info.info = info
                cake_info.price_range = price
                cake_info.save()
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
        store = Store.objects.all()[(page-1)*10:page*10]
        cake = StoreCakeSerializer(store, many=True, context={'request' : request})

        return Response(cake.data, status=status.HTTP_200_OK)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)

# 소비자가 주문시 보는 옵션 제공
@api_view(['POST',])
def order(request):
    try:
        data = json.loads(request.body)
        store_name = data['store_name']
        cake_name = data['cake_name']

        store = Store.objects.get(store_name=store_name)
        cake = Cake.objects.get(store=store, name=cake_name)

        cake = CakeSerializer(cake)

        return Response(cake.data, status=200)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)

# 검색기능
@api_view(['GET'])
def search(request, page):
    try:
        data = json.loads(request.body)
        keyword = data['keyword']

        stores = {}
        cakes = {}

        if Store.objects.filter(store_name__contains=keyword).exists():
            stores = Store.objects.filter(store_name__contains=keyword)[4*(page-1):page*4]
            stores = StoreSerializer(stores, many=True).data

        if Cake.objects.filter(name__contains=keyword).exists():
            cakes = Cake.objects.filter(name__contains=keyword)[4*(page-1):page*4]
            cakes = CakeSearchSerializer(cakes, many=True).data

        response_data = {
            'store' : stores,
            'cake' : cakes
        }

        return Response(response_data, status=200)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)

# 필터 검색 기능
@api_view(['GET'])
def filter(request, page):
    try:
        data = json.loads(request.body)

        price = data['price']
        locate = data['locate']
        flavor = data['flavor']

        # related name 때ㅜㄴ에 오류발생하는듯
        
        locate_filter = CakeInfo.objects.filter(locate=locate)
        price_filter = CakeInfo.objects.filter(price_range=price)
        flavor_filter = CakeInfo.objects.filter(flavor=flavor)

        cakes = locate_filter.union(price_filter, all=False)
        cakes = cakes.union(flavor_filter, all=False)

        cake = cakes[(page-1)*12:page*12]
        serializer = CakeSearchSerializer(cake, many=True)

        return Response(serializer.data)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)
    
@api_view(['POST', 'DELETE'])
@permission_classes([IsAuthenticated])
def cake_image(request):
    try:
        data = request.data
        user = request.user
        images_data = request.FILES.getlist('images')

        cake_name = data['cake_name']
        cake = Cake.objects.get(name=cake_name)

        if request.method == 'DELETE':
            CakeImage.objects.filter(cake=cake).delete()

        for image_data in images_data:
            CakeImage.objects.create(cake=cake, image=image_data)

        return Response(status=201)
    
    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)