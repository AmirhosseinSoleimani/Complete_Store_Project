import 'dart:io';
import 'package:flutter/services.dart';

import '../domain/model/model.dart';
import 'package:device_info_plus/device_info_plus.dart';


Future<DeviceInfo> getDeviceDetails() async{
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try{
    if(Platform.isAndroid){
      // return android device info
    }else if (Platform.isIOS){
      // return ios device info
    }
  } on PlatformException{
    // return default data here
    return DeviceInfo(name, identifier, version);
  }
  return DeviceInfo(name, identifier, version);
}