from PIL import Image
import numpy as np

HEX_FILE = "output.hex"
OUTPUT_IMAGE = "reconstructed.png"

# Read all hex values
with open(HEX_FILE, "r") as f:
    content = f.read()

# Split by whitespace (handles spaces and newlines)
hex_values = content.split()

# Convert hex -> integers
pixels = [int(x, 16) for x in hex_values]

# Verify size
if len(pixels) != 784:
    raise ValueError(
        f"Expected 784 pixels, found {len(pixels)}"
    )

# Convert to 28x28 array
img_array = np.array(
    pixels,
    dtype=np.uint8
).reshape((28, 28))

# Create image
img = Image.fromarray(img_array, mode="L")

# Optional: enlarge for visibility
img = img.resize(
    (280, 280),
    Image.Resampling.NEAREST
)

# Save
img.save(OUTPUT_IMAGE)

print(
    f"Image saved as {OUTPUT_IMAGE}"
)