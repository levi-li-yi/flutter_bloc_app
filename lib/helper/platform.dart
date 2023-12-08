/*
 * @Author: Levi Li
 * @Date: 2023-12-08 17:00:31
 * @description: 
 */
import 'dart:io';
import 'package:flutter/foundation.dart';

class PlatFormTool {
  static bool isIOS() {
    try {
      return Platform.isIOS;
    } catch (e) {
      return false;
    }
  }

  static bool isAndroid() {
    try {
      return Platform.isAndroid;
    } catch (e) {
      return false;
    }
  }

  static bool isWeb() {
    return kIsWeb;
  }

  static bool isMacOS() {
    try {
      return Platform.isMacOS;
    } catch (e) {
      return false;
    }
  }

  static bool isWindows() {
    try {
      return Platform.isWindows;
    } catch (e) {
      return false;
    }
  }

  static String operatingSystem() {
    try {
      return Platform.operatingSystem;
    } catch (e) {
      return "";
    }
  }

  static String operatingSystemVersion() {
    try {
      return Platform.operatingSystemVersion;
    } catch (e) {
      return "unknown";
    }
  }

  static String localeName() {
    try {
      return Platform.localeName;
    } catch (e) {
      return "zh_Hans_CN";
    }
  }
}
