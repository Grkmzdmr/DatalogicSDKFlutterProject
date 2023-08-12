import 'package:flutter/services.dart';


abstract class DataLogicService {
  closeScanner();
  openScanner();
  closeAutoScanner();
  Future<String> getDeviceInfo();

}

class DataLogicServiceImpl extends DataLogicService {
  static const platform = MethodChannel('flutter.native/helper');
 

  @override
  closeScanner() async {
    await platform.invokeMethod("scannerOpenOff");
  }

  @override
  openScanner() {
    platform.invokeMethod("scannerOpen");
  }

  @override
  closeAutoScanner() {
    platform.invokeMethod("autoScannerClose");
  }

  @override
  Future<String> getDeviceInfo() async {
    try {
      String info = "";
      info = await platform.invokeMethod("getDeviceInfo");

      return info;
    } catch (e) {
      throw Exception();
    }
  }

}
