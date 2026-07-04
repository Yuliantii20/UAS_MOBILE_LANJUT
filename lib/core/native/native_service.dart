// Native Android MethodChannel
import 'package:flutter/services.dart';

class NativeService {
  static const MethodChannel _channel =
      MethodChannel("diginews/native");

  static Future<String> reverseNim(String nim) async {
    final String result = await _channel.invokeMethod(
      "reverseNim",
      {
        "nim": nim,
      },
    );

    return result;
  }
}