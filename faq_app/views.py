from django.shortcuts import render, redirect
from django.core.paginator import Paginator
from .models import FAQ
from .forms import FAQForm
from django.utils.translation import get_language

def faq_home(request):
    faqs = FAQ.objects.all()
    lang = get_language()  # Get the current language set in the request (e.g., 'en', 'hi', 'bn')
    
    faq_data = []
    for faq in faqs:
        faq_data.append({
            'question': faq.get_translated_question(lang),
            'answer': faq.answer
        })
    
    return render(request, 'faq_app/faq_list.html', {'faq_data': faq_data})

def faq_create(request):
    if request.method == 'POST':
        form = FAQForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('faq_home')
    else:
        form = FAQForm()
    return render(request, 'faq_app/faq_create.html', {'form': form})
