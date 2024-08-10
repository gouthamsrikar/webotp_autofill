import 'dart:html' as html;
import 'webotp_handler.dart';

class WebOtpAutofillHandler implements WebOtpHandler {
  @override
  void webAutofillOtpListener({required void Function(String otp) onOtp}) {
    html.window.addEventListener('web-otp-autofill', (event) {
      event as html.CustomEvent;
      if (event.detail['otp'] != null) {
        onOtp.call(event.detail['otp'].toString());
      }
    });
  }

  @override
  void removeWebAutofillOtpListener() {
    html.window.removeEventListener('web-otp-autofill', (_) {});
  }
}

WebOtpHandler getPlatformHandler() => WebOtpAutofillHandler();
