import numpy as np
from objects import DataEquationVisualization

def predict_2(x, params):
    params = np.array(eval(params))
    w = params[0]
    u = params[1]
    b = params[2]

    if(isinstance(x, (list, np.ndarray))):
        y_predict = []
        for i in x:
            y_predict.append(w * i * i + u * i + b)
    else:
        y_predict = w * x * x + u * x + b
    return y_predict

def getDataEquationVisualization(params, lower_bound, higher_bound, num):
    results = []
    input_values = np.linspace(lower_bound, higher_bound, num)
    output_values = predict_2(input_values, params)

    for i in range(0, len(input_values)):
        results.append(DataEquationVisualization(input_values[i], output_values[i]))

    return results


