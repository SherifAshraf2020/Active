# Active 🏆 Sports App

A native iOS sports application built using **Swift** and the **MVP Architecture Pattern**.  
The app allows users to explore sports leagues, view league details, browse teams, and manage favorite leagues with local persistence.

---

## 📱 Features

- Browse different sports categories
- View leagues for each sport
- League details screen including:
  - Upcoming events
  - Latest results
  - Teams list
- Team details screen
- Add / remove leagues from favorites
- Offline favorites persistence
- Dark mode support
- Loading, empty, and error states handling
- Placeholder images for missing API assets
- Unit testing support

---

## 🏗️ Architecture

The project follows the **MVP (Model - View - Presenter)** architecture to achieve:

- Better separation of concerns
- Easier testing
- Improved scalability
- Cleaner code structure

### Layers

- **Model** → Handles data structures and API models
- **View** → UIKit ViewControllers & Views
- **Presenter** → Business logic and communication between Model & View

---

## 🛠️ Tech Stack

- Swift
- UIKit
- MVP Architecture
- Alamofire
- Kingfisher
- CoreData
- XCTest

---

## 📂 Project Structure

```bash
Active
│
├── Models
├── Views
├── Presenters
├── Network
├── Persistence
├── Utilities
├── Resources
└── Tests
```

---

## 🌐 API

The app uses sports APIs to fetch:

- Sports categories
- Leagues
- Fixtures
- Teams
- Results

---

## 🧪 Unit Testing

The project includes unit tests for:

- Presenters
- Network layer
- Mock API responses
- Business logic validation

### Coverage

- XCTest framework used
- Mock services implemented for dependency injection
- Targeted coverage above 50%

---

## 🎨 UI Highlights

- Dynamic dark/light appearance
- Custom collection & table view cells
- Smooth image loading using Kingfisher
- Responsive layouts
- Modern sports-themed interface

---

## 🚀 Getting Started

### Requirements

- Xcode 16+
- iOS 17+
- Swift 5+

### Installation

1. Clone the repository

```bash
git clone https://github.com/SherifAshraf2020/Active.git
```

2. Open the project

```bash
cd Active
open Active.xcodeproj
```

3. Install dependencies (if using CocoaPods)

```bash
pod install
```

4. Run the project on Simulator or Device

---


## 👨‍💻 Contributors

- Sherif Ashraf  onboarding,sports,part of favorite,TeamDetails
- Yomna Elzairy   splash,leagues,leagueDetails,part of favorite

---

## 🔗 Repository

[Active GitHub Repository](https://github.com/SherifAshraf2020/Active)

---

## 📄 License

This project is for educational purposes and training projects.
<img width="679" height="92" alt="Screenshot 2026-05-16 at 4 11 56 AM" src="https://github.com/user-attachments/assets/f8f8048e-2827-4114-a9c5-7e204daa33de" />


