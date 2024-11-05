import 'package:adoptive_calendar/adoptive_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/core/error/exceptions.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/Repository_impl/facilities_repository_impl.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/book_facility_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_service_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_single_category.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/otp_response.dart';
import 'package:hotelautomationapp/widgets/app_snackbar.dart';
import 'package:intl/intl.dart';

class FacilitiesController extends GetxController {
  bool loading = false;
  bool buttonLoading = false;
  FacilitiesRepositoryImpl facilitiesRepositoryImpl = FacilitiesRepositoryImpl();
  List<FacilityDatum> facilitiesList = [];
  List<HotelFacilityTypesDatum> categoryList = [];
  int selectedIndex = 0;
  String? datePicked;
  DateTime? pickedDate;
  var isVisible = false.obs;
  RxBool isChanged = false.obs;
  RxString guests = 'No of Guests'.obs;
  bool isExpanded = false;

  @override
  void onInit() {
    getFacilities();
    super.onInit();
  }

  onChanged(bool v) {
    isChanged.value = v;
    update();
  }

  checkAvailability() {
    isVisible.value = true;
  }


  getGuests(int index) {
    guests.value = (index + 1).toString();
    isExpanded =!isExpanded;
    update();
  }

  getIndex(int i) {
    selectedIndex = i;
    update([ControllerBuilders.facilitiesController]);
  }

  getBack() {
   isVisible.value = false;
   guests.value = 'No of Guests';
   datePicked = '';
   update();
  }

  getFacilities() async {
    loading = true;
    OtpResponse? userData = LocalStorage.getData();
    var data = await facilitiesRepositoryImpl.getFacilities(userData?.data?.user?.hotelId ?? '');
    data.fold((l) {
      if (l is ServerFailure) {
        if (l.type == ExceptionType.logout) {
          Get.offAllNamed(AppRoutes.login);
          LocalStorage.clearValueByKey(GetXStorageConstants.isLogin);
          showAppSnack(Get.context!, l.message ?? '', false);
          loading = false;
        } else {
          showAppSnack(Get.context!, l.message ?? '', false);
          loading = false;
        }
        update([ControllerBuilders.facilitiesController]);

      }
    }, (r) async {
      if (r.status == true) {
        facilitiesList.clear();
        for(var i in r.data?.facilityData ?? []) {
          if(i.types?.isNotEmpty ?? false) {
            facilitiesList.add(i);
          }
        }
        categoryList.clear();
        await getFacilitiesSingle(facilitiesList[0].id ?? '');
        loading = false;
        update([ControllerBuilders.facilitiesController]);
      } else {
        loading = false;
      }
    });
    update([ControllerBuilders.facilitiesController]);
  }

  getFacilitiesSingle(String facilityId) async {
    loading = true;
    OtpResponse? userData = LocalStorage.getData();
    var data = await facilitiesRepositoryImpl.getSingleFacility(userData?.data?.user?.hotelId ?? '',facilityId);
    data.fold((l) {
      if (l is ServerFailure) {
        if (l.type == ExceptionType.logout) {
          Get.offAllNamed(AppRoutes.login);
          LocalStorage.clearValueByKey(GetXStorageConstants.isLogin);
          showAppSnack(Get.context!, l.message ?? '', false);
          loading = false;
        } else {
          showAppSnack(Get.context!, l.message ?? '', false);
          loading = false;
        }
        update([ControllerBuilders.facilitiesController]);

      }
    }, (r) async {
      if (r.status == true) {
        categoryList.clear();
        categoryList.addAll(r.data?.hotelFacilityTypesData ?? []);
        loading = false;
        update([ControllerBuilders.facilitiesController]);
      } else {
        loading = false;
      }
    });
    update([ControllerBuilders.facilitiesController]);
  }

  bookService(String serviceId,String facilityTypeId) async {
    buttonLoading = true;
    update();
    OtpResponse? userData = LocalStorage.getData();
    var req = BookFacilitiesRequest(hotelId: userData?.data?.hotelData?.id ?? '', facilityId: serviceId, bookingDate: pickedDate ?? DateTime.now(), numberOfGuests: guests.value == 'No of Guests' ? 0 : int.parse(guests.value), facilityTypeId: facilityTypeId);
    var data = await facilitiesRepositoryImpl.bookFacility(req);
    data.fold((l) {
      if (l is ServerFailure) {
        if (l.type == ExceptionType.logout) {
          Get.offAllNamed(AppRoutes.login);
          LocalStorage.clearValueByKey(GetXStorageConstants.isLogin);
          showAppSnack(Get.context!, l.message ?? '', false);
          buttonLoading = false;
          update();
        } else {
          showAppSnack(Get.context!, l.message ?? '', false);
          buttonLoading = false;
          update();
        }

      }
    }, (r) async {
      if (r.status == true) {
        showAppSnack(Get.context!, r.message ?? '', true);
        guests.value = 'No of Guests';
        datePicked = '';
        isVisible.value = false;
        buttonLoading = false;
        Get.toNamed(AppRoutes.dashBoard,arguments: {
          'index' : 2
        });
        update();
      } else {
        buttonLoading = false;
        update();
      }
    });
  }

  showDateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AdoptiveCalendar(
          initialDate: DateTime.now(),
          use24hFormat: true,
          backgroundColor: AppColor.darkCardColor,
          selectedColor: AppColor.appColor,
          iconColor: AppColor.appColor,
          barColor: AppColor.darkScaffold,
          fontColor: AppColor.white,
          onSelection: (e) {
            pickedDate = e;
            print('=================$pickedDate');
            datePicked = DateFormat('dd MMMM yyyy, HH:mm').format(pickedDate ?? DateTime.now());
            update();
          },
        );
      },
    );
  }

}