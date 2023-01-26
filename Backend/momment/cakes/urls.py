from . import views
from django.urls import path

urlpatterns = [
    path('', views.show),
    path('cake', views.cake),
    path('delete_detail', views.delete_detail),
    path('delete_option', views.delete_option),
    path('detail', views.detail),
    path('main/<int:page>', views.main)
]