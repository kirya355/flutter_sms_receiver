import 'dart:async';
import 'package:flutter/services.dart';

class SmsReceiver {
  static const MethodChannel _channel = const MethodChannel('com.oval.smsreceiver');

  Function(String) onSmsReceived;
  Function? onTimeout;
  Function? onFailureListener;

  SmsReceiver(this.onSmsReceived, {this.onTimeout, this.onFailureListener}) {
    _channel.setMethodCallHandler(_handleMethod);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "onSmsReceived":
        if (call.arguments is String) onSmsReceived(call.arguments);
        break;

      case "onTimeout":
        if (onTimeout != null) {
          onTimeout!();
        }
        break;

      case "onFailureListener":
        if (onFailureListener != null) {
          onFailureListener!();
        }
        break;
    }
  }

  Future<bool> startListening() async {
    bool result = await _channel.invokeMethod('startListening');
    return result;
  }
}
