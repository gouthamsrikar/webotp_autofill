import 'webotp_handler_locator.dart'
    if (dart.library.html) 'webotp_autofill_handler.dart';

abstract class WebOtpHandler {
  factory WebOtpHandler() => getPlatformHandler();

  void webAutofillOtpListener({required void Function(String otp) onOtp});

  void removeWebAutofillOtpListener();
}
