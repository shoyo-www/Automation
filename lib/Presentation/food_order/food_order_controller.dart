import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/approutes.dart';
import 'package:hotelautomationapp/constants/constants.dart';
import 'package:hotelautomationapp/core/error/exceptions.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/Repository_impl/food_repository_impl.dart';
import 'package:hotelautomationapp/data/datasource/local/local_storage.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/food_order_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/food_offer_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/food_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_single_food.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/otp_response.dart';
import 'package:hotelautomationapp/widgets/app_snackbar.dart';

class FoodOrderController extends GetxController {
  int selectedIndex= 0;
  int categoriesIndex= 0;
  bool added = false;
  int quantity = 0;
  bool loading = false;
  bool buttonLoading = false;
  List<Food> food = [];
  FoodDatum? foodData;
  List<AddOnDetail> addDetail= [];
  bool isEmpty = false;
  List<FoodsInCategory> filterList = [];
  FoodRepositoryImpl foodRepositoryImpl = FoodRepositoryImpl();
  TextEditingController couponCont = TextEditingController();
  List<FoodItem> foodItems = [];
  List<CouponDatum> foodOfferItems = [];
  int totalPrice = 0;

  @override
  void onInit() {
    getData();
    getFoodOffer();
    super.onInit();
  }

  getIndex(int i,{int? category}) {
    selectedIndex = i;
    categoriesIndex = category ?? 0;
    update([ControllerBuilders.foodController]);
  }

  singleQuantity() {
    quantity ++;
    update([ControllerBuilders.singleFoodController]);
  }
  singleQuantityDecrease() {
    if(quantity == 1) {
      return;
    } else {
      quantity--;
    }
    update([ControllerBuilders.singleFoodController]);
  }

