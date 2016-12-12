from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse

from .forms import TodoForm
from .models import TodoItem


def index(request):
    todo_items = TodoItem.objects.order_by('-priority')
    context = {
        'unchecked': [i for i in todo_items if not i.checked],
        'checked': [i for i in todo_items if i.checked],
        'form': TodoForm(),
    }
    return render(request, template_name='todo/index.html', context=context)


def insert(request):
    """Insert a new todo item."""
    try:
        description = request.POST['description']
        priority = request.POST['priority']
    except KeyError:
        # Invalid POST data, redirect to index
        return HttpResponseRedirect(reverse('todo:index'))

    todo = TodoItem(description=description, priority=priority)
    todo.save()

    return HttpResponseRedirect(reverse('todo:index'))


def check(request):
    """Mark a task as done or undone.

    The task ID should be sent as a GET parameter.
    """
    try:
        item_id = request.GET['id']
        item = TodoItem.objects.get(id=item_id)
    except (KeyError, TodoItem.DoesNotExist):
        # Invalid POST data, redirect to index
        return HttpResponseRedirect(reverse('todo:index'))

    if item.checked:
        item.checked = False
    else:
        item.checked = True
    item.save()

    return HttpResponseRedirect(reverse('todo:index'))


def clear(request):
    """Delete all Tasks."""
    TodoItem.objects.all().delete()

    return HttpResponseRedirect(reverse('todo:index'))

