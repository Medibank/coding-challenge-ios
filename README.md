# Medibank iOS Code Challenge

Welcome to the Medibank iOS coding challenge! This is your opportunity to demonstrate your skills in **SwiftUI**, app architecture, modular development, and testing practices by building a small yet complete iOS app.

---

## 🎯 Challenge Overview
You are not expected to build a production-level app. Instead, we’re looking at how you structure your code, prioritise tasks, and communicate trade-offs.
Develop a proof-of-concept news reader app using **SwiftUI**. The app will fetch and display trending articles from NewsAPI, allow users to filter by sources, and support saving articles for later reading.

---

## 🧱 Functional Requirements

### Main Navigation (Tab View)
Your app should include a TabView with three tabs:

#### 1. **Headlines Tab**
- Displays a list of articles based on selected sources
- Each row should include: **title, description, author, and thumbnail image**
- Tapping a row should open the article in a **WebView** within the app
- Users should be able to **save articles** from this view
- Handle empty states gracefully (e.g., no sources selected, no results)

#### 2. **Sources Tab**
- Displays a list of available article sources (English only)
- Allow users to select multiple sources
- Selection should **persist across app launches**

#### 3. **Saved Tab**
- Displays a list of articles previously saved by the user
- Tapping a saved article should open it in a WebView
- Users should be able to **delete saved articles**
- Saved articles must **persist across app launches**

### Networking
- Use NewsAPI to fetch headlines and sources (https://newsapi.org/)
- Register for a free API key 
- API will return the latest 10 articles per source — pagination not required
- Use **URLSession** or a custom networking layer
- Do **not** use any 3rd-party NewsAPI clients

### Architecture
- Follow **MVVM** architecture
- Use `ObservableObject`, `@State`, `@Published`, and `@EnvironmentObject` appropriately
- Structure your code to promote **modularity and reusability**, where applicable

### Persistence
- Use any local persistence method (e.g., `UserDefaults`, local file, CoreData)
- Clearly separate persistence logic for readability

---

## 🧪 Testing Expectations

### ✅ Required
- **Unit Tests:** Cover ViewModels, business logic, and API service

### 🌟 Bonus (Optional)
- **UI Tests:** Use XCUITest to test flows (e.g., open article > save > view saved)
- **Snapshot Tests:** Include snapshot tests for key views (e.g., article cell, detail view)

---

## 📋 Evaluation Criteria
| Category            | Details |
|---------------------|---------|
| **SwiftUI Usage**   | Clean, idiomatic use of SwiftUI and data/state flow |
| **Architecture**    | Scalable structure with clear separation of concerns |
| **Persistence**     | Local storage for sources and saved articles |
| **Testing**         | Unit tests provided; optional UI/snapshot tests |
| **Code Quality**    | Modular, readable, and well-documented code |
| **UX & UI**         | Responsive UI, smooth navigation, and empty state handling |
| **Bonus Points**    | Accessibility support, dark mode, animations, optional testing features |

---

## 🛠 Tools You Can Use
- Xcode 15+
- Swift 5.9+
- Swift Package Manager (SPM) for dependency management

---

## 📌 Suggested Focus Areas
You have 3 days to complete the challenge. We encourage you to focus on delivering what’s most meaningful and practical within the available time:

- A working implementation of the core functionality
- A clear and modular SwiftUI architecture
- A thoughtful approach to data flow and local persistence
- Reasonable test coverage for the business logic (e.g., ViewModels)

You are free to decide the order and approach for implementing the features. The goal is to understand your ability to drive a solution end-to-end, make trade-offs, and demonstrate solid engineering principles.

> ⚠️ **Note:** Bonus items such as snapshot tests, animations, and accessibility enhancements are **appreciated but not expected**. You're encouraged to explain any assumptions, decisions, or partial implementations in comments or a short README. This helps us better understand your approach, even if all features are not completed.

---



---

## 📦 Submission Guidelines
- Develop your solution in your own codebase
- Complete and submit your project within **3 days** of receiving it
- Share a link to your completed project using **any code sharing platform** (e.g., GitHub, GitLab, Bitbucket, or similar)

We look forward to reviewing your code. If you have any questions, feel free to reach out.

Good luck, and have fun building! 🚀
