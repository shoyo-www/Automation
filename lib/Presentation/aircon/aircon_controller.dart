import 'dart:convert';

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
import 'package:hotelautomationapp/widgets/slider/slider.dart';

class AirConController extends GetxController {
 InteractiveSliderController sliderController = InteractiveSliderController(20);
 double airConValue = 20;
 int status = 0;
 bool buttonLoading = false;
 HomeRepositoryImpl homeRepositoryImpl = HomeRepositoryImpl();
 bool loading = false;
 OtpResponse? userData;
 Datum? acList;
 String? formated;

 @override
 void onInit() {
   getAc(Get.context!);
   super.onInit();
 }

 updateValue(double v) {
   airConValue = v;
   update();
 }

 setStatus(int s) {
   status = s;
   update();
 }

 setTemp(String type) {
   if(type == 'Auto') {
     airConValue = 24;
     sliderController.value = 24;
     update();
   } else if(type == 'Cooling') {
     airConValue = 18;
     sliderController.value = 18;
     update();
   } else if(type == 'Heating') {
     airConValue = 28;
     sliderController.value = 28;
     update();
   }
   update();
 }

 void updateAc(BuildContext context) async {
   buttonLoading = true;
   update();
   var req = UpdateDeviceRequest(color: 'red',action: 'turnOn',actionlog: 'turnOn',channelid: acList?.channelid ?? '',level: 'String',model: 'String',openPercent: 'String');
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
       update();
     }
   }, (r) async {
     if(r.msg == 'Execution Successful') {
       getAc(context);
       showAppSnack(context, r.msg ?? '', true);
     } else {
       showAppSnack(context, r.msg ?? '', false);
     }
     buttonLoading = false;
     update();
   }
   );
 }

 void getAc(BuildContext context) async {
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
       update();
     }
   }, (r) async {
     for(var i in r.data ?? []) {
       if(i.friendlyname == 'Ac') {
         acList = i;
       }
     }
     Map<String, dynamic> statusMap = json.decode(acList?.status ?? '');
     String status = statusMap.values.toString();
     formated =status.replaceAll('(', '').replaceAll(')', '');
     loading = false;
     update();
   }
   );
 }

}