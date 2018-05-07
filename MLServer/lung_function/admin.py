# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin
from lung_function.models import LungEquation, PEF, FEF, FVC, FEV1

# Register your models here.
admin.site.register(LungEquation)
admin.site.register(PEF)
admin.site.register(FEF)
admin.site.register(FVC)
admin.site.register(FEV1)