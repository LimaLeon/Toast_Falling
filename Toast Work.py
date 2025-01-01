import matlab.engine
from PIL import Image
import numpy as np


# Start MATLAB engine
eng = matlab.engine.start_matlab()

eng.addpath(r'C:\\Users\\ortiz\\OneDrive\\Documents\\MATLAB\\Toast')

# Read image using sci py.misc.imread (Just like how MATLAB using imread)
image_path = r'C:\\Users\\ortiz\\OneDrive\Documents\\MATLAB\\Toast\\Toast_1.png'
image = Image.open(image_path)

# Convert the image to a NumPy array (RGB)
image_np = np.array(image)

# Check if the image has 4 channels (RGBA)
if image_np.shape[2] ==4:
    #Drop the alpha channel to convert to RGB (3 channels)
    image_np = image_np[:, :, :3]
    print("Alpha channel detected, converted to RGB.")
elif image_np.shape[2] != 3:
    raise ValueError("Input image must have 3 channels (RGB).")

# Ensures the NumPy array is contiguous in memory
image_np = np.ascontiguousarray(image_np)

# Convert the NumPy array to a MATLAB-compatible format (uint8)
image_matlab = matlab.uint8(image_np.tolist())

# Print the shape of the MATLAB array (to ensure it's in the correct format)
print("Shape of image_matlab:", np.array(image_matlab).shape)

# Call the createMask function from MATLAB
BW, maskedRGBImage = eng.createMask(image_matlab, nargout=2)

# Convert the MATLAB arrays back to Python (NumPy arrays)
BW = np.array(BW)
maskedRGBImage = np.array(maskedRGBImage)

# Displays outputs in Python
print("Binary Mask:", BW)
print("Masked RGB Image:", maskedRGBImage)

import matplotlib.pyplot as plt

# Display the masked RGB image
plt.imshow(maskedRGBImage)
plt.axis('off')  # Hide axis for better viewing
plt.show()


#Note: Convert the image to a list of lists as MATLAB expects MATLAB-style arrays
# Stop MATLAB engine
eng.quit()
