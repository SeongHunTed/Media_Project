from . import views
from django.urls import path

urlpatterns = [
    path('order', views.order),
    path('review', views.review),
    path('cart', views.cart),
]