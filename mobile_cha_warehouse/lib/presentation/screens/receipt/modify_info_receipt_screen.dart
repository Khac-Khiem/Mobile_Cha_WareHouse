import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/stockcard_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/stockcard_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/qr_scanner_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';

import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';

bool a = true;

List<String> labelTextList = [
  "Mã QR:",
  "Mã sản phẩm:",
  "Mã nhân viên:",
  "SL thực tế:",
  "Ngày SX:",
];

class LabelText extends StatelessWidget {
  String text;
  LabelText(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * SizeConfig.ratioHeight),
      alignment: Alignment.centerRight,

      width: 135 * SizeConfig.ratioWidth,
      height: 55 * SizeConfig.ratioHeight,
      //color: Colors.amber,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20 * SizeConfig.ratioFont, fontWeight: FontWeight.bold),
      ),
    );
  }
}

//
String itemId = '';
int actual = 0;
String employeeId = '';

class ModifyInfoScreen extends StatelessWidget {
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
                                  text: scanQRReceiptresult),
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
                        // thêm rổ vừa điền thông tin vào danh sách
                        goodsReceiptEntryConainerDataTemp.add(
                          GoodsReceiptEntryContainerData(
                              scanQRReceiptresult,
                              employeeId,
                              itemId,
                              actual,
                             DateFormat('yyyy-MM-dd').format(
                                      DateTime.now()
                                          .subtract(Duration(days: 1))).toString(),
                              ),
                        );
                      //  a = !a;
                        // BlocProvider.of<ReceiptBloc>(context)
                        //     .add(AddcontainerScanned(
                        //   GoodsReceiptEntryContainerData(
                        //       scanQRReceiptresult,
                        //       employeeId,
                        //       itemId,
                        //       actual,
                        //       DateTime.now().toString(),
                        //       ''),
                        // ));
                        Navigator.pushNamed(context, '/receipt_screen');
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