  getData() async {
    loading = true;
    OtpResponse? userData = LocalStorage.getData();
    var data = await foodRepositoryImpl.getFood(userData?.data?.user?.hotelId ?? '');
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
        update([ControllerBuilders.foodController]);
      }
    }, (r) async {
      if (r.status == true) {
        food.clear();
        for(var i in r.data?.data ?? []) {
          if(i.foodsInCategories?.isNotEmpty ?? false) {
            food.add(i);
          }
        }
        filterList.clear();
        if (food.isNotEmpty) {
          var item = food[0];
          if (item.foodsInCategories != null && item.foodsInCategory != null) {
            for (var category in item.foodsInCategories!) {
              if (item.foodsInCategory!.contains(category.name)) {
                filterList.add(category);
              }
            }
          }
        }
        loading = false;
        update([ControllerBuilders.foodController]);
      } else {
        loading = false;
      }
    });

    update([ControllerBuilders.foodController]);
  }

  getFoodDDetail(String foodId) async {
    loading = true;
    OtpResponse? userData = LocalStorage.getData();
    var data = await foodRepositoryImpl.getSingleFoodDetail(userData?.data?.user?.hotelId ?? '',foodId);
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
        update([ControllerBuilders.singleFoodController]);
      }
    }, (r) async {
      if (r.status == true) {
        for(int i =0; i<(r.data?.foodData?.length ?? 0); i++) {
          foodData = r.data?.foodData?[i];

        }
        log('[]]]]]]]]]]]]]]]]]]]]]]]]]]]===========>${foodData?.imageUrl}');
        loading = false;
        update([ControllerBuilders.singleFoodController]);
      } else {
        loading = false;
      }
    });

    update([ControllerBuilders.singleFoodController]);
  }

  void getFoodOffer() async {
    loading = true;
    OtpResponse? userData = LocalStorage.getData();
    var data = await foodRepositoryImpl.foodOffer(userData?.data?.user?.hotelId ?? '');
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
        update([ControllerBuilders.foodController]);
      }
    }, (r) async {
      if (r.status == true) {
        foodOfferItems.clear();
        foodOfferItems.addAll(r.data?.couponData ?? []);
        loading = false;
        update([ControllerBuilders.foodController]);
      } else {
        loading = false;
      }
    });

    update([ControllerBuilders.foodController]);
  }

  double getPercentage(int amount,int discount) {
    double disAmount = amount * (discount / 100);
    double finalPrice = amount - disAmount;
    return finalPrice;
  }

  void filter(String name) async {
    loading = true;
    update([ControllerBuilders.foodController]);
    await Future.delayed(const Duration(seconds: 1));
    filterList.clear();
    for (var category in food) {
      if (category.name == name) {
        if (category.foodsInCategories != null && category.foodsInCategories!.isNotEmpty) {
          for (var foodItem in category.foodsInCategories!) {
            filterList.add(foodItem);
          }
        }
      }
    }
    update();
    log("${filterList}===========================oinmiownervoinwr9oiuvnewr");
    loading = false;
    update([ControllerBuilders.foodController]);
  }

  void foodOrder() async {
    buttonLoading = true;
    update([ControllerBuilders.cartScreen]);
    OtpResponse? userData = LocalStorage.getData();
    var req = couponCont.text.isNotEmpty ? FoodOrderRequest(
        hotelId: userData?.data?.hotelData?.id ?? '',
        foodItems: foodItems,
        coupon: couponCont.text.trim(),
        deliveryAddress: LocalStorage.getString(GetXStorageConstants.userRoomNo)) : FoodOrderRequest(
        hotelId: userData?.data?.hotelData?.id ?? '',
        foodItems: foodItems,
        deliveryAddress: LocalStorage.getString(GetXStorageConstants.userRoomNo));
    var data = await foodRepositoryImpl.foodOrder(req);
    data.fold((l) {
      if (l is ServerFailure) {
        if (l.type == ExceptionType.logout) {
          Get.offAllNamed(AppRoutes.login);
          LocalStorage.clearValueByKey(GetXStorageConstants.isLogin);
          showAppSnack(Get.context!, l.message ?? '', false);
          buttonLoading = false;
          update([ControllerBuilders.cartScreen]);
        } else {
          showAppSnack(Get.context!, l.message ?? '', false);
          buttonLoading = false;
          update([ControllerBuilders.cartScreen]);
        }

      }
    }, (r) async {
      if (r.status == true) {
        showAppSnack(Get.context!, r.message ?? '', true);
        buttonLoading = false;
        Get.offNamed(AppRoutes.foodOrder);
        foodItems.clear();
        quantity = 0;
        added = false;
        for(var i in filterList) {
          i.quantity = 0;
        }
        update([ControllerBuilders.cartScreen]);
      } else {
        buttonLoading = false;
        update([ControllerBuilders.cartScreen]);
      }
    });

    update([ControllerBuilders.singleFoodController]);
  }


  void incrementCounter(FoodsInCategory filterListData, int i) {
    filterListData.quantity = (filterListData.quantity ?? 0) + 1;
    quantity++;
    bool itemExists = false;
    for (var cartItem in foodItems) {
      if (cartItem.foodId == filterListData.id) {
        (cartItem.quantity ?? 0) + 1;
        itemExists = true;
        break;
      }
    }

    if (!itemExists) {
      addDataInCart(FoodItem(
        type: filterListData.type ?? 0,
        image: filterListData.imageUrl,
        foodId: filterListData.id,
        price: filterListData.price ?? 0,
        quantity: filterListData.quantity,
        name: filterListData.name,
      ));
    }
    added = true;
    getTotalPrice();
    update([ControllerBuilders.foodController]);
  }

  void decrementCounter(FoodsInCategory filterListData, int index) {
    filterListData.quantity = (filterListData.quantity) - 1;
    quantity--;
    if(filterListData.quantity> 0) {
      totalPrice =(filterListData.price ?? 0) * (filterListData.quantity);
    }
    if (filterListData.quantity < 0) {
      filterListData.quantity = 0;
    }
    removeDataInCart();

    if (quantity == 0) {
      added = false;
    }
    getTotalPrice();
    update([ControllerBuilders.foodController]);
  }

  String getTotalPrice() {
    String total = '0.0';
    double price = 0.0;
    for(var i in foodItems) {
      print("===========================++++++++${i.quantity}");
      price = (i.price?.toDouble() ?? 0) * (i.quantity?.toDouble() ?? 0);
    }
    total = price.toStringAsFixed(0);
    return total;
  }

  void addDataInCart(FoodItem food) {
    foodItems.add(food);
    update();
  }

  void removeDataInCart() {
    foodItems.isNotEmpty ? foodItems.removeLast() : null;
    update();
  }
}



