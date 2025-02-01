from django import forms
from .models import FAQ

class FAQForm(forms.ModelForm):
    class Meta:
        model = FAQ
        fields = ['question', 'answer']
        widgets = {
            'answer': forms.Textarea(attrs={'rows': 4, 'cols': 40}),
        }
