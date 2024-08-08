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
            index = data.get('length')
            print(index)
            os.environ["GRPC_VERBOSITY"] = "ERROR"
            os.environ["GLOG_minloglevel"] = "2"
            genai.configure(api_key=GENERATIVE_AI_KEY)
            model = genai.GenerativeModel("gemini-pro")
            if index == '2':
                print('case_1')
                response = '좀 더 구체적으로 상황을 말해주세요'
            elif index == '4':
                print('case_2')
                user_message = user_message +'정중하고 예의바르게 구체적인 상황에 대해 공감만 해줘.'
                bot_response = model.generate_content(user_message)
                response = bot_response.text
                response = response.replace('*', '') + '\n이 상황을 극복하는데 도움이 될 만한 해결책을 알려드릴까요?'
                
            else:
                print('case_3')
                user_message = user_message 
                bot_response = model.generate_content(user_message)
                response = bot_response.text
                response = response.replace('*', '')
            print(response)
            return JsonResponse({"status": "success", "message": response}, status=200)
        
        except json.JSONDecodeError:
            return JsonResponse({"status": "fail", "message": "Invalid JSON"}, status=400)
    
    else: 
        return JsonResponse({'status': 'fail', 'message': 'Invalid request method'}, status=405)
