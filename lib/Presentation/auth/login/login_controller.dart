import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/Repository_impl/auth_repository_impl.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/login_request.dart';
import 'package:hotelautomationapp/widgets/app_snackbar.dart';

class LoginController extends GetxController {
  bool loading = false;
  TextEditingController phoneCont = TextEditingController();
  AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  login(BuildContext context) async {
      loading = true;
      update([ControllerBuilders.loginController]);
      var request = LoginRequest(phoneNumber: "+91${phoneCont.text.trim()}");
      var data = await authRepositoryImpl.login(request);
      data.fold((l) {
        if (l is ServerFailure) {
          showAppSnack(context, l.message ?? '', false);
          loading = false;
          update([ControllerBuilders.loginController]);
        }
      }, (r) {
        if (r.status == true) {
          loading = false;
          LocalStorage.writeString(GetXStorageConstants.authToken, r.data?.token ?? '');
          Get.toNamed(AppRoutes.otpScreen,arguments: {
            "otp" : r.data?.otp ?? ''
          });
          phoneCont.clear();
          update([ControllerBuilders.loginController]);
        }
        else {
          loading = false;
          update([ControllerBuilders.loginController]);

        }
      }
      );
      update([ControllerBuilders.loginController]);
    }

  }