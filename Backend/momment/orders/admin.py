from django.contrib import admin
from .models import Status

class StatusAdmin(admin.ModelAdmin):

    list_display = ('status',)
    search_fields = ()
    readonly_fields = ()
 
    filter_horizontal = ()
    list_filter = ()
    fieldsets = ()
    ordering = ()

admin.site.register(Status, StatusAdmin)