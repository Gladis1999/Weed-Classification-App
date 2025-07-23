# Weed Detection in Precision Farming

## Description  
A mobile app that identifies weeds in crop fields using transfer learning with MobileNetV2. It enables farmers to detect weeds in real-time and offline, improving precision farming practices.

## Features  
- Real-time weed identification using camera input  
- Offline inference with TensorFlow Lite integration  
- High accuracy with 94.7% precision and 92.4% recall

## Technologies Used  
- Python, TensorFlow, TensorFlow Lite  
- Flutter for mobile app development  
- MobileNetV2 transfer learning model

## Installation & Setup  
1. Clone this repository  
2. For model training, install Python dependencies:  
   `pip install -r requirements.txt`  
3. For running the mobile app, install Flutter and open the `mobile_app` folder  
4. Run the Flutter app on your device or emulator

## Usage  
Open the app, point the camera to crops, and get live weed detection results instantly.

## Results  
- Achieved 94.7% precision and 92.4% recall on 2,400 annotated images
