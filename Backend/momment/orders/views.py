from django.shortcuts import render
from .models import Order
from cakes.models import *
from calenders.models import *
from .serializers import *
import json, datetime
import calendar as cal
from rest_framework import status
from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework.decorators import api_view

@api_view(['POST', 'GET', 'DELETE'])
def order(request):
    try:
        if request.method == 'POST':
            data = json.loads(request.body)

            user_email = data['user_email']
            store_name = data['store_name']
            cake_name = data['cake_name']
            basic_options = data['cake_basic_option'].keys()
            additional_options = data['cake_additional_option'].keys()
            total_price = int(data['cake_price'])
            pickup_date = data['pickup_date']
            pickup_time = data['pickup_time']

            user = User.objects.get(email=user_email)
            store = Store.objects.get(store_name=store_name)
            cake = Cake.objects.get(name=cake_name)
            
            options = []
            certi_prices = []

            certi_prices.append(cake.price)

            # 유효성 검증
            for basic_option in basic_options:
                option = data['cake_basic_option'][basic_option]['option']
                price = data['cake_basic_option'][basic_option]['price']

                if basic_option == 'cake_size':
                    certi_prices.append(CakeSize.objects.get(size=option, cake=cake).price)
                elif basic_option == 'cake_flavor':
                    certi_prices.append(CakeFlavor.objects.get(flavor=option, cake=cake).price)
                elif basic_option == 'cake_color':
                    certi_prices.append(CakeColor.objects.get(color=option, cake=cake).price)
                elif basic_option == 'cake_design':
                    certi_prices.append(CakeDesign.objects.get(design=option, cake=cake).price)

                options.append(basic_option + " : " + option)

            for additional_option in additional_options:
                option = data['cake_additional_option'][additional_option]['option']
                price = data['cake_additional_option'][additional_option]['price']

                if additional_option == 'cake_sidedeco':
                    certi_prices.append(CakeSideDeco.objects.get(side_deco=option, cake=cake).price)
                elif additional_option == 'cake_deco':
                    certi_prices.append(CakeDeco.objects.get(deco=option, cake=cake).price)
                elif additional_option == 'cake_lettering':
                    certi_prices.append(CakeLettering.objects.get(lettering=option, cake=cake).price)
                elif additional_option == 'cake_font':
                    certi_prices.append(CakeFont.objects.get(font=option, cake=cake).price)
                elif additional_option == 'cake_picture':
                    certi_prices.append(CakePicture.objects.get(picture=option, cake=cake).price)
                elif additional_option == 'cake_package':
                    certi_prices.append(CakePackage.objects.get(package=option, cake=cake).price)
                elif additional_option == 'cake_candle':
                    # quantity = data['cake_addtional_option'][basic_option]['quantity']
                    certi_prices.append(CakeCandle.objects.get(candle=option, cake=cake).price)

                options.append(additional_option + " : " + option)

            certi_price = sum(certi_prices)
            
            if certi_price != total_price:
                return JsonResponse({'message' : 'PRICE_SUM_ERROR'}, status=400)

            today = datetime.date.today()
            year = str(today.year)[2:]
            if today.month < 10:
                month = '0' + str(today.month)
            else:
                month = str(today.month)
            if today.day < 10:
                day = '0' + str(today.day)
            else:
                day = str(today.day)
            today_code = year+month+day

            count = Order.objects.filter(id__contains=str(today_code)).count() + 1
            if count < 10:
                count = '000' + str(count)
            elif count < 100:
                count = '00' + str(count)
            elif count < 1000:
                count = '0' + str(count)
            id = int(str(today_code) + count)

            pay_status = Status.objects.get(status='입금대기')
            options = str(options)

            Order.objects.create(id=id, user=user, store=store, cake=cake, status=pay_status, 
            option=options, price=total_price, pickup_date=pickup_date, pickup_time=pickup_time, ordered_at=today)

            calender = Calender.objects.get(date=pickup_date, store=store)
            groups = Group.objects.filter(calender=calender)
            for group in groups:
                if Time.objects.filter(group=group, pickup_time=pickup_time).exists():
                    # time = Time.objects.get(group=group, pickup_time=pickup_time)
                    if group.group_ordered < group.group_max_order:
                        # if time.time_ordered < time.time_max_order:
                        #     time.time_ordered = time.time_ordered + 1
                        #     time.save()
                        group.group_ordered = group.group_ordered + 1
                        group.save()
                    else:
                        return JsonResponse({'message' : 'FULL_BOOKED'}, status=400)

            return JsonResponse({'message' : 'SUCCESS'}, status=201)
        
        elif request.method == 'DELETE':
            data = json.loads(request.body)

            user_email = data['user_email']
            order_id = data['order_id']
            store_name = data['store_name']
            pickup_date = data['pickup_date']
            pickup_time = data['pickup_time']

            order = Order.objects.get(id=order_id)
            order.delete()
            
            store = Store.objects.get(store_name=store_name)
            calender = Calender.objects.get(date=pickup_date, store=store)
            groups = Group.objects.filter(calender=calender)
            for group in groups:
                if Time.objects.filter(group=group, pickup_time=pickup_time).exists():
                    group.group_ordered = group.group_ordered - 1
                    group.save()
        
            return JsonResponse({'message' : 'SUCCESS'}, status=200)

        elif request.method == 'GET':
            data = json.loads(request.body)

            user_email = data['user_email']

            user = User.objects.get(email=user_email)

            # 판매자가 주문확인
            if Store.objects.filter(user=user).exists():
                pay_status = data['pay_status']
                pickup_date = data['pickup_date']

                store = Store.objects.get(user=user)

                orders = Order.objects.filter(store=store, pickup_date=pickup_date)

                serializer = OrderSerializer(orders, many=True)

                return Response(serializer.data, status=status.HTTP_200_OK)

            # 소비자 주문확인
            else:
                orders = Order.objects.filter(user=user)
                serializer = OrderSerializer(orders, many=True)

                return Response(serializer.data, status=status.HTTP_200_OK)
        
    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)

@api_view(['GET', 'POST', 'DELETE', 'PUT'])
def review(request):
    try:
        if request.method == 'POST' or request.method == 'PUT':

            data = json.loads(request.body)

            user_email = data['user_email']
            order_id = data['order_id']
            review_contents = data['review_contents']
            image = data['image']
            pay_status = data['pay_status']

            if pay_status != '구매확정':
                return JsonResponse({'message' : 'NOT_ALLOWED'}, status=400)

            user = User.objects.get(email=user_email)
            order = Order.objects.get(id=order_id)
            cake = order.cake

            if Review.objects.filter(order=order).exists():
                review = Review.objects.get(order=order)
                review.review = review_contents
                review.image = image
                review.save()

            else:
                Review.objects.create(order=order, cake=cake, user=user, review=review_contents, image=image)
            
            return JsonResponse({'message' : 'SUCCESS'}, status=201)

        if request.method == 'GET':
            
            data = json.loads(request.body)

            # store_name = data['store_name']
            cake_name = data['cake_name']

            # store = Store.objects.get(store_name=store_name)
            cake = Cake.objects.get(name=cake_name)
            if Review.objects.filter(cake=cake).exists():
                reviews = Review.objects.filter(cake=cake)
                serializer = ReviewSerializer(reviews, many=True)
                
                return Response(serializer.data, status=200)
            
            else:
                return JsonResponse({'message' : 'NO_REVIEW_EXIST'}, status=200)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)