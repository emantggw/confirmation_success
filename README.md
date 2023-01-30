<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

The Flutter library aim to provide an interactive and visually appealing way to indicate to users that their order/task has been confirmed. The library can be customized to fit the look and feel of your product or service. The library also provides users with the ability to change color, bubbles radius and size control.

## Screenshots

<img src="https://github.com/emantggw/confirmation_success/raw/main/assets/screenshots/confirm_succes_with_yellow.gif" />

<img src="https://github.com/emantggw/confirmation_success/raw/main/assets/screenshots/confirm_success_green.gif" />

## Features

Reacting after the task/order complete with customized message widgets.

## Getting started

## Usage

[Example](https://github.com/emantggw/confirmation_success/blob/master/example/example.dart)
To use this package :

- add the dependency to your [pubspec.yaml](https://github.com/emantggw/confirmation_success/blob/master/pubspec.yaml) file.

```yaml
dependencies:
  flutter:
    sdk: flutter
  confirmation_success:
```

### How to use

```dart
 ConfirmationSuccess(
  reactColor: Colors.green,
  child: Text("VOILA!",
    style: TextStyle(
      fontSize: 25,
      color: black,
      fontWeight: FontWeight.bold)))
}))
```

# License

Copyright (c) 2023 Amanuel Tito

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).

## Contact me

Get me on Telegram [@emantggw](https://t.me/emantggw)
