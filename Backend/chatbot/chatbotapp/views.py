from django.shortcuts import redirect, render
from chatbot.settings import GENERATIVE_AI_KEY
from chatbotapp.models import ChatMessage
import google.generativeai as genai

from rest_framework import viewsets
from .models import Post
from .serializers import PostSerializer

class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    serializer_class = PostSerializer

def send_message(request):
    if request.method == 'POST':
        genai.configure(api_key=GENERATIVE_AI_KEY)
        model = genai.GenerativeModel("gemini-1.5-flash")

        user_message = request.POST.get('user_message')
        bot_response = model.generate_content(user_message)

        ChatMessage.objects.create(user_message=user_message, bot_response=bot_response.text)

    return redirect('list_messages')

def list_messages(request):
    messages = ChatMessage.objects.all()
    return render(request, 'chatbot/list_messages.html', { 'messages': messages })