from django.shortcuts import render, redirect
from django.http import JsonResponse
from chat_app.models import ChatMessage
from chatbot.settings import GENERATIVE_AI_KEY
import google.generativeai as genai
import json
from django.views.decorators.csrf import csrf_exempt
import os
# Create your views here.
@csrf_exempt
def send_message(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            user_message = data.get('text')
            
            os.environ["GRPC_VERBOSITY"] = "ERROR"
            os.environ["GLOG_minloglevel"] = "2"
            genai.configure(api_key=GENERATIVE_AI_KEY)
            model = genai.GenerativeModel("gemini-pro")
        
            bot_response = model.generate_content(user_message)
            response = bot_response.text
            response = response.replace('*', '')
            
            return JsonResponse({"status": "success", "message": response}, status=200)
        
        except json.JSONDecodeError:
            return JsonResponse({"status": "fail", "message": "Invalid JSON"}, status=400)
    
    else: 
        return JsonResponse({'status': 'fail', 'message': 'Invalid request method'}, status=405)
