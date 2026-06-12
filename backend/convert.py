from PIL import Image, ImageOps
import os

# ==========================================
# Paths
# ==========================================

BASE_DIR = os.path.dirname(__file__)

INPUT_IMAGE = os.path.join(
    BASE_DIR,
    "png",
    "drawing.png"
)

OUTPUT_HEX = os.path.join(
    BASE_DIR,
    "..",
    "ai-models",
    "output.hex"
)

OUTPUT_PREVIEW = os.path.join(
    BASE_DIR,
    "..",
    "ai-models",
    "processed.png"
)

# ==========================================
# Verify image exists
# ==========================================

if not os.path.exists(INPUT_IMAGE):
    raise FileNotFoundError(
        f"Input image not found:\n{INPUT_IMAGE}"
    )

# ==========================================
# Load image
# ==========================================

img = Image.open(INPUT_IMAGE).convert("L")

# ==========================================
# Convert black strokes to white
# MNIST expects white digit on black background
# ==========================================

img = ImageOps.invert(img)

# ==========================================
# Find bounding box of drawing
# ==========================================

bbox = img.getbbox()

if bbox is not None:
    img = img.crop(bbox)

# ==========================================
# Resize while preserving aspect ratio
# Fit inside 20x20 region
# ==========================================

img.thumbnail((20, 20))

# ==========================================
# Create centered 28x28 canvas
# ==========================================

canvas = Image.new(
    "L",
    (28, 28),
    0
)

x_offset = (28 - img.width) // 2
y_offset = (28 - img.height) // 2

canvas.paste(
    img,
    (x_offset, y_offset)
)

img = canvas

# ==========================================
# Save preview image
# Useful for debugging
# ==========================================

img.save(OUTPUT_PREVIEW)

# ==========================================
# Export HEX file
# ==========================================

pixels = list(img.getdata())

with open(OUTPUT_HEX, "w") as f:

    for pixel in pixels:

        pixel = int(pixel)

        f.write(
            f"{pixel:02X}\n"
        )

# ==========================================
# Stats
# ==========================================

print("--------------------------------")
print("Image preprocessing complete")
print("--------------------------------")
print("Input :", INPUT_IMAGE)
print("Preview:", OUTPUT_PREVIEW)
print("HEX :", OUTPUT_HEX)
print("Pixels:", len(pixels))
print("Min :", min(pixels))
print("Max :", max(pixels))
print("--------------------------------")