class Apis {
  static const baseUrl = 'https://dev-hotel-api.wattinventive.com';
  static const login = '$baseUrl/v1/customers/login';
  static const verifyOtp = '$baseUrl/customers/verify-otp';
  static const getRoomScene = '$baseUrl/v1/roomScene?hotelId=';
  static const quickCall = '$baseUrl/v1/quickCall?hotelId=';
  static const getLightSwitch = '$baseUrl/api/rooms/devices?hotelId=';
  static const updateDevice = '$baseUrl/api/device/exec';
  static const foodCategory = '$baseUrl/v1/foodCategory?hotelId=';
  static const getFoodSingleDetail =  "$baseUrl/v1/food?hotelId=";
  static const geService =  "$baseUrl/v1/hotelServices?hotelId=";
  static const getPendingRequestService =  "$baseUrl/v1/hotelServices/book?hotelId=";
  static const bookService =  "$baseUrl/v1/hotelServices/book";
  static const foodOrder =  "$baseUrl/v1/foodOrder";
  static const getFacilities =  "$baseUrl/v1/hotelFacility?hotelId=";
  static const getFacilitiesSingle =  "$baseUrl/v1/hotelFacilityType?hotelId=";
  static const bookFacility =  "$baseUrl/v1/hotelFacility/book";
  static const getCoupon =  "$baseUrl/v1/coupon?hotelId=";
}
