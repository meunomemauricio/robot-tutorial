# -*- coding: utf-8 -*-
# Generated by Django 1.10.4 on 2016-12-10 20:39
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('todo', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='todoitem',
            name='checked',
            field=models.BooleanField(default=False),
        ),
        migrations.AlterField(
            model_name='todoitem',
            name='priority',
            field=models.IntegerField(choices=[(0, 'None'), (1, 'Low'), (3, 'Medium'), (4, 'High')]),
        ),
    ]
