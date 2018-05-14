import os
import time
import numpy as np
import tensorflow as tf

import learning

def readData(dataset):
    input_values = [float(obj.input_value) for obj in dataset]
    output_values = [float(obj.output_value) for obj in dataset]
    dataset = list(zip(input_values, output_values))
    dataset = np.asarray(dataset, dtype=np.float32)

    return dataset
    
def training(dataset, learningRate, iterations):
    n_samples = len(dataset)

    X = tf.placeholder(tf.float32, name='X')
    Y = tf.placeholder(tf.float32, name='Y')

    w = tf.get_variable('w', initializer=tf.constant(0.0))
    u = tf.get_variable('u', initializer=tf.constant(0.0))
    b = tf.get_variable('b', initializer=tf.constant(0.0))

    Y_predicted = w * X *X + u * X + b 
    loss = tf.square(Y - Y_predicted, name='loss')
    optimizer = tf.train.GradientDescentOptimizer(learning_rate=learningRate).minimize(loss)
    start = time.time()
    writer = tf.summary.FileWriter('./graphs/non_linear_reg', tf.get_default_graph())

    with tf.Session() as sess:
        sess.run(tf.global_variables_initializer())

        for i in range(iterations):
            total_loss = 0
            for x, y in dataset:
                _, loss_ = sess.run([optimizer, loss], feed_dict={X: x, Y:y})
                total_loss += loss_

            print('Epoch {0}: {1}'.format(i, total_loss/n_samples))
        writer.close()
        
        w_out, u_out, b_out = sess.run([w, u, b])
        mse = total_loss/n_samples

    return w_out, u_out, b_out, mse

def getTestError(w_out, u_out, b_out, test_dataset):
    n_samples = len(test_dataset)
    x_test = test_dataset[:,0]
    y_test = test_dataset[:,1]

    error = np.sum(np.abs(y_test - learning.predict_2(x_test, str([w_out, u_out, b_out])))*100/y_test)/n_samples

    return error