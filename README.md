# AarogyaGram 2.0 — Rural Healthcare & Maternal Wellbeing Assistant

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Google Gemini API](https://img.shields.io/badge/Google_Gemini_API-8E75B2?style=for-the-badge&logo=google&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![MIT License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)

**AarogyaGram** is an AI-powered rural healthcare and maternal wellbeing mobile app built with Flutter. Designed to bridge the gap in medical access for underserved communities, it features 1-tap emergency SOS, intelligent AI health consultations via the Google Gemini API, local-language medical translation, and an offline-first medication tracker.

---

## 📥 Download and Test
You can download the pre-compiled Android APK directly from this repository to test it on your device:
*   👉 **[Download AarogyaGram Release APK](https://github.com/jvstin47/AroggyaGram/raw/main/builds/aarogyagram-release.apk)**

---

## 🌟 Key Features

*   **1-Tap Emergency SOS (Safety-First)**:
    *   Centered, persistent floating SOS button available on every screen.
    *   **Fail-safe coordinates fetching**: Requests Geolocator GPS coordinates to build a Google Maps link. If GPS fails or permissions are denied, it gracefully falls back to sending an SMS without location details rather than failing silently.
    *   **Direct voice calls**: Allows instant caregiver calling on the emergency fallback screen.
*   **AI Health Consultation**:
    *   Intelligent, structured medical symptom analysis powered by Google Gemini API.
    *   Outputs possible conditions, risk levels (LOW/MEDIUM/HIGH), emergency warnings, and advice.
    *   Safety-critical bubble styling triggers a clear alert on HIGH risk warnings.
*   **Medication Tracker**:
    *   Neumorphic adherence checklist supporting creation, completion, and local persistence across app restarts using `shared_preferences`.
    *   Integrated with dynamic AI health scheduling insights.
*   **Medical Translation**:
    *   Seamless offline-first translation between English and regional Indian languages (Malayalam, Hindi, Tamil, Bengali) for prescriptions and symptoms.
*   **Digital Pharmacy**:
    *   2x2 grid representing essential medicines with regional currency pricing (₹) and offline coming-soon tap targets.
*   **Accessibility & Low-Resource Polish**:
    *   Legible typography (`Noto Sans` & `JetBrains Mono`) optimized for low-contrast outdoor/direct sunlight environments.
    *   All interactive elements have clear visual text labels (no icon-only buttons) for screen readers and novice users.

---

## 🛠️ Technology Stack

*   **Frontend**: Flutter (Dart)
*   **State Management**: Provider
*   **Local Storage**: Shared Preferences
*   **APIs**: Google Gemini API, LibreTranslate
*   **Sensors**: Geolocator (GPS)
*   **Launcher**: URL Launcher (SMS/Tel protocol)
*   **Visual Design**: Custom Neumorphic & Glassmorphic theme

---

## 🚀 Setup & Installation

### 1. Prerequisites
Ensure you have the Flutter SDK installed on your machine.
```bash
flutter --version
```

### 2. Configure Environment Variables
AarogyaGram requires a Gemini API key. Create a `.env` file in the root of the project:
```bash
cp .env.example .env
```
Open `.env` and paste your Google Gemini API key:
```env
GEMINI_API_KEY=your_actual_api_key_here
```
> **Security Note:** The `.env` file is excluded from Git tracking via `.gitignore` to prevent api keys from leaking into public repositories.

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run the Project
```bash
flutter run
```

---

## 🛡️ Safety Disclaimer
AarogyaGram is a proof-of-concept system. AI health consultation results are preliminary guides only and do not replace professional clinical diagnoses. In case of serious symptoms, users are instructed to use the SOS utility or call emergency services immediately.

---

## 🤝 Contributing
Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/jvstin47/AroggyaGram/issues) if you want to contribute. Let's make rural healthcare better together!

---

## 📄 License
This project is licensed under the [MIT License](LICENSE).

---

## 🏷️ Keywords / Tags
`Flutter` `Dart` `Rural Healthcare` `Maternal Wellbeing` `Google Gemini API` `AI Health Assistant` `Emergency SOS App` `Medical Translation` `Neumorphic UI` `Medication Tracker` `Android APK` `Open Source`
