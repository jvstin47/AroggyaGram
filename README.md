# AarogyaGram 2.0 — Rural Healthcare & Maternal Wellbeing Assistant

AarogyaGram is a proof-of-concept Flutter mobile application designed to bridge healthcare access gaps in rural areas and provide integrated support for maternal emergencies. It leverages the Google Gemini API to provide safety-first, intelligent health guidance, local-language translation, medication tracking, and a robust fail-safe emergency SOS mechanism.

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
