import 'package:flutter_screenutil/flutter_screenutil.dart';


class FontSize {
  static get sp_6 =>  6.0.sp;
  static get sp_7 =>  7.0.sp;
  static get sp_8 =>  8.0.sp;
  static get sp_9 =>  9.0.sp;
  static get sp_10 =>  10.0.sp;
  static get sp_11 =>  11.0.sp;
  static get sp_12 =>  12.0.sp;
  static get sp_13 => 13.0.sp;
  static get sp_14 =>  14.0.sp;
  static get sp_15 => 15.0.sp;
  static get sp_16 => 16.0.sp;
  static get sp_17 => 17.0.sp;
  static get sp_18 =>  18.0.sp;
  static get sp_20 =>  20.0.sp;
  static get sp_22 =>  22.0.sp;
  static get sp_24 =>  24.0.sp;
  static get sp_26 =>  26.0.sp;
  static get sp_30 =>  30.0.sp;
}

class Dimensions {
  static const deviceHeight = 690.0;
  static const halfDeviceHeight = 345.0;
  static double initHeight() {
    return ScreenUtil().screenHeight;
  }

  static double getHeight(double value) {
    final calculatedValue = (ScreenUtil().screenHeight / 690) * value;
    return calculatedValue;
  }

  static const defaultWidth = 360.0;
  static double getWidth(double value) {
    final calculatedValue = (ScreenUtil().screenWidth / 360) * value;
    return calculatedValue;
  }

  static double initWidth() {
    return ScreenUtil().screenWidth;
  }

  static double get screenWidth => initWidth();
  static final width = getWidth(defaultWidth);
  static final w_1 = getWidth(1.0);
  static final w_2 = getWidth(2.0);
  static final w_3 = getWidth(3.0);
  static final w_5 = getWidth(5.0);
  static final w_7 = getWidth(7.0);
  static final w_8 = getWidth(8.0);
  static final w_10 = getWidth(10.0);
  static final w_12 = getWidth(12.0);
  static final w_15 = getWidth(15.0);
  static final w_20 = getWidth(20.0);
  static final w_23 = getWidth(23.0);
  static final w_25 = getWidth(25.0);
  static final w_30 = getWidth(30.0);
  static final w_40 = getWidth(40.0);
  static final w_45 = getWidth(45.0);
  static final w_50 = getWidth(50.0);
  static final w_55 = getWidth(55.0);
  static final w_60 = getWidth(60.0);
  static final w_65 = getWidth(65.0);
  static final w_70 = getWidth(70.0);
  static final w_80 = getWidth(80.0);
  static final w_90 = getWidth(90.0);
  static final w_75 = getWidth(75.0);
  static final w_100 = getWidth(100.0);
  static final w_105 = getWidth(105.0);
  static final w_107 = getWidth(107.0);
  static final w_110 = getWidth(110.0);
  static final w_120 = getWidth(120.0);
  static final w_130 = getWidth(130.0);
  static final w_135 = getWidth(135.0);
  static final w_175 = getWidth(175.0);
  static final w_150 = getWidth(150.0);
  static final w_165 = getWidth(165.0);
  static final w_180 = getWidth(180.0);
  static final w_190 = getWidth(190.0);
  static final w_200 = getWidth(200.0);
  static final w_205 = getWidth(205.0);
  static final w_215 = getWidth(215.0);
  static final w_220 = getWidth(220.0);
  static final w_250 = getWidth(250.0);
  static final w_300 = getWidth(300.0);
  static final w_350 = getWidth(350.0);
  static final w_400 = getWidth(400.0);
  static final w_450 = getWidth(450.0);
  static final w_465 = getWidth(465.0);
  static final w_4 = getWidth(4.0);
  static final w_6 = getWidth(6.0);
  static final w_13 = getWidth(13.0);
  static final w_17 = getWidth(17.0);
  static final w_18 = getWidth(18.0);
  static final w_24 = getWidth(24.0);
  static final w_26 = getWidth(26.0);
  static final w_28 = getWidth(28.0);
  static final w_32 = getWidth(32.0);
  static final w_35 = getWidth(35.0);
  static final w_38 = getWidth(38.0);
  static final w_47 = getWidth(47.0);
  static final w_48 = getWidth(48.0);
  static final w_62 = getWidth(62.0);
  static final w_83 = getWidth(83.0);
  static final w_85 = getWidth(85.0);
  static final w_93 = getWidth(93.0);
  static final w_95 = getWidth(95.0);
  static final w_115 = getWidth(115.0);
  static final w_122 = getWidth(122.0);
  static final w_140 = getWidth(140.0);
  static final w_145 = getWidth(145.0);
  static final w_155 = getWidth(155.0);
  static final w_160 = getWidth(160.0);
  static final w_170 = getWidth(170.0);
  static final w_185 = getWidth(185.0);
  static final w_195 = getWidth(195.0);
  static final w_240 = getWidth(240.0);
  static final w_230 = getWidth(230.0);
  static final w_260 = getWidth(260.0);
  static final w_255 = getWidth(255.0);
  static final w_265 = getWidth(265.0);
  static final w_280 = getWidth(280.0);
  static final w_286 = getWidth(286.0);
  static final w_335 = getWidth(335.0);
  static final w_310 = getWidth(310.0);
  static final w_320 = getWidth(320.0);
  static final w_351 = getWidth(351.0);
  static final w_346 = getWidth(346.0);

