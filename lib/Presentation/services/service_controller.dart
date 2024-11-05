import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/core/error/exceptions.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/Repository_impl/service_repository.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/book_service_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_facility_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_pending_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/otp_response.dart';
import 'package:hotelautomationapp/widgets/app_snackbar.dart';

class ServiceController extends GetxController {
  RxBool isChanged = false.obs;
  int? selectedIndex;
  bool iSelected = false;
  bool loading = false;
  bool buttonLoading = false;
  ServiceRepositoryImpl serviceRepositoryImpl = ServiceRepositoryImpl();
  List<ServiceDatum> serviceList = [];
  List<SubCategoriesId>? subCat;
  List<ListElement> pendingList = [];
  bool isPending = true;
  List<int> status = [];
  List<AddRequest> addRequest = [];
  List<SubCategory> category = [];
  TextEditingController addDetailsCont = TextEditingController();

  @override
  void onInit() async {
    await getServices();
    await getPending();
    super.onInit();
  }

  onChanged(bool v) {
    isChanged.value = v;
  }

  getIndex(int i) {
    selectedIndex = i;
    update();
  }


  void addData(AddRequest req, SubCategory cat) {
    bool exists = addRequest.any((item) => item.id == req.id);

    if (exists) {
      showAppSnack(Get.context!, 'Already added', false);
    } else {
      addRequest.add(req);
      category.add(cat);
      update([ControllerBuilders.reviewController]);
    }
  }

  insertData(int i,AddRequest req,SubCategory sub) {
    addRequest.removeAt(i);
    addRequest.insert(i,req);
    category.removeAt(i);
    category.insert(i,sub);
    addDetailsCont.clear();
    update([ControllerBuilders.reviewController]);
  }

  removeData(int index) {
    addRequest.removeAt(index);
    category.removeAt(index);
    update([ControllerBuilders.reviewController]);
  }


  getServices() async {
    loading = true;
    OtpResponse? userData = LocalStorage.getData();
    var data = await serviceRepositoryImpl.getService(userData?.data?.user?.hotelId ?? '');
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
        update([ControllerBuilders.serviceController]);
      }
    }, (r) async {
      if (r.status == true) {
        serviceList.clear();
        for(var i in r.data?.serviceData ?? []) {
         if(i.subCategoriesIds.isNotEmpty) {
           serviceList.add(i);
         }
        }
        loading = false;
        update([ControllerBuilders.serviceController]);
      } else {
        loading = false;
      }
    });
    update([ControllerBuilders.serviceController]);
  }

  getPending() async {
    loading = true;
    OtpResponse? userData = LocalStorage.getData();
    var data = await serviceRepositoryImpl.getPendingRequest(userData?.data?.user?.hotelId ?? '');
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
        update([ControllerBuilders.serviceController]);
        update([ControllerBuilders.pendingRequest]);

      }
    }, (r) async {
      if (r.status == true) {
        pendingList.clear();
        pendingList.addAll(r.data?.list ?? []);
        for(var x in pendingList) {
          for(int i = 0; i<serviceList.length; i++) {
            var sub = serviceList[i].subCategoriesIds;
            for(int l = 0;l<(sub?.length ?? 0);l++) {
              if(x.subCategoryId == sub?[l].id) {
                sub?[l].isPending = x.status ?? 0;
              }
            }
          }
        }
        loading = false;
        update([ControllerBuilders.serviceController]);
        update([ControllerBuilders.pendingRequest]);
      } else {
        loading = false;
      }
    });
    update([ControllerBuilders.pendingRequest]);
    update([ControllerBuilders.serviceController]);
  }

  bookService(String hotelFacilityId, List<SubCategory> sub,ServiceController controller) async {
    buttonLoading = true;
    update([ControllerBuilders.reviewController]);
    OtpResponse? userData = LocalStorage.getData();
    var req = BookServiceRequest(hotelId: userData?.data?.hotelData?.id ?? '' ,hotelFacilityId: hotelFacilityId,subCategory: sub);
    var data = await serviceRepositoryImpl.bookService(req);
    data.fold((l) {
      if (l is ServerFailure) {
        if (l.type == ExceptionType.logout) {
          Get.offAllNamed(AppRoutes.login);
          LocalStorage.clearValueByKey(GetXStorageConstants.isLogin);
          showAppSnack(Get.context!, l.message ?? '', false);
          buttonLoading = false;
        } else {
          showAppSnack(Get.context!, l.message ?? '', false);
          buttonLoading = false;
        }
        update([ControllerBuilders.reviewController]);
      }
    }, (r) async {
      if (r.status == true) {
        await getPending();
        showAppSnack(Get.context!, r.message ?? '', true);
        Get.toNamed(AppRoutes.pendingRequest,arguments: {
          'controller' : controller
        });
        addRequest.clear();
        category.clear();
        buttonLoading = false;
        update([ControllerBuilders.reviewController]);
      } else {
        buttonLoading = false;
      }
    });
    update([ControllerBuilders.reviewController]);
  }

}


class AddRequest {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? description;
  final String ? details;

  AddRequest({ this.id ,this.title,  this.subtitle,  this.description,this.details});

}