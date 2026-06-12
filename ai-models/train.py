import numpy as np
import tensorflow as tf
from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense

# Load MNIST
(x_train, y_train), (x_test, y_test) = mnist.load_data()

# Normalize
x_train = x_train.astype(np.float32) / 255.0
x_test = x_test.astype(np.float32) / 255.0

# Flatten 28x28 -> 784
x_train = x_train.reshape(-1, 784)
x_test = x_test.reshape(-1, 784)

# Network
model = Sequential([
    Dense(16, activation='relu', input_shape=(784,)),
    Dense(10, activation='softmax')
])

model.compile(
    optimizer='adam',
    loss='sparse_categorical_crossentropy',
    metrics=['accuracy']
)

model.fit(
    x_train,
    y_train,
    epochs=5,
    batch_size=128
)

loss, acc = model.evaluate(x_test, y_test)

print("Accuracy:", acc)

w1 = model.layers[0].get_weights()[0]
b1 = model.layers[0].get_weights()[1]

w2 = model.layers[1].get_weights()[0]
b2 = model.layers[1].get_weights()[1]

print(w1.shape)
# (784, 64)

print(b1.shape)
# (64,)

print(w2.shape)
# (64, 10)

print(b2.shape)
# (10,)
SCALE = 127

w1_q = np.round(w1 * SCALE).astype(np.int8)
b1_q = np.round(b1 * SCALE).astype(np.int8)

w2_q = np.round(w2 * SCALE).astype(np.int8)
b2_q = np.round(b2 * SCALE).astype(np.int8)

def save_hex(arr, filename):

    flat = arr.flatten()

    with open(filename, "w") as f:

        for value in flat:

            f.write(
                f"{int(value) & 0xFF:02X}\n"
            )
save_hex(w1_q, "w1.hex")
save_hex(b1_q, "b1.hex")

save_hex(w2_q, "w2.hex")
save_hex(b2_q, "b2.hex")