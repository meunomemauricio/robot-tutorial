from django import forms

from .models import TodoItem


class TodoForm(forms.Form):
    description = forms.CharField(label='ToDo', max_length=200)
    priority = forms.ChoiceField(label='Prio', choices=TodoItem.PRIO_CHOICES)
