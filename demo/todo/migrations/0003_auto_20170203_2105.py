# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-02-03 21:05
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('todo', '0002_auto_20161210_2039'),
    ]

    operations = [
        migrations.AlterField(
            model_name='todoitem',
            name='priority',
            field=models.IntegerField(choices=[(0, b'None'), (1, b'Low'), (2, b'Medium'), (3, b'High')]),
        ),
    ]
