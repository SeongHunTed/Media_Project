from . import views
from django.urls import path

urlpatterns = [
    path('', views.show),
    path('cake', views.cake),
    path('delete-detail', views.delete_detail),
    path('delete-option', views.delete_option),
    path('detail', views.detail),
    path('main/<int:page>', views.main),
    path('order', views.order)
]