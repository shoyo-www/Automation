import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/core/error/exceptions.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/Repository_impl/home_repository_impl.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/otp_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/quick_calls.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/room_scence_response.dart';
import 'package:hotelautomationapp/widgets/app_snackbar.dart';
import 'package:hotelautomationapp/widgets/permission_handler.dart';

class HomeController extends GetxController {
  HomeRepositoryImpl homeRepositoryImpl = HomeRepositoryImpl();
  List<RoomScene> roomScene = [];
  List<QuickCalls> quickCalls = [];
  OtpResponse? userData;
  bool isLoading = false;
  bool masterValue = false;
  bool airConValue = false;

  @override
  void onInit() {
    getRoomScene(Get.context!);
    getQuickCalls(Get.context!);
    // checkLocation();
    super.onInit();
  }

  checkLocation()async {
    LocalStorage.writeBool(GetXStorageConstants.blueTooth, await Permissions.bluetoothPermissionsGranted());
  }

  toggleValue(bool value) {
    masterValue = value;
    update([ControllerBuilders.homeController]);
  }
  toggleValueAirCon(bool value) {
    airConValue = value;
    update([ControllerBuilders.homeController]);
  }

  getRoomScene(BuildContext context) async {
    isLoading = true;
    userData = LocalStorage.getData();
    var data = await homeRepositoryImpl.getRoomScene(userData?.data?.user?.hotelId ?? '');
    data.fold((l) {
      if (l is ServerFailure) {
        if (l.type == ExceptionType.logout) {
          Get.offAllNamed(AppRoutes.login);
          LocalStorage.clearValueByKey(GetXStorageConstants.isLogin);
          showAppSnack(context, l.message ?? '', false);
          isLoading = false;
        } else {
          showAppSnack(context, l.message ?? '', false);
          isLoading = false;
        }
        update([ControllerBuilders.homeController]);
      }
    }, (r) async {
      if (r.status == true) {
        roomScene.addAll(r.data ?? []);
        isLoading = false;
        update([ControllerBuilders.homeController]);
      }
      else {
        isLoading = false;
      }
    }
    );
  }


  getQuickCalls(BuildContext context) async {
    isLoading = true;
    var data = await homeRepositoryImpl.quickCalls(userData?.data?.user?.hotelId ?? '');
    data.fold((l) {
      if (l is ServerFailure) {
        if (l.type == ExceptionType.logout) {
          showAppSnack(context, l.message ?? '', false);
          isLoading = false;
          LocalStorage.clearValueByKey(GetXStorageConstants.isLogin);
          Get.offAllNamed(AppRoutes.login);
        } else {
          showAppSnack(context, l.message ?? '', false);
          isLoading = false;
        }
        update([ControllerBuilders.homeController]);
      }
    }, (r) async {
      if (r.status == true) {
        quickCalls.addAll(r.data ?? []);
        isLoading = false;
        update([ControllerBuilders.homeController]);
      }
      else {}
    }
    );
  }
}