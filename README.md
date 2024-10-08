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
make gen
```

Build the web deployment *(outputs to `.\build\web`)*:

```
make build-web-stg
```

---

### Running a basic web server to host the web app

Install the `dhttpd` basic web server:

```
dart pub global activate dhttpd
```

Run a basic web server that will host the app:

```
dart pub global run dhttpd --host=localhost -p 8080 --path .\build\web\
```
