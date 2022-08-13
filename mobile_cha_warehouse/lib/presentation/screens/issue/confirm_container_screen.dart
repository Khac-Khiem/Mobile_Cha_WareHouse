import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/qr_issue_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/modify_info_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';

// tương tự trang modify nhưng khác sự kiện xác nhận
List<String> labelTextList = [
  "Mã QR:",
  "Mã sản phẩm:",
  "Mã nhân viên:",
  "Lấy hết rổ:",
  "SL thực tế:",
  "Ngày SX:",
];
class ConfirmCOntainerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }, //sự kiện mũi tên back
          ),
          backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
          //nút bên phải
          title: const Text(
            'Nhập kho',
            style: TextStyle(fontSize: 22), //chuẩn
          ),
        ),
        endDrawer: DrawerUser(),
        body: SingleChildScrollView(
          //   child: Text('haha'),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350 * SizeConfig.ratioWidth,
                  child: Row(
                    children: [
                      Column(
                          children: labelTextList
                              .map((text) => LabelText(
                                    text,
                                  ))
                              .toList()),
                      SizedBox(
                        width: 15 * SizeConfig.ratioWidth,
                      ),
                      Column(children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 200 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,
                              readOnly: true,
                              controller: TextEditingController(
                                  text: scanQRIssueresult),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                // filled: true,
                                // fillColor: Colors.grey[300],
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 200 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            // color: Colors.grey[200],
                            child: TextField(
                              enabled: true,
                              //  readOnly: true,
                              onChanged: (value) => {employeeId = value},

                              controller: TextEditingController(),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 200 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,
                              onChanged: (value) => {itemId = value},
                              //    readOnly: true,
                              controller: TextEditingController(),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 200 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,
                              onChanged: (value) => {actual = int.parse(value)},
                              //    readOnly: true,
                              controller: TextEditingController(),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 200 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,
                              onChanged: (value) => {actual = int.parse(value)},
                              //    readOnly: true,
                              controller: TextEditingController(),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 200 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,
                              //  readOnly: true,
                              controller: TextEditingController(
                                  text: DateFormat('yyyy-MM-dd').format(
                                      DateTime.now()
                                          .subtract(Duration(days: 1)))),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0 * SizeConfig.ratioWidth,
                                        color: Colors.black)),
                              ),
                            )),
                       
                      ])
                    ],
                  ),
                ),
                SizedBox(
                  height: 20 * SizeConfig.ratioHeight,
                ),
                Column(
                  children: [
                    CustomizedButton(
                      text: "Xác nhận",
                      bgColor: Constants.mainColor,
                      fgColor: Colors.white,
                      onPressed: () async {
                      
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

