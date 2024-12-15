# Photo Album App

## Overview 🎨📸✨
The app is a simple photo album viewer that allows users to:
1. **View a list of albums** belonging to a user on the home screen.
2. **Navigate to album details** to see photos within a selected album.
3. **Access the user profile screen** by tapping the user's name.
4. **Open any image** in a full-screen viewer with zooming and sharing functionality. 🎉

## Features 📱🌟🖼️
### Screen Breakdown
1. **Home Screen** 🎯
   - Displays the user's name pinned at the top.
   - Lists all the albums of the user.
   - Navigation options:
     - Tap on an album to navigate to the Album Details screen.
     - Tap on the user's name to navigate to the User Profile screen. 🚀

2. **Album Details Screen** 🖼️
   - Displays a collection of photos from the selected album.
   - Tap any photo to open it in a full-screen viewer. 

3. **User Profile Screen** 📋
   - Displays the user's information including name, username, email, address, phone, and company details.

4. **Image Viewer** ✨
   - Opens images in a full-screen view.
   - Allows pinch-to-zoom functionality.
   - Includes a share button for easy sharing of the image.

## Technical Specifications ⚙️💻📲
- **Programming Language**: Swift 5.5
- **Development Environment**: Xcode 13.1
- **Supported iOS Version**: iOS 13+

## How to Run the App 🏃‍♂️🛠️📱
1. Clone the repository.
2. Open the project in Xcode 13.1 or later.
3. Ensure the deployment target is set to iOS 13 or higher.
4. Build and run the app on a simulator or a physical device. 🚀

## Dependencies 📦✨🔧
- **Moya**: For network abstraction and API calls.
- **SwiftMessages**: For user-friendly notifications.
- **SDWebImage**: For asynchronous image loading and caching.
- **SKPhotoBrowser**: For full-screen image viewing with zoom and sharing functionalities. 🎯

## Architecture 🏗️🧩📐
The app follows a **Coordinated MVC (Model-View-Controller)** architecture pattern, with dependencies such as **Moya** for network abstraction, **SwiftMessages** for notifications, and **SKPhotoBrowser** for image viewing seamlessly integrated into this architecture. 🎨
- **Coordinator Pattern**: Handles navigation logic. 🔄
- **Combine Framework**: Manages asynchronous tasks and bindings. ⏳

## Future Enhancements 🔮💡🚀
- Add a search functionality for albums and photos.
- Include pagination for album and photo loading.
- Improve user interface with additional animations. 🌟

## Contact ✉️🤝📫
For any queries or feedback, reach out to CS.AhmedOsman@gmail.com. 📬✨
