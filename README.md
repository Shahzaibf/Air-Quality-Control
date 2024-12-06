# Air Quality Control

## Overview

This app was created as an assignment for Hunter College's IOS development Coursework. Air Quality Control is an iOS application designed for to help users monitor and analyze air quality in their surroundings. The app provides detailed air quality index (AQI) information and pollutant levels for various locations using data from the OpenWeatherMap API.

---

## Features

- **Home Page**:

  - Displays key air quality information for the user's current location.
  - A "More Information" button to view detailed statistics about air quality components.

- **Location-Based Air Quality**:

  - Use location services to fetch real-time air quality data for the current or searched location.
  - Manual city search with a responsive search bar, supporting up to 5 city suggestions.

- **Air Quality Insights**:

  - View pollutant levels, including CO, NO, NO2, O3, SO2, PM2.5, PM10, and NH3.
  - Color-coded indicators for pollutant severity (e.g., green, yellow, orange, red).

---

## Technologies Used

- **Swift and SwiftUI** for building the user interface.
- **OpenWeatherMap API** for real-time air quality and geolocation data.
- **URLSession** for API requests.
- **CoreLocation** for obtaining user location.

---

## Architecture

The app is structured to ensure separation of concerns and modularity:

- **API**:

  - `APIError.swift`: Handles API-related errors.
  - `AQIFetcher.swift`: Manages API requests and data fetching for AQI and pollutant levels.

- **Models**:

  - `AQI.swift`: Represents AQI and pollutant data.
  - `City.swift`: Encapsulates city-related data for location-based searches.
  - `FavoriteStore.swift`: Manages user favorite locations.
  - `LocationManager.swift`: Handles location services and user permission prompts.

- **Views**:

  - `CityView.swift`: Displays detailed AQI and pollutant information for a selected city.
  - `ContentView.swift`: Acts as the main entry point for the app.
  - `FavoritesListView.swift`: Shows a list of user-saved favorite locations.
  - `HomePageView.swift`: Displays air quality details for the user's current location.
  - `InformationView.swift`: Provides detailed pollutant statistics.
  - `SearchView.swift`: Implements the city search functionality.

- **Modifiers**:
  - Custom SwiftUI modifiers to streamline view design and layout.

---

## Installation

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/your-repo/AirQualityControl.git
   ```
2. Open the project in Xcode.
3. Install dependencies if any.
4. Add your API key and run the project on a simulator or a physical device.

---

## Usage

1. Allow location access when prompted.
2. View air quality details for your current location.
3. Use the search feature to find air quality information for a specific city.
4. Tap "More Information" to explore detailed pollutant statistics.

---

## API Configuration

1. Sign up for a free API key at [OpenWeatherMap](https://openweathermap.org/).
2. Add your API key to the project by updating the `apiKey` variable in the `AQIFetcher` file:
   ```swift
   let apiKey: String = "YOUR_API_KEY"
   ```