  //height dimensions
  static double get screenHeight => initHeight();
  static final height = getHeight(deviceHeight);
  static final h_5 = getHeight(5.0);
  static final h_2 = getHeight(2.0);
  static final h_1 = getHeight(1.0);
  static final h_6 = getHeight(6.0);
  static final h_4 = getHeight(4.0);
  static final h_3 = getHeight(3.0);
  static final h_8 = getHeight(8.0);
  static final h_10 = getHeight(10.0);
  static final h_11 = getHeight(11.0);
  static final h_12 = getHeight(12.0);
  static final h_13 = getHeight(13.0);
  static final h_15 = getHeight(15.0);
  static final h_16 = getHeight(16.0);
  static final h_18 = getHeight(18.0);
  static final h_20 = getHeight(20.0);
  static final h_22 = getHeight(22.0);
  static final h_25 = getHeight(25.0);
  static final h_28 = getHeight(28.0);
  static final h_30 = getHeight(30.0);
  static final h_33 = getHeight(33.0);
  static final h_35 = getHeight(35.0);
  static final h_40 = getHeight(40.0);
  static final h_45 = getHeight(45.0);
  static final h_50 = getHeight(50.0);
  static final h_55 = getHeight(55.0);
  static final h_60 = getHeight(60.0);
  static final h_65 = getHeight(65.0);
  static final h_70 = getHeight(70.0);
  static final h_80 = getHeight(80.0);
  static final h_85 = getHeight(85.0);
  static final h_90 = getHeight(90.0);
  static final h_75 = getHeight(75.0);
  static final h_100 = getHeight(100.0);
  static final h_105 = getHeight(105.0);
  static final h_110 = getHeight(110.0);
  static final h_120 = getHeight(120.0);
  static final h_130 = getHeight(130.0);
  static final h_145 = getHeight(145.0);
  static final h_170 = getHeight(170.0);
  static final h_175 = getHeight(175.0);
  static final h_150 = getHeight(150.0);
  static final h_155 = getHeight(155.0);
  static final h_140 = getHeight(140.0);
  static final h_160 = getHeight(160.0);
  static final h_165 = getHeight(165.0);
  static final h_180 = getHeight(180.0);
  static final h_185 = getHeight(185.0);
  static final h_190 = getHeight(190.0);
  static final h_195 = getHeight(195.0);
  static final h_200 = getHeight(200.0);
  static final h_210 = getHeight(200.0);
  static final h_215 = getHeight(215.0);
  static final h_230 = getHeight(230.0);
  static final h_250 = getHeight(250.0);
  static final h_255 = getHeight(255.0);
  static final h_270 = getHeight(270.0);
  static final h_280 = getHeight(285.0);
  static final h_300 = getHeight(300.0);
  static final h_315 = getHeight(315.0);
  static final h_350 = getHeight(350.0);
  static final h_340 = getHeight(340.0);
  static final h_400 = getHeight(400.0);
  static final h_450 = getHeight(450.0);
  static final h_470 = getHeight(470.0);
  static final h_500 = getHeight(500.0);
  static final h_510 = getHeight(510.0);
}
