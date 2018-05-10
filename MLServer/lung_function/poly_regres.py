import os
import time
import numpy as np
import tensorflow as tf
import utils

def readData(dataset):
    input_values = [float(obj.input_value) for obj in dataset]
    output_values = [float(obj.output_value) for obj in dataset]
    dataset = list(zip(input_values, output_values))
    dataset = np.asarray(dataset, dtype=np.float32)

    return dataset
    
def traning(dataset, learningRate, iterations):
    n_samples = len(dataset)

    X = tf.placeholder(tf.float32, name='X')
    Y = tf.placeholder(tf.float32, name='Y')

    w = tf.get_variable('weights_1', initializer=tf.constant(0.0))
    u = tf.get_variable('weights_2', initializer=tf.constant(0.0))
    b = tf.get_variable('bias', initializer=tf.constant(0.0))

    Y_predicted = w * X *X + u * X + b 
    loss = tf.square(Y - Y_predicted, name='loss')
    optimizer = tf.train.GradientDescentOptimizer(learning_rate=learningRate).minimize(loss)
    start = time.time()
    writer = tf.summary.FileWriter('./graphs/linear_reg', tf.get_default_graph())

    with tf.Session() as sess:
        sess.run(tf.global_variables_initializer())

        for i in range(iterations):
            total_loss = 0
            for x, y in data:
                _, loss_ = sess.run([optimizer, loss], feed_dict={X: x, Y:y})
                total_loss += loss_

            print('Epoch {0}: {1}'.format(i, total_loss/n_samples))
        writer.close()
        
        w_out, u_out, b_out = sess.run([w, u, b])
