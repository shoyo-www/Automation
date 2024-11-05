
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/core/error/exceptions.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/Repository_impl/auth_repository_impl.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/otp_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/otp_response.dart';
import 'package:hotelautomationapp/widgets/app_snackbar.dart';
import 'package:hotelautomationapp/widgets/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';

class OtpController extends GetxController {
  bool loading = false;
  TextEditingController otpController = TextEditingController();
  AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();

  @override
  onInit() {
    otpController.text = Get.arguments['otp'];
    super.onInit();
  }

  saveData(String token,OtpResponse data) {
    LocalStorage.writeString(GetXStorageConstants.authToken, token);
    LocalStorage.writeBool(GetXStorageConstants.isLogin, true);
    LocalStorage.writeString(GetXStorageConstants.userName, data.data?.user?.name ?? '');
    LocalStorage.writeString(GetXStorageConstants.userRoomNo, data.data?.bookRoomData?[0].roomData?.roomNumber.toString() ?? '');
    LocalStorage.writeString(GetXStorageConstants.category, data.data?.bookRoomData?[0].roomData?.category.toString() ?? '');
    LocalStorage.storeData(data);
  }

  verifyOtp(BuildContext context) async {
    loading = true;
    update([ControllerBuilders.otpController]);
    var request = OtpRequest(otp: otpController.text.trim());
    var data = await authRepositoryImpl.verifyOtp(request);
    data.fold((l) {
      if (l is ServerFailure) {
          if (l.type == ExceptionType.logout) {
            showAppSnack(context, l.message ?? '', false);
          } else {
            showAppSnack(context, l.message ?? '', false);

          }
        loading = false;
        update([ControllerBuilders.otpController]);
      }
    }, (r) async {
      if (r.status == true) {
        loading = false;
        await saveData(r.data?.token ?? '',r);
        Get.toNamed(AppRoutes.dashBoard,arguments: {
          "index" : 0
        });
        otpController.clear();
        update([ControllerBuilders.otpController]);
      }
      else {
        loading = false;
        update([ControllerBuilders.otpController]);

      }
    }
    );
    update([ControllerBuilders.otpController]);
  }

}