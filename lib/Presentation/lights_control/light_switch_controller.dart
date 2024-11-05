import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/core/error/exceptions.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/Repository_impl/home_repository_impl.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/update_device_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/lights_switch_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/otp_response.dart';
import 'package:hotelautomationapp/widgets/app_snackbar.dart';

class LightSwitchController extends GetxController {
  bool loading = false;
  bool buttonLoading = false;
  OtpResponse? userData;
  HomeRepositoryImpl homeRepositoryImpl = HomeRepositoryImpl();
  List<Datum> lightSwitch = [];

  @override
  void onInit() {
    getLight(Get.context!);
    super.onInit();
  }

  updateLight(BuildContext context,String channelId) async {
    buttonLoading = true;
    update([ControllerBuilders.lightController]);
    var req = UpdateDeviceRequest(color: 'red',action: 'turnOn',actionlog: 'turnOn',channelid: channelId,level: 'String',model: 'String',openPercent: 'String');
    var data = await homeRepositoryImpl.updateDevices(req);
    data.fold((l) {
      if (l is ServerFailure) {
        if (l.type == ExceptionType.logout) {
          buttonLoading = false;
          Get.offAllNamed(AppRoutes.login);
          LocalStorage.clearValueByKey(GetXStorageConstants.isLogin);
          showAppSnack(context, l.message ?? '', false);
        } else {
          buttonLoading = false;
          showAppSnack(context, l.message ?? '', false);
        }
        update([ControllerBuilders.lightController]);
      }
    }, (r) async {
      if(r.msg == 'Execution Successful') {
        getLight(context);
        showAppSnack(context, r.msg ?? '', true);
      } else {
        showAppSnack(context, r.msg ?? '', false);
      }
      buttonLoading = false;
      update([ControllerBuilders.lightController]);
    }
    );
  }

  getLight(BuildContext context) async {
    loading = true;
    userData = LocalStorage.getData();
    var data = await homeRepositoryImpl.getLightSwitch(userData?.data?.hotelData?.id ?? '');
    data.fold((l) {
      if (l is ServerFailure) {
        if (l.type == ExceptionType.logout) {
          loading = false;
          Get.offAllNamed(AppRoutes.login);
          LocalStorage.clearValueByKey(GetXStorageConstants.isLogin);
          showAppSnack(context, l.message ?? '', false);
        } else {
          loading = false;
          showAppSnack(context, l.message ?? '', false);
        }
        update([ControllerBuilders.lightController]);
      }
    }, (r) async {
      lightSwitch.addAll(r.data ?? []);
      loading = false;
      update([ControllerBuilders.lightController]);
    }
    );
  }
}