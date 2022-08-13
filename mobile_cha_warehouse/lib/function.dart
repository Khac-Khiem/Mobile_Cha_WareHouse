import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_cha_warehouse/global.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();

  ///Logical pixel của chiều ngang điện thoại đang chạy ứng dụng
  static double screenWidth = 0;

  ///Logical pixel của chiều dọc điện thoại đang chạy ứng dụng
  static double screenHeight = 0;
  //Sample là Google Pixel 3, các điện thoại khác thì phải debug để xem lại Logical Pixel của nó.

  ///Logical pixel của chiều ngang điện thoại tham chiếu Google Pixel 3
  static double screenWidthSample = 392.727272727272727272;

  ///Logical pixel của chiều dọc điện thoại tham chiếu Google Pixel 3
  static double screenHeightSample = 737.45454545454545454;

  ///Tỉ lệ chiều ngang của điện thoại chạy ứng dụng/điện thoại tham chiếu Pixel 3
  static double ratioWidth =0;

  ///Tỉ lệ chiều dọc của điện thoại chạy ứng dụng/điện thoại tham chiếu Pixel 3
  static double ratioHeight=0;

  static double ratioFont = 0;
  static double ratioRadius = 0;

  ///Hàm chạy để khởi tạo các giá trị tỉ lệ, dùng trong trang đầu tiên của ứng dụng
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    ratioWidth = screenWidth / screenWidthSample;
    ratioHeight = screenHeight / screenHeightSample;
    ratioFont = min(ratioWidth, ratioHeight);
    ratioRadius = ratioFont;
  }
}

// String stringCut(String source, int finalLength, {String suffix}) {
//   String result;
//   if (source.length > finalLength) {
//     result = source.substring(0, finalLength) + suffix ?? "";
//   } else {
//     result = source;
//   }
//   return result;
// }
void logout(BuildContext context) {
  employeeIdOverall = ""; //clear tên khi đăng xuất
  token = ""; //clear token khi đăng xuất
  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
}