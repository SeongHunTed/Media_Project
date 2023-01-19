from django.shortcuts import render
from accounts.models import User
from cake.models import *

import json
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