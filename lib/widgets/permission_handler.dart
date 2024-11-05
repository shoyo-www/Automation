import 'dart:io';

import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

class Permissions {
  static PermissionHandlerPlatform get _handler => PermissionHandlerPlatform.instance;

  static Future<bool> bluetoothPermissionsGranted() async {
    if (!LocalStorage.getBool(GetXStorageConstants.blueTooth)) {
      Map<Permission, PermissionStatus> bluetoothPermissionStatus = await _handler.requestPermissions(
        [
          Permission.bluetooth,
          if (Platform.isIOS) Permission.bluetooth,
          if (Platform.isIOS) Permission.bluetoothConnect,
        ],
      );

      bool checkedTrue = false;
      bluetoothPermissionStatus.values.forEach((element) {
        if (element == PermissionStatus.granted) {
          checkedTrue = true;
        } else if (element == PermissionStatus.permanentlyDenied) {
          openAppSettings();
          checkedTrue = false;
        } else {
          checkedTrue = false;
        }
      });

      return checkedTrue;
    }

    return true;
  }

}