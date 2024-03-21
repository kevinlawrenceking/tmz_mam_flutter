# TMZ DAMZ

Welcome to the TMZ DAMZ project! This repository contains the source code for a Flutter application developed for TMZ's digital media asset management system.

The project aims to provide a seamless and efficient way to manage, access, and distribute digital media assets across various platforms.

## Features

The **TMZ DAMZ** project includes the following features:

*   **Asset Browsing:** Browse through a catalog of media assets with ease.
*   **Asset Management:** Upload, categorize, and manage assets within the application.
*   **Search Functionality:** Quickly find assets using advanced search filters and tags.
*   **User Authentication:** Secure access to the MAM system with user authentication and authorization.

## Acknowledgments

Special thanks to the Flutter community and the developers behind the numerous packages and tools that make this project possible.

Kudos to the TMZ team for their continuous support and feedback throughout the development process.

## Dev Notes

Run the following command if you add, remove, or modify any app/feature routes:

```
dart run build_runner build --delete-conflicting-outputs
```

Clean and build the web deployment *(outputs to `.\build\web`)*:

```
flutter clean
flutter build web --no-tree-shake-icons --web-renderer canvaskit
```

---

### Running a basic web server to host the web app

Install the `dhttpd` basic web server:

```
dart pub global activate dhttpd
```

Run the web server *(modify `-p` to whatever port you want to use and `--path` to point to wherever the web build is located)*:

```
dart pub global run dhttpd -p 80 --path .\build\web\
```
