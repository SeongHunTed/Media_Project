from . import views
from django.urls import path

urlpatterns = [
    path('update/', views.update),
    path('delete_detail/', views.delete_detail),
    path('delete_option/', views.delete_option),
    path('delete_all/', views.delete_all),
    path('detail_page/', views.detail_page),
    path('detail_update/', views.detail_update),
    path('cake_show/<int:page>/', views.cake_show)
]