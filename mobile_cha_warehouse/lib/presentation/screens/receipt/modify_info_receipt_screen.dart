
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/qr_scanner_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../../constant.dart';

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

class ModifyInfoScreen extends StatelessWidget {
  String itemId = '';
  String actual = '';
  String employeeId = '';

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
        body: BlocConsumer<ReceiptBloc, ReceiptState>(
          listener: (context, state) {
            if (state is CheckContainerStateFail) {
              AlertDialogOneBtnCustomized(
                      context, "Cảnh báo", state.error, "Trở lại", () {
                Navigator.pushNamed(context, '/qr_scanner_screen');
              }, 18, 22, () {})
                  .show();
            } else if (state is ReceiptLoadingState) {
              CircularLoading();
            }
          },
          builder: (context, state) {
            if (state is ReceiptLoadingState) {
              return CircularLoading();
            } else {
              return SingleChildScrollView(
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
                                    //  readOnly: true,
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
                                          horizontal:
                                              10 * SizeConfig.ratioHeight),

                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width:
                                                  1.0 * SizeConfig.ratioWidth,
                                              color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width:
                                                  1.0 * SizeConfig.ratioWidth,
                                              color: Colors.black)),
                                    ),
                                  )),

                              Container(
                                width: 200 * SizeConfig.ratioWidth,
                                height: 50 * SizeConfig.ratioHeight,
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  // borderRadius: const BorderRadius.all(
                                  //     const Radius.circular(10))
                                ),
                                child: DropdownSearch(
                                  dropdownSearchDecoration: InputDecoration(
                                      contentPadding: SizeConfig.ratioHeight >=
                                              1
                                          ? EdgeInsets.fromLTRB(
                                              50 * SizeConfig.ratioWidth,
                                              14 * SizeConfig.ratioHeight,
                                              3 * SizeConfig.ratioWidth,
                                              3 * SizeConfig.ratioHeight)
                                          : const EdgeInsets.fromLTRB(45, 7, 3,
                                              3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                                      hintText: "Chọn mã",
                                      hintStyle: TextStyle(
                                          fontSize: 16 * SizeConfig.ratioFont),
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      fillColor: Colors.blue),
                                  showAsSuffixIcons: true,
                                  popupTitle: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      "Chọn mã sản phẩm",
                                      style: TextStyle(
                                          fontSize: 22 * SizeConfig.ratioFont),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  popupBackgroundColor: Colors.grey[200],
                                  popupShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  items: listitemId,
                                  //searchBoxDecoration: InputDecoration(),
                                  onChanged: (String? data) {
                                    itemId = data.toString();
                                  },
                                  showSearchBox: true,
                                  //  autoFocusSearchBox: true,
                                ),
                              ),
                              // Container(
                              //     padding: EdgeInsets.symmetric(
                              //         vertical: 5 * SizeConfig.ratioHeight),
                              //     alignment: Alignment.centerRight,
                              //     width: 200 * SizeConfig.ratioWidth,
                              //     height: 55 * SizeConfig.ratioHeight,
                              //     //color: Colors.grey[200],
                              //     child: TextField(
                              //       enabled: true,
                              //       onChanged: (value) => {itemId = value},
                              //       //    readOnly: true,
                              //       controller: TextEditingController(),
                              //       textAlignVertical: TextAlignVertical.center,
                              //       textAlign: TextAlign.center,
                              //       style: TextStyle(
                              //           fontSize: 20 * SizeConfig.ratioFont),
                              //       decoration: InputDecoration(
                              //         contentPadding: EdgeInsets.symmetric(
                              //             horizontal:
                              //                 10 * SizeConfig.ratioHeight),
                              //         border: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 width:
                              //                     1.0 * SizeConfig.ratioWidth,
                              //                 color: Colors.black)),
                              //         focusedBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 width:
                              //                     1.0 * SizeConfig.ratioWidth,
                              //                 color: Colors.black)),
                              //       ),
                              //     )),
                              Container(
                                width: 200 * SizeConfig.ratioWidth,
                                height: 50 * SizeConfig.ratioHeight,
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.6, color: Colors.grey),
                                  // borderRadius: const BorderRadius.all(
                                  //     const Radius.circular(10))
                                ),
                                child: DropdownSearch(
                                  dropdownSearchDecoration: InputDecoration(
                                      contentPadding: SizeConfig.ratioHeight >=
                                              1
                                          ? EdgeInsets.fromLTRB(
                                              50 * SizeConfig.ratioWidth,
                                              14 * SizeConfig.ratioHeight,
                                              3 * SizeConfig.ratioWidth,
                                              3 * SizeConfig.ratioHeight)
                                          : const EdgeInsets.fromLTRB(45, 7, 3,
                                              3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                                      hintText: "Chọn mã",
                                      hintStyle: TextStyle(
                                          fontSize: 16 * SizeConfig.ratioFont),
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      fillColor: Colors.blue),
                                  showAsSuffixIcons: true,
                                  popupTitle: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      "Chọn mã nhân viên",
                                      style: TextStyle(
                                          fontSize: 22 * SizeConfig.ratioFont),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  popupBackgroundColor: Colors.grey[200],
                                  popupShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  items: listemployeeId,
                                  //searchBoxDecoration: InputDecoration(),
                                  onChanged: (String? data) {
                                    employeeId = data.toString();
                                  },
                                  showSearchBox: true,
                                  //  autoFocusSearchBox: true,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  alignment: Alignment.centerRight,
                                  width: 200 * SizeConfig.ratioWidth,
                                  height: 55 * SizeConfig.ratioHeight,
                                  //color: Colors.grey[200],
                                  child: TextField(
                                    enabled: true,
                                    onChanged: (value) => {actual = value},
                                    //    readOnly: true,
                                    controller: TextEditingController(),
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20 * SizeConfig.ratioFont),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              10 * SizeConfig.ratioHeight),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width:
                                                  1.0 * SizeConfig.ratioWidth,
                                              color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width:
                                                  1.0 * SizeConfig.ratioWidth,
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
                                                .subtract(const Duration(days: 1)))),
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20 * SizeConfig.ratioFont),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              10 * SizeConfig.ratioHeight),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width:
                                                  1.0 * SizeConfig.ratioWidth,
                                              color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width:
                                                  1.0 * SizeConfig.ratioWidth,
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
                              if (actual != '' &&
                                  itemId != '' &&
                                  employeeId != '') {
                                // thêm rổ vừa điền thông tin vào danh sách

                                goodsReceiptEntryConainerDataTemp.add(
                                  GoodsReceiptEntryContainerData(
                                    scanQRReceiptresult,
                                    employeeId,
                                    itemId,
                                    int.parse(actual),
                                    DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now()
                                            .subtract(const Duration(days: 1)))
                                        .toString(),
                                  ),
                                );

                                Navigator.pushNamed(context, '/receipt_screen');
                              } else {
                                AlertDialogOneBtnCustomized(
                                        context,
                                        "Cảnh báo",
                                        "Chưa hoàn thành nhập thông tin rổ",
                                        "Trở lại",
                                        () {},
                                        18,
                                        22,
                                        () {})
                                    .show();
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
