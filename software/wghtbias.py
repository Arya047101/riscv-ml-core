import tensorflow as tf
import numpy as np
from tensorflow.keras import layers, models

mnist = tf.keras.datasets.mnist
(x_train, y_train), (x_test, y_test) = mnist.load_data()

x_train, x_test = x_train / 255.0, x_test / 255.0

model = models.Sequential([
    layers.Flatten(input_shape=(28, 28)),    # Flattens 28x28 image to 784 vector
    layers.Dense(10, activation='softmax')   # Direct connection to 10 output classes
])

model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

model.fit(x_train, y_train, epochs=5, batch_size=64)

Q_BITS = 8
SCALE = 2**Q_BITS


weights, biases = model.layers[1].get_weights()

import numpy as np

def save_as_fixed_point_hex(data, filename):
    scaled_data = np.round(data * SCALE)
    clipped_data = np.clip(scaled_data, -32768, 32767).astype(np.int16)
    with open(filename, 'w') as f:
        for val in clipped_data.flatten():
            hex_val = val.view(np.uint16)
            f.write(f"{hex_val:04x}\n")
            
    print(f"Saved {filename} in fixed-point Q{Q_BITS} format.")

save_as_fixed_point_hex(weights, 'weights.hex')
save_as_fixed_point_hex(biases, 'biases.hex')

