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

# WEBOTP_AUTOFILL

The WebOTP API provides a streamlined user experience for web apps to verify that a phone number belongs to a user when using it as a sign-in factor. WebOTP is an extension of the [Credential Management API](https://developer.mozilla.org/en-US/docs/Web/API/Credential_Management_API).

## 📖 Steps to integrate webotp_autofill

1. Install **webotp_autofill** Dependency

```
flutter pub add webotp_autofill
```

2. create a file `webotp_autofill.js` in your `web/` directory and paste the below code

```js
if ('OTPCredential' in window) {
    window.addEventListener('DOMContentLoaded', e => {
        navigator.credentials.get({
            otp: { transport: ['sms'] },
        }).then(otp => {

            const webOtpAutofillEvent = new CustomEvent('web-otp-autofill', {
                detail: {
                    otp: otp.code
                }
            });

            window.dispatchEvent(webOtpAutofillEvent);

        }).catch(err => {
            console.log(err);
        });
    });
}
```

2. Initialize Webotp api in index.html

```html
<!-- Add this script to initiate webotp -->
<script src="webotp_autofill.js" ></script>
```

3. Configure

- Import the following classes.

```dart
import 'package:webotp_autofill/webotp_autofill.dart';
```

- Add this code to your Statefull widget

```dart
  final TextEditingController _otpTextController = TextEditingController();

  @override
  void initState() {
    WebOtpHandler().webAutofillOtpListener(onOtp: _onOtp);
    super.initState();
  }

  _onOtp(String otp) {
    _otpTextController.text = otp;
  }

  @override
  void dispose() {
    WebOtpHandler().removeWebAutofillOtpListener();
    super.dispose();
  }
```

## SMS message format

A typical SMS message looks like so:

```sms
Your verification code is 123456.

@top-level.example.com #123456
```

- The first line and second blank line are optional and are for human readability.
- The last line is mandatory. It must be the last line if there are others present, and must consist of:
  - The domain part of the URL of the website that invoked the API, preceded by a @.
  - Followed by a space.
  - Followed by the OTP, preceded by a pound sign (#).

## NOTE: if you are using flutter web page in iframe and need to autofill the otp and also SMS format will be 

```html
<iframe src="https://embedded.com/..." allow="otp-credentials"> ... </iframe>
```

Sms Message looks like:

```sms
Your verification code is 123456.

@top-level.example.com #123456 @embedded.com
```

## To get better understanding about webotp API refer the docs of [WebOtp API](https://developer.mozilla.org/en-US/docs/Web/API/WebOTP_API)
