# Nooro-WeatherApp

This Weather App provides real-time weather updates for your saved city. It fetches weather data from an API and displays key weather metrics. You can search for and save a city's weather information, which will be displayed on the home screen.

# Features

**1. Home Screen**
- Displays weather details for a single saved city:
  - City name.
  - Temperature.
  - Weather condition (with corresponding icon from the API).
  - Humidity (%).
  - UV index.
  - "Feels like" temperature.
- If no city is saved, the app prompts the user to search for a city.
- Includes a search bar for querying new cities.

**2. Search Behavior**
- Displays a search result card for the queried city.
- Tapping on a search result:
  - Updates the Home Screen with the selected city's weather information.
  - Saves the selected city for persistence.

# Running the Xcode Project

Follow these steps to run the Weather App in Xcode:

**Prerequisites**
- Xcode: Ensure you have Xcode installed (minimum version: 14.0).
- API Key: Obtain an API key from the weather data provider.
- Swift Version: The project is built using Swift 5.

**Setup Instructions**
1. Clone the Repository:
```
git clone https://github.com/kunj2707/Nooro-WeatherApp.git
cd Nooro-WeatherApp
```
2. Open the Project: Open the .xcodeproj file in Xcode:
```
open Nooro-WeatherApp.xcodeproj
```
3. Add API Key:
- Go to the Project Navigator -> Resource -> Configuration -> Production.xcconfig file.
- Replace <YOUR_API_KEY> with your actual API key:
```
API_KEY = <YOUR_API_KEY>
```
4. Build and Run:
- Select a simulator or a connected device in Xcode.
- Press Cmd + R or click the Run button to build and launch the app.

# Notes
- If you encounter issues with the API key or weather data fetching, double-check your configuration and API key validity.
