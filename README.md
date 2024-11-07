# Flutter News App

A Flutter-based news app inspired by Inshorts, enabling users to read and swipe through concise news articles across various categories. With a sleek UI and intuitive navigation, this app allows users to quickly access news, bookmark favorite articles, and switch categories with ease.

## Features

- **Swipe Navigation**: Seamlessly swipe up or down to browse through news articles in a short and engaging format.
- **Category Selection**: Choose from categories such as National, Business, Sports, Technology, Entertainment, and more to personalize the news feed.
- **Bookmark Articles**: Save articles for offline reading. Easily access saved bookmarks on the dedicated Bookmarks page.
- **Pop-up Notifications**: Get instant feedback with a "Bookmarked Successfully" notification when saving articles.
- **Persistent Storage**: Bookmark data is saved locally using `SharedPreferences`, allowing articles to be accessible even after app restart.
- **Bottom-Positioned Category Dropdown**: Select categories via a dropdown at the bottom of the screen with an upward-facing arrow for easy access.

## Tech Stack

- **Flutter**: Fast, cross-platform app development with a native experience.
- **HTTP**: REST API integration to fetch real-time news articles.
- **SharedPreferences**: Persistent local storage for saved bookmarks.
- **GNews API**: Fetches real-time news articles in various categories (requires an API key).

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Mahima05/NewsApp.git
   ```
   Extract the zip file named news_app_2, then
   ```bash
   cd news_app_2
   ```

3. **Install dependencies**:
   ```bash
   flutter pub get
   ```

4. **Get a GNews API key**:
   - Register on [GNews](https://gnews.io/) to get your API key.
   - Replace the API key in `news_screen.dart`.

5. **Run the app**:
   ```bash
   flutter run
   ```






