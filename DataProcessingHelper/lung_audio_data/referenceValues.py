import math

def getFVC(age, ht, wt):
  return (-5.048-0.014*age+0.054*ht+0.006*wt + 0.479**2/2)

def getFEV1(age, ht):
  return -3.628-0.024*age+0.046*ht + 0.402**2/2

def getPEF(age, ht):
  return math.exp(0.346-0.004*age+0.011*ht + 0.158**2/2)
