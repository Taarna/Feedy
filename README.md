Requirements

- As a user, I can add an RSS feed by specifying an RSS feed URL.
- As a user, I can remove RSS feeds.
- As a user, I can see added RSS feeds.
- Each RSS feed presentation includes the RSS feed name, image (if it exists), and description.
- As a user, I can select an RSS feed to open a screen with the RSS feed items.
- Each RSS feed item presentation includes an image (if it exists), title, and description.
- As a user, I can select an RSS item to access the related website/feed.
- The app can open an RSS item link in WebView or the device's browser.

## Thought Process and Technologies Used

Returning to native iOS development after a long pause, I was curious about technologies I haven't used before, 
opting for SwiftUI and SwiftData to develop this app. Downloading and parsing of XML files is done using FeedKit library.

**Future Enhancements and Known Issues**

Due to limited time, the following enhancements and fixes were not implemented:

- Implementing notifications for new feed items for subscribed RSS feeds (was planning to use local notifications for this one). 
- Either stripping down HTML tags from titles/descriptions or finding a way to display HTML content instead of plain strings.
- Improved error handling throughout the app.
- More informative error messages to enhance user experience.
- Implementing a unique constraint on Feed.url to prevent duplicate entries in the database.
