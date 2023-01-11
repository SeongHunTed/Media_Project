from django.shortcuts import render
from django.conf import settings
from django.shortcuts import redirect
from rest_framework.views import APIView
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from django.http import HttpResponse, JsonResponse

from django.views.decorators.csrf import csrf_exempt
from accounts.models import User, Manager
import requests, json, re
from django.contrib.auth import authenticate

from rest_framework import status
from json.decoder import JSONDecodeError

# Create your views here.

BASE_URL = "http://127.0.0.1:8000/" 
KAKAO_CALLBACK_URI = "http://127.0.0.1:8000/accounts/kakao/callback"
kakao_token_uri = "https://kauth.kakao.com/oauth/token"
kakao_profile_uri = "https://kapi.kakao.com/v2/user/me"

@csrf_exempt
def signup(request):
    try:
        data = json.loads(request.body)

        email       = data['email']
        password    = data['password']
        name        = data['name']
        digit       = data['digit']
        birth       = data['birth']
        address     = data['address']

        if User.object.filter(email=email).exists():
            return JsonResponse({'message' : 'ALREADY_EXIST'}, status = 400)

        regex_email    = '^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9_-]+\.[a-zA-Z0-9-.]+$'
        regex_password = '\S{8,25}'
        if not re.match(regex_email, email):
            return JsonResponse({'message' : 'INVALID_EMAIL'}, status = 400)
        if not re.match(regex_password, password):
            return JsonResponse({'message' : 'INVALID_PASSWORD'}, status = 400)

        User.object.create_user(email=email, password=password, name=name, digit=digit, birth=birth, address=address)
        return JsonResponse({'message' : 'SUCCESS'}, status=201)

    except KeyError:
        return JsonResponse({'message' : 'KEY_ERROR'}, status=400)

@csrf_exempt
def login(request):
    try:
        data = json.loads(request.body)

        email = data['email']
        password = data['password']

        User.object.filter(email=email).
        
        return JsonResponse({'message' : 'LOGIN_SUCCESS'})
    except:
        return JsonResponse({'message' : 'LOGIN_FAILED'})


def kakao_login(request):
    print("hi")
    rest_api_key = getattr(settings, 'KAKAO_REST_API_KEY')
    return redirect(
        f"https://kauth.kakao.com/oauth/authorize?client_id={rest_api_key}&redirect_uri={KAKAO_CALLBACK_URI}&response_type=code"
    )

class KakaoCallBackView(APIView):
    
    def get(self, request):
        data = request.query_params.copy()

        # access_token 발급 요청
        code = data.get('code')
        if not code:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        client_key = getattr(settings, 'CLIENT_KEY')
        rest_api_key = getattr(settings, 'KAKAO_REST_API_KEY')
        data = {
            "grant_type"        :"authorization_code",
            "client_id"         :rest_api_key,
            "redirection_uri"   :KAKAO_CALLBACK_URI,
            "client_key"        :client_key,
            "code"              :request.GET["code"]
        }

        token_headers = {
            'Content-type': 'application/x-www-form-urlencoded;charset=utf-8'
        }
        token_res = requests.post(kakao_token_uri, data=data, headers=token_headers)

        token_json = token_res.json()
        access_token = token_json.get('access_token')

        if not access_token:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        access_token = f"Bearer {access_token}"  # 'Bearer ' 마지막 띄어쓰기 필수

        # kakao 회원정보 요청
        auth_headers = {
            "Authorization": access_token,
            "Content-type": "application/x-www-form-urlencoded;charset=utf-8",
        }
        user_info_res = requests.get(kakao_profile_uri, headers=auth_headers)
        user_info_json = user_info_res.json()

        social_type = 'kakao'
        social_id = f"{social_type}_{user_info_json.get('id')}"

        kakao_account = user_info_json.get('kakao_account')
        if not kakao_account:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        user_email = kakao_account.get('email')

        '''
        # 회원가입 및 로그인 처리 알고리즘 추가필요
        '''

        # 테스트 값 확인용
        res = {
            'social_type': social_type,
            'social_id': social_id,
            'user_email': user_email,
        }
        response = Response(status=status.HTTP_200_OK)
        response.data = res
        print(res)
        return redirect(BASE_URL)
