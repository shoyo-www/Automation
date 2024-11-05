import 'package:get/get.dart';
import 'package:hotelautomationapp/Presentation/aircon/aircon.dart';
import 'package:hotelautomationapp/Presentation/auth/login/login.dart';
import 'package:hotelautomationapp/Presentation/auth/otp/otp_screen.dart';
import 'package:hotelautomationapp/Presentation/cart/cart_screen.dart';
import 'package:hotelautomationapp/Presentation/chat/chat_screen.dart';
import 'package:hotelautomationapp/Presentation/dashboard/dashboard.dart';
import 'package:hotelautomationapp/Presentation/facilities/facility_item/facility_item.dart';
import 'package:hotelautomationapp/Presentation/food_order/food_detail_screen.dart';
import 'package:hotelautomationapp/Presentation/food_order/food_offer_screen.dart';
import 'package:hotelautomationapp/Presentation/food_order/food_order_screen.dart';
import 'package:hotelautomationapp/Presentation/getx/onboarding.dart';
import 'package:hotelautomationapp/Presentation/lights_control/light_control.dart';
import 'package:hotelautomationapp/Presentation/services/add_details/add_details.dart';
import 'package:hotelautomationapp/Presentation/services/pending_request.dart';
import 'package:hotelautomationapp/Presentation/services/review_request/review_request.dart';
import 'package:hotelautomationapp/Presentation/services/services.dart';
import 'package:hotelautomationapp/approutes.dart';

class AppPages {
  static const Duration duration = Duration(milliseconds: 800);
  static const Transition transition = Transition.cupertino;
  static var list = [
    GetPage(
        name: AppRoutes.onBoarding,
        page: ()=>const OnBoardingScreen(),
        transition: transition,
         transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.login,
        page: ()=>const Login(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.otpScreen,
        page: ()=>const OtpScreen(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.dashBoard,
        page: ()=> const DashBoard(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.lightControl,
        page: ()=>const LightControlScreen(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.airCon,
        page: ()=>const AirConScreen(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.facility,
        page: ()=>const FacilityItemScreen(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.foodOrder,
        page: ()=>const FoodOrderScreen(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.foodOrderDetail,
        page: ()=>const FoodDetailScreen(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.chatScreen,
        page: ()=>const ChatScreen(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.reviewRequest,
        page: ()=>const ReviewRequest(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.addDetail,
        page: ()=>const AddDetailsScreen(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.pendingRequest,
        page: ()=>const PendingRequestScreen(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.cart,
        page: ()=>const CartScreen(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.service,
        page: ()=>const ServicesScreen(),
        transition: transition,
        transitionDuration: duration
    ),
    GetPage(
        name: AppRoutes.foodOffer,
        page: ()=>const FoodOfferScreen(),
        transition: transition,
        transitionDuration: duration
    ),
  ];
}
