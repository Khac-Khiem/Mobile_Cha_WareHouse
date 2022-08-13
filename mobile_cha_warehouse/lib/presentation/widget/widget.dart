import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/datasource/service/login_service.dart';
import 'package:mobile_cha_warehouse/global.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';

import '../../constant.dart';
import '../../function.dart';

class CustomizedButton extends StatelessWidget {
  String text;
  double width, height, radius, fontSize;
  Color bgColor;
  Color fgColor;
  VoidCallback onPressed;
  CustomizedButton(
      {this.text = "Tên nút",
      this.width = 250,
      this.height = 60,
      this.radius = 60,
      this.bgColor = Constants.mainColor,
      this.fgColor = Colors.white,
      this.fontSize = 27,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: width * SizeConfig.ratioWidth,
        height: height * SizeConfig.ratioHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(radius * SizeConfig.ratioWidth),
            ),
            primary: bgColor,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),
          // disabledColor: Colors.grey,
          // color: bgColor,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(radius * SizeConfig.ratioWidth),
          // ),
          child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize * SizeConfig.ratioFont, color: fgColor),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class CircularLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 60 * SizeConfig.ratioWidth,
              height: 60 *
                  SizeConfig.ratioWidth, //chỗ này là width để nó ra hình vuông
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Constants.mainColor),
                strokeWidth: 6.0,
              )),
          SizedBox(
            height: 30 * SizeConfig.ratioHeight,
          ),
          Text(
            "Đang tải dữ liệu",
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ],
      ),
    );
  }
}

class DrawerUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.mainColor,
      width: 240 * SizeConfig.ratioWidth,
      child: Drawer(
        child: Container(
          color: Constants.secondaryColor,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  color: Constants.secondaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 320 * SizeConfig.ratioHeight,
                          ),
                          Builder(builder: (context) {
                            // test drawer , chuyển sang !=
                            if (token == "") {
                              return Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        AlertDialogTwoBtnCustomized(
                                                context,
                                                'Bạn có chắc?',
                                                "Trở về trang chính",
                                                "Đồng ý",
                                                "Hủy bỏ", () {
                                          Navigator.pushNamed(
                                            context,
                                            '///',
                                          );
                                        }, () {}, 18, 21)
                                            .show();
                                      },
                                      child: IconTextButtonDrawer(
                                        icon: Icons.home,
                                        text: "Trang chính",
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        AlertDialogTwoBtnCustomized(
                                                context,
                                                'Bạn có chắc?',
                                                "Chuyển sang trang xuất kho",
                                                "Đồng ý",
                                                "Hủy bỏ", () async {
                                          Navigator.pushNamed(
                                              context, '/issue_screen');
                                        }, () {}, 18, 21)
                                            .show();
                                      },
                                      child: IconTextButtonDrawer(
                                          icon: Icons.shopping_cart,
                                          text: "Xuất kho")),
                                  TextButton(
                                      onPressed: () {
                                        AlertDialogTwoBtnCustomized(
                                                context,
                                                'Bạn có chắc?',
                                                "Chuyển sang trang nhập kho",
                                                "Đồng ý",
                                                "Hủy bỏ", () async {
                                          Navigator.pushNamed(
                                              context, '/receipt_screen');
                                        }, () {}, 18, 21)
                                            .show();
                                      },
                                      child: IconTextButtonDrawer(
                                          icon: Icons.shopping_cart,
                                          text: "Nhập kho")),
                                  TextButton(
                                      onPressed: () {
                                        AlertDialogTwoBtnCustomized(
                                                context,
                                                'Bạn có chắc?',
                                                "Chuyển sang trang thẻ kho",
                                                "Đồng ý",
                                                "Hủy bỏ", () {
                                          Navigator.pushNamed(
                                              context, '/stockcard_screen');
                                        }, () {}, 18, 21)
                                            .show();
                                      },
                                      child: IconTextButtonDrawer(
                                        icon: Icons.article,
                                        text: "Thẻ kho",
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        // AlertDialogTwoBtnCustomized(
                                        //     context: context,
                                        //     title: "Bạn có chắc?",
                                        //     desc: "Đăng xuất khỏi hệ thống.",
                                        //     bgBtn1: Colors.white,
                                        //     fgBtn1: Constants.mainColor,
                                        //     textBtn1: "Đăng xuất",
                                        //     textBtn2: "Trở lại",
                                        //     onPressedBtn1: () {
                                        //       logout(context);
                                        //     }).show();
                                        AlertDialogTwoBtnCustomized(
                                                context,
                                                'Bạn có chắc?',
                                                "Đăng xuất khỏi hệ thống",
                                                "Đăng xuất",
                                                "Trở lại", () {
                                          logout(context);
                                        }, () {}, 18, 21)
                                            .show();
                                      },
                                      child: IconTextButtonDrawer(
                                        icon: Icons.logout,
                                        text: 'Logout',
                                      )),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/settings_screen');
                                    },
                                    child: IconTextButtonDrawer(
                                        icon: Icons.settings, text: "Cài đặt"),
                                  ),
                                  SizedBox(
                                    height: 30 * SizeConfig.ratioHeight,
                                  ),
                                ],
                              );
                            }
                          })
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30)),
                    color: Constants.mainColor),
                height: 300 * SizeConfig.ratioHeight,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 60 * SizeConfig.ratioHeight,
                    ),
                    Icon(
                      Icons.account_circle,
                      size: 100 * SizeConfig.ratioWidth,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 40 * SizeConfig.ratioHeight,
                    ),
                    Text(
                      "Employee id:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.5 * SizeConfig.ratioHeight,
                          fontSize: 20 * SizeConfig.ratioFont,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      //  stringCut(employeeIdOverall, 16, suffix: "..."),
                      employeeIdOverall,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.5 * SizeConfig.ratioHeight,
                          fontSize: 20 * SizeConfig.ratioFont,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconTextButtonDrawer extends StatelessWidget {
  IconData icon;
  String text;
  IconTextButtonDrawer({this.icon = Icons.logout, this.text = "Đăng xuất"});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160 * SizeConfig.ratioWidth,
      height: 55 * SizeConfig.ratioHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 30 * SizeConfig.ratioRadius,
            color: Colors.white,
          ),
          SizedBox(width: 20 * SizeConfig.ratioWidth),
          FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: 110 * SizeConfig.ratioWidth,
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white, fontSize: 20 * SizeConfig.ratioFont),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ColumnHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: SizedBox(
          width: 380 * SizeConfig.ratioWidth,
          height: 60 * SizeConfig.ratioHeight,
          // ignore: deprecated_member_use
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 150 * SizeConfig.ratioWidth,
                  child: Text(
                    "Mã SP",
                    style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                width: 60 * SizeConfig.ratioWidth,
                child: Text(
                  "KL",
                  style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 150 * SizeConfig.ratioWidth,
                child: Text(
                  "Ghi chú",
                  style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
    );
  }
}

class CustomizeDatePicker extends StatefulWidget {
  Function okBtnClickedFunction;
  FontWeight fontWeight;
  Color fontColor;
  DateTime initDateTime;
  CustomizeDatePicker(
      {required this.okBtnClickedFunction,
      required this.fontColor,
      required this.fontWeight,
      required this.initDateTime});
  @override
  _CustomizeDatePickerState createState() => _CustomizeDatePickerState();
}

class _CustomizeDatePickerState extends State<CustomizeDatePicker> {
  @override
  Widget build(BuildContext context) {
    Future<Null> selectTimePicker(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: widget.initDateTime,
          firstDate: DateTime(1940),
          lastDate: DateTime(2030),
          builder: (context, Widget? child) {
            return Theme(
              data: ThemeData(
                  primarySwatch: Constants.materialMainColor,
                  primaryColor: const Color(0xFFC41A3B),
                  accentColor: const Color(0xFFC41A3B)),
              child: child!,
            );
          });
      if (picked != null && picked != widget.initDateTime) {
        setState(() {
          widget.initDateTime = picked;
          print(widget.initDateTime.toString());
        });
      }
      if (widget.okBtnClickedFunction != null) {
        widget.okBtnClickedFunction(widget.initDateTime);
      }
    }

    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(DateFormat('dd/MM/yyyy').format(widget.initDateTime),
              style: TextStyle(
                  fontSize: 18 * SizeConfig.ratioFont,
                  color: widget.fontColor,
                  fontWeight: widget.fontWeight)),
          SizedBox(
            width: 20 * SizeConfig.ratioWidth,
          ),
          Icon(
            Icons.date_range,
            color: Constants.mainColor,
            size: 24 * SizeConfig.ratioWidth,
          )
        ],
      ),
      onPressed: () {
        selectTimePicker(context);
      },
    );
  }
}
