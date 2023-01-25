from django.contrib import admin
from .models import Cake, Price, Location, Flavor, CakeInfo
 
class CakeAdmin(admin.ModelAdmin):
    # 관리자 화면에 보여질 칼럼 지정
    list_display = ('name', 'store', 'price')
    search_fields = ()
    readonly_fields = ()
 
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()
    ordering = ()
 
class CakePriceOption(admin.ModelAdmin):

    list_display = ['price_range']
    search_fields = ()
    readonly_fields = ()
 
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()
    ordering = ()

class CakeLocationOption(admin.ModelAdmin):

    list_display = ['locate']
    search_fields = ()
    readonly_fields = ()
 
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()
    ordering = ()

class CakeFlavorOption(admin.ModelAdmin):

    list_display = ['flavor']
    search_fields = ()
    readonly_fields = ()
 
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()
    ordering = ()

class CakeInfoAdmin(admin.ModelAdmin):
    list_display = ['cake', 'price_range']
    search_fields = ()
    readonly_fields = ()
 
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()
    ordering = ()

admin.site.register(Cake, CakeAdmin)
admin.site.register(Price, CakePriceOption)
admin.site.register(Location, CakeLocationOption)
admin.site.register(Flavor, CakeFlavorOption)
admin.site.register(CakeInfo, CakeInfoAdmin)