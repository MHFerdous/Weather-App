# **Weather App**

This app detects the user's current location and fetches weather information, including temperature and forecasts, using the OpenWeather API.

---

### **APK File** 

[Click here](https://drive.google.com/drive/folders/1vh5AAkcf95zs0MjaBu-hA0tCCH2SDLsi?usp=sharing)

---

### **Setup Steps**

1. **Clone the Repository**
   Open Android Studio, go to File -> New -> Project from Version Control, then paste the repository link. Or
   ```bash
   git clone https://github.com/MHFerdous/weather_app
   ```
   ```bash
   cd weather_app
   ```
   ```bash
   flutter pub get
   flutter run
   ```

   ---


## **Tech Stack**

- **Framework:** Flutter
- **Controller:** GetX

---

## **Features**

### **1. Location Detection**
- Automatically detects the user's current location using the device's GPS.
- Displays the detected location at the top of the screen.

### **2. Temperature Display**
- Fetches and displays the current temperature and a corresponding weather icon using the OpenWeather API.

### **3. forecast for Today and Upcoming Days**
- Provides a button to toggle between today's temperature and a 5-day forecast.
- Displays forecast data horizontally in cards, including date, temperature and weather icons.

### **4. Additional Weather information**

- Displays detailed weather information such as:
  - Sunrise & sunset times
  - Wind speed
  - Atmospheric pressure
  - Visibility
- Presented in a vertical card layout.

---

### **ScreenShot**

![Screenshot_20241228_012805](https://github.com/user-attachments/assets/28ad5853-bbe2-4c58-8627-dc88fcc53f51)

---
