# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models
import ast

# Create your models here.

class ListField(models.TextField):
    description = "Stores a python list"

    def __init__(self, *args, **kwargs):
        super(ListField, self).__init__(*args, **kwargs)

    def to_python(self, value):
        if not value:
            value = []

        if isinstance(value, list):
            return value

        return ast.literal_eval(value)

    def get_prep_value(self, value):
        if value is None:
            return value

        return unicode(value)

    def value_to_string(self, obj):
        value = self._get_val_from_obj(obj)
        return self.get_db_prep_value(value)

class LungEquation(models.Model):
    target_value = models.CharField(max_length=255)
    order = models.IntegerField()
    params = ListField()
    learning_rate = models.FloatField(null=True)
    iterations = models.IntegerField(null=True)
    ms_error = models.FloatField(null=True)
    dataset_size = models.IntegerField(null=True)
    proportion = models.FloatField(null=True)
    test_err = models.FloatField(null=True)

class Dataset(models.Model):
    input_value = models.FloatField()
    output_value = models.FloatField()
    trained = models.BooleanField()

    class Meta:
        abstract = True

class PEF(Dataset):
    pass

class FEF(Dataset):
    pass

class FVC(Dataset):
    pass

class FEV1(Dataset):
    pass
