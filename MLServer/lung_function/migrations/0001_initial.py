# -*- coding: utf-8 -*-
# Generated by Django 1.11.12 on 2018-04-24 01:49
from __future__ import unicode_literals

from django.db import migrations, models
import lung_function.models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='LungEquation',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('target_value', models.CharField(max_length=255)),
                ('order', models.IntegerField()),
                ('params', lung_function.models.ListField()),
            ],
        ),
    ]
