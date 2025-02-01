from django.http import JsonResponse

def faq_list(request):
    data = {
        "message": "FAQs API is working!",
        "faqs": [
            {"question": "What is Django?", "answer": "Django is a web framework for Python."},
            {"question": "How to install Django?", "answer": "Use `pip install django`."}
        ]
    }
    return JsonResponse(data)
