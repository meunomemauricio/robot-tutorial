from django.db import models


class TodoItem(models.Model):
    PRIO_CHOICES = (
        (0, 'None'),
        (1, 'Low'),
        (2, 'Medium'),
        (3, 'High'),
    )

    description = models.CharField(max_length=200)
    priority = models.IntegerField(choices=PRIO_CHOICES)
    checked = models.BooleanField(default=False)

    def __str__(self):
        return '[{0}]{1}({2})'.format(self.id, self.description, self.priority)
