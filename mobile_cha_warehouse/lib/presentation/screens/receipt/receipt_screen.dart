import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/inventory/inventory_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/qr_scanner_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key? key}) : super(key: key);
  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  DateTime selectedDate = DateTime.now();
  String receiptId = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                //  unselectedLabelColor: Colors.blueGrey,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Constants.secondaryColor,
                ),
                tabs: [
                  Tab(text: "Tạo đơn"),
                  Tab(text: "Cập nhật vị trí"),
                ],
              ),

              leading: IconButton(
                icon: const Icon(
                  Icons.west, //mũi tên back
                  color: Colors.white,
                ),
                onPressed: () {
                  goodsReceiptEntryConainerDataTemp.isNotEmpty
                      ? AlertDialogTwoBtnCustomized(
                              context,
                              'Bạn có chắc',
                              'Khi nhấn trở lại, mọi dữ liệu sẽ không được lưu',
                              'Trở lại',
                              'Tiếp tục', () {
                          Navigator.pushNamed(context, '///');
                        }, () {}, 18, 22)
                          .show()
                      : Navigator.pushNamed(context, '///');
                },
              ),
              backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
              //nút bên phải
              title: const Text(
                'Danh sách hàng hóa cần nhập',
                style: TextStyle(fontSize: 22), //chuẩn
              ),
            ),
            endDrawer: DrawerUser(),
            body: BlocConsumer<ReceiptBloc, ReceiptState>(
                listener: (context, receiptState) {},
                builder: (context, receiptState) {
                  //  if (receiptState is ReceiptInitialState) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TabBarView(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LabelText("Mã đơn"),
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
                                        onChanged: (value) =>
                                            {receiptId = value},

                                        controller: TextEditingController(),
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize:
                                                20 * SizeConfig.ratioFont),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal:
                                                  10 * SizeConfig.ratioHeight),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.0 *
                                                      SizeConfig.ratioWidth,
                                                  color: Colors.black)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.0 *
                                                      SizeConfig.ratioWidth,
                                                  color: Colors.black)),
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 20 * SizeConfig.ratioHeight,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 100 * SizeConfig.ratioWidth,
                                      child: Text(
                                        "Mã NV",
                                        style: TextStyle(
                                            fontSize: 21 * SizeConfig.ratioFont,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )),
                                  SizedBox(
                                    width: 100 * SizeConfig.ratioWidth,
                                    child: Text(
                                      "Mã SP",
                                      style: TextStyle(
                                          fontSize: 21 * SizeConfig.ratioFont,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100 * SizeConfig.ratioWidth,
                                    child: Text(
                                      "SL/KL",
                                      style: TextStyle(
                                          fontSize: 21 * SizeConfig.ratioFont,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              goodsReceiptEntryConainerDataTemp.isEmpty
                                  ? ExceptionErrorState(
                                      height: 300,
                                      title: "Chưa có rổ được nhập",
                                      message: "Quét mã để tiến hành nhập kho",
                                      imageDirectory:
                                          'lib/assets/sad_face_search.png',
                                      imageHeight: 140,
                                    )
                                  : Column(
                                      children:
                                          goodsReceiptEntryConainerDataTemp
                                              .map((item) => RowContainer(item))
                                              .toList(),
                                    ),
                            ],
                          ),
                          Column(
                            children: [
                              CustomizedButton(
                                  text: 'Nhập Kho',
                                  onPressed: () async {
                                    // nhảy đến trang quét QR điền thông tin
                                    scanQRReceiptresult = "-1";
                                    Navigator.pushNamed(
                                        context, '/qr_scanner_screen');
                                  }),
                              CustomizedButton(
                                  text: 'Hoàn Thành',
                                  onPressed: () {
                                    receiptId == ''
                                        ?
                                        // cảnh báo
                                        AlertDialogOneBtnCustomized(
                                                context,
                                                "Cảnh báo",
                                                "Bạn chưa nhập mã đơn",
                                                "Trở lại",
                                                () {},
                                                18,
                                                22,
                                                () {})
                                            .show()
                                        : AlertDialogTwoBtnCustomized(
                                                context,
                                                'Xác nhận',
                                                'Bạn đã hoàn thành tạo đơn nhập kho?',
                                                'Xác nhận',
                                                'Trở lại', () {
                                            //bloc event gửi đơn lên server
                                            BlocProvider.of<ReceiptBloc>(
                                                    context)
                                                .add(PostNewReceiptEvent(
                                                    goodsReceiptEntryConainerData,
                                                    DateTime.now(),
                                                    receiptId));
                                            // khi xác nhận hoàn thành đơn dữ liệu phải được đẩy lên server
                                            goodsReceiptEntryConainerDataTemp
                                                .clear();
                                            Navigator.pushNamed(context, '///');
                                          }, () {}, 18, 22)
                                            .show();
                                  })
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // SizedBox(
                                  //     width: 80 * SizeConfig.ratioWidth,
                                  //     child: Text(
                                  //       "Mã NV",
                                  //       style: TextStyle(
                                  //           fontSize: 21 * SizeConfig.ratioFont,
                                  //           fontWeight: FontWeight.bold),
                                  //       textAlign: TextAlign.center,
                                  //     )),
                                  // SizedBox(
                                  //   width: 80 * SizeConfig.ratioWidth,
                                  //   child: Text(
                                  //     "Mã SP",
                                  //     style: TextStyle(
                                  //         fontSize: 21 * SizeConfig.ratioFont,
                                  //         fontWeight: FontWeight.bold),
                                  //     textAlign: TextAlign.center,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 160 * SizeConfig.ratioWidth,
                                    child: Text(
                                      "Mã rổ",
                                      style: TextStyle(
                                          fontSize: 21 * SizeConfig.ratioFont,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 160 * SizeConfig.ratioWidth,
                                    child: Text(
                                      "Vị trí",
                                      style: TextStyle(
                                          fontSize: 21 * SizeConfig.ratioFont,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              locationContainer.isEmpty
                                  ? ExceptionErrorState(
                                      height: 300,
                                      title: "Chưa có rổ được nhập",
                                      message: "Quét mã để tiến hành nhập kho",
                                      imageDirectory:
                                          'lib/assets/sad_face_search.png',
                                      imageHeight: 140,
                                    )
                                  : Column(
                                      children: locationContainer
                                          .map((item) =>
                                              RowContainerLocation(item))
                                          .toList(),
                                    ),
                            ],
                          ),
                          Column(
                            children: [
                              CustomizedButton(
                                  text: 'Nhập Kho',
                                  onPressed: () async {
                                    // nhảy đến trang quét QR cập nhật vị trí
                                    scanQRReceiptresult = "-1";
                                    Navigator.pushNamed(
                                        context, '/scan_container_screen');
                                  }),
                              CustomizedButton(
                                  text: 'Hoàn Thành',
                                  onPressed: () async {
                                    AlertDialogTwoBtnCustomized(
                                            context,
                                            'Xác nhận',
                                            'Bạn đã hoàn thành nhập vị trí?',
                                            'Xác nhận',
                                            'Trở lại', () {
                                      // khi xác nhận hoàn thành đơn dữ liệu phải được đẩy lên server
                                      locationContainer.clear();
                                      Navigator.pushNamed(context, '///');
                                    }, () {}, 18, 22)
                                        .show();
                                  })
                            ],
                          )
                        ],
                      ),
                    ]),
                  );
                })));
  }
}

