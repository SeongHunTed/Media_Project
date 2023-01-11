from . import views
from django.urls import path

urlpatterns = [
    path('signup/', views.signup),
    path('login/', views.login),
    path('kakao/login/', views.kakao_login),
    path('kakao/callback/', views.KakaoCallBackView.as_view()),
    # path('kakao/login/finish/', views.kakao_login_to_django),
]