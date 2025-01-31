# Create your models here.
from django.db import models
from ckeditor.fields import RichTextField
from googletrans import Translator
from django.core.cache import cache

LANGUAGES = ["hi", "bn"]  # Hindi, Bengali

class FAQ(models.Model):
    question = models.TextField()
    answer = RichTextField()
    question_hi = models.TextField(blank=True, null=True)
    question_bn = models.TextField(blank=True, null=True)

    def save(self, *args, **kwargs):
        translator = Translator()
        for lang in LANGUAGES:
            field_name = f"question_{lang}"
            if not getattr(self, field_name):
                setattr(self, field_name, translator.translate(self.question, dest=lang).text)
        super().save(*args, **kwargs)

    def get_translated_question(self, lang):
        if lang in LANGUAGES:
            cached_question = cache.get(f"faq_{self.id}_{lang}")
            if cached_question:
                return cached_question

            translated_text = getattr(self, f"question_{lang}", self.question)
            cache.set(f"faq_{self.id}_{lang}", translated_text, timeout=3600)
            return translated_text
        return self.question  # Default to English
