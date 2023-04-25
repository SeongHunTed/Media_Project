from django.contrib import admin
from .models import Status, Cart, Order

class StatusAdmin(admin.ModelAdmin):

    list_display = ('status',)
    search_fields = ()
    readonly_fields = ()
 
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()
    ordering = ()

class CartAdmin(admin.ModelAdmin):

    list_display = ('user', 'store', 'price', 'cake')
    search_fields = ()
    readonly_fields = ()
 
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()
    ordering = ()

class OrderAdmin(admin.ModelAdmin):

    list_display = ('id', 'user', 'store', 'cake', 'price', 'status')
    search_fields = ()
    readonly_fields = ()
 
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()
    ordering = ()

admin.site.register(Cart, CartAdmin)
admin.site.register(Order, OrderAdmin)
admin.site.register(Status, StatusAdmin)