class RowContainer extends StatelessWidget {
  GoodsReceiptEntryContainerData goodsReceiptEntryContainerData;
  RowContainer(this.goodsReceiptEntryContainerData);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 380 * SizeConfig.ratioWidth,
        height: 80 * SizeConfig.ratioHeight,
        child: GestureDetector(
          // ignore: deprecated_member_use
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[300],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),

              // primary: bgColor,
              // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
            // padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 100 * SizeConfig.ratioWidth,
                    child: Text(
                      goodsReceiptEntryContainerData.employeeId,
                      style: TextStyle(
                          fontSize: 21 * SizeConfig.ratioFont,
                          fontWeight: FontWeight.bold,
                          color: Constants.mainColor),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  width: 100 * SizeConfig.ratioWidth,
                  child: Text(goodsReceiptEntryContainerData.itemId,
                      style: TextStyle(
                          fontSize: 21 * SizeConfig.ratioFont,
                          fontWeight: FontWeight.bold,
                          color: Constants.mainColor),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 100 * SizeConfig.ratioWidth,
                  child: Text(
                      goodsReceiptEntryContainerData.actualQuantity.toString(),
                      style: TextStyle(
                          fontSize: 21 * SizeConfig.ratioFont,
                          fontWeight: FontWeight.bold,
                          color: Constants.mainColor),
                      textAlign: TextAlign.center),
                ),
                IconButton(
                    onPressed: () {
                      AlertDialogTwoBtnCustomized(
                              context,
                              'Bạn có chắc?',
                              'Chọn Cập nhật hoặc Xóa rổ để tiếp tục',
                              'Cập nhật',
                              'Xóa rổ', () {
                        Navigator.pushNamed(context, '///');
                      }, () {}, 18, 22)
                          .show();
                    },
                    icon: Icon(Icons.mode_edit_rounded))
              ],
            ),
            onPressed: () async {
              //   Navigator.pushNamed(context, '/qr_scanner_screen');
            },
          ),
        ),
      ),
    );
  }
}

class RowContainerLocation extends StatelessWidget {
  LocationServer locationContainer;
  RowContainerLocation(this.locationContainer);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 380 * SizeConfig.ratioWidth,
        height: 80 * SizeConfig.ratioHeight,
        child: GestureDetector(
          // ignore: deprecated_member_use
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[300],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),

              // primary: bgColor,
              // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
            // padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //     width: 80 * SizeConfig.ratioWidth,
                //     child: Text(
                //       goodsReceiptEntryContainerData.employeeId,
                //       style: TextStyle(
                //           fontSize: 21 * SizeConfig.ratioFont,
                //           fontWeight: FontWeight.bold,
                //           color: Constants.mainColor),
                //       textAlign: TextAlign.center,
                //     )),
                // SizedBox(
                //   width: 80 * SizeConfig.ratioWidth,
                //   child: Text(goodsReceiptEntryContainerData.itemId,
                //       style: TextStyle(
                //           fontSize: 21 * SizeConfig.ratioFont,
                //           fontWeight: FontWeight.bold,
                //           color: Constants.mainColor),
                //       textAlign: TextAlign.center),
                // ),
                SizedBox(
                  width: 160 * SizeConfig.ratioWidth,
                  child: Text(locationContainer.containerId,
                      style: TextStyle(
                          fontSize: 21 * SizeConfig.ratioFont,
                          fontWeight: FontWeight.bold,
                          color: Constants.mainColor),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 160 * SizeConfig.ratioWidth,
                  child: Text(
                      locationContainer.shelfId +
                          locationContainer.rowId.toString() +
                          locationContainer.id.toString(),
                      style: TextStyle(
                          fontSize: 21 * SizeConfig.ratioFont,
                          fontWeight: FontWeight.bold,
                          color: Constants.mainColor),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
            onPressed: () async {
              //     Navigator.pushNamed(context, '/qr_scanner_screen');
            },
          ),
        ),
      ),
    );
  }
}
