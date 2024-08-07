from django.urls import path, include
from .views import send_message, list_messages, PostViewSet
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r'posts', PostViewSet)

urlpatterns = [
    path('send', send_message, name='send_message'),
    path('list', list_messages, name='list_messages'),
    path('', include(router.urls)),
]