import 'dart:ffi';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../../constant.dart';

List<String> labelTextList = [
  "Mã lô:",
  "Mã sản phẩm:",
  "Tên sản phẩm:",
  "Mã nhân viên:",
  "Ngày SX:",
  "Ca SX:",
  "Đơn vị",
  "Thực tế:",
  "Vị trí kệ:",
];

List<String> labelTextList2 = [
  "Mã lô:",
  "Mã sản phẩm:",
  "Tên sản phẩm:",
  "Đơn vị",
  "Thực tế:",
  "Ngày SX:",
  "Vị trí kệ:",
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

class ModifyInfoScreen extends StatefulWidget {
  @override
  State<ModifyInfoScreen> createState() => _ModifyInfoScreenState();
}

class _ModifyInfoScreenState extends State<ModifyInfoScreen> {
  String itemId = '';

  String itemName = '';

  DateTime date = DateFormat('yyyy-MM-dd').parse(DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(const Duration(days: 1))));
  // DateFormat('yyyy-MM-dd')
  //     .parse(DateTime.now().subtract(const Duration(days: 1)).toString());
  String actual = '';

  String lotId = '';

  String noteShift = '';

  String unitUpdate = '';

  String employeeId = '';

  double piecePerKg = 1;

  String unit = '';

  bool hasManyUnits = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go back?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/receipt_screen');
                    // Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.west, //mũi tên back
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/receipt_screen');
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
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 350 * SizeConfig.ratioWidth,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  width: 350 * SizeConfig.ratioWidth,
                                  height: 60 * SizeConfig.ratioHeight,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(5))),
                                  child: DropdownSearch(
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: "Mã sản phẩm",
                                        labelStyle: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 25 * SizeConfig.ratioFont,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                10 * SizeConfig.ratioHeight),
                                        hintText: "Chọn mã",
                                        hintStyle: TextStyle(
                                            fontSize:
                                                16 * SizeConfig.ratioFont),
                                        border: const UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        fillColor: Colors.blue),
                                    showAsSuffixIcons: true,
                                    popupTitle: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "Chọn mã sản phẩm",
                                        style: TextStyle(
                                            fontSize:
                                                16 * SizeConfig.ratioFont),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    popupBackgroundColor: Colors.grey[200],
                                    popupShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    items: listitemId,

                                    selectedItem: itemId,
                                    //searchBoxDecoration: InputDecoration(),
                                    onChanged: (String? data) {
                                      itemId = data.toString();
                                      setState(() {
                                        for (var element in listItem) {
                                          if (element.itemId == itemId) {
                                            piecePerKg = double.parse(element
                                                .piecesPerKilogram
                                                .toString());
                                            hasManyUnits = element.hasManyUnits;
                                            itemName = element.name;
                                            if (element.unit == 1) {
                                              unit = "kg";
                                            } else {
                                              unit = "cái";
                                            }
                                            unitUpdate = unit;
                                          }
                                        }
                                      });
                                    },
                                    showSearchBox: true,
                                    //  autoFocusSearchBox: true,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  width: 350 * SizeConfig.ratioWidth,
                                  height: 60 * SizeConfig.ratioHeight,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(5))),
                                  child: DropdownSearch(
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: "Tên sản phẩm",
                                        labelStyle: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 25 * SizeConfig.ratioFont,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                10 * SizeConfig.ratioHeight),
                                        hintText: "Tên sản phẩm",
                                        hintStyle: TextStyle(
                                            fontSize:
                                                16 * SizeConfig.ratioFont),
                                        border: const UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        fillColor: Colors.blue),
                                    showAsSuffixIcons: true,
                                    popupTitle: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        "Chọn tên sản phẩm",
                                        style: TextStyle(
                                            fontSize:
                                                16 * SizeConfig.ratioFont),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    popupBackgroundColor: Colors.grey[200],
                                    popupShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    items: listItemName,
                                    selectedItem: itemName,
                                    //searchBoxDecoration: InputDecoration(),
                                    onChanged: (String? data) {
                                      itemName = data.toString();
                                      setState(() {
                                        for (var element in listItem) {
                                          if (element.name == itemName) {
                                            itemId = element.itemId;
                                            piecePerKg = double.parse(element
                                                .piecesPerKilogram
                                                .toString());
                                            hasManyUnits = element.hasManyUnits;
                                            if (element.unit == 1) {
                                              unit = "kg";
                                            } else {
                                              unit = "cái";
                                            }
                                            unitUpdate = unit;
                                          }
                                        }
                                      });
                                    },
                                    showSearchBox: true,
                                    //  autoFocusSearchBox: true,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  width: 350 * SizeConfig.ratioWidth,
                                  height: 60 * SizeConfig.ratioHeight,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(5))),
                                  child: DropdownSearch(
                                    dropdownSearchDecoration: InputDecoration(
                                        labelText: "Mã nhân viên",
                                        labelStyle: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 25 * SizeConfig.ratioFont,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                10 * SizeConfig.ratioHeight),
                                        hintText: "Mã nhân viên",
                                        hintStyle: TextStyle(
                                            fontSize:
                                                16 * SizeConfig.ratioFont),
                                        border: const UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        fillColor: Colors.blue),
                                    showAsSuffixIcons: true,
                                    popupTitle: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        "Chọn mã nhân viên",
                                        style: TextStyle(
                                            fontSize:
                                                16 * SizeConfig.ratioFont),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    popupBackgroundColor: Colors.grey[200],
                                    popupShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    items: listemployeeId,
                                    selectedItem: employeeId,
                                    //searchBoxDecoration: InputDecoration(),
                                    onChanged: (String? data) {
                                      employeeId = data.toString();
                                    },
                                    showSearchBox: true,
                                    //  autoFocusSearchBox: true,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  width: 350 * SizeConfig.ratioWidth,
                                  height: 60 * SizeConfig.ratioHeight,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(5))),
                                  child: CustomizeDatePicker(
                                    fontColor: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    initDateTime: date,
                                    okBtnClickedFunction: (pickedTime) {
                                      date = pickedTime;
                                    },
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5 * SizeConfig.ratioHeight),
                                    width: 350 * SizeConfig.ratioWidth,
                                    height: 60 * SizeConfig.ratioHeight,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5 * SizeConfig.ratioHeight),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(5))),
                                    child: DropdownSearch(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                labelText: "Ca sản xuất",
                                                labelStyle: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize:
                                                      25 * SizeConfig.ratioFont,
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10 *
                                                            SizeConfig
                                                                .ratioHeight),
                                                hintText: "",
                                                hintStyle: TextStyle(
                                                    fontSize: 16 *
                                                        SizeConfig.ratioFont),
                                                border:
                                                    const UnderlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none),
                                                fillColor: Colors.blue),
                                        showAsSuffixIcons: true,
                                        popupTitle: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Text(
                                            "Chọn ca sản xuất?",
                                            style: TextStyle(
                                                fontSize:
                                                    22 * SizeConfig.ratioFont),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        popupBackgroundColor: Colors.grey[200],
                                        popupShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        items: ["0", "1", "2"],
                                        selectedItem: noteShift,
                                        onChanged: (String? data) {
                                          noteShift = data.toString();
                                          setState(() {
                                            data != "0"
                                                ? lotId = "$itemId-" +
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(date) +
                                                    "-$data"
                                                : lotId = "$itemId-" +
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(date);
                                          });
                                        })),
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5 * SizeConfig.ratioHeight),
                                    width: 350 * SizeConfig.ratioWidth,
                                    height: 60 * SizeConfig.ratioHeight,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5 * SizeConfig.ratioHeight),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(5))),
                                    child: DropdownSearch(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                labelText: "Đơn vị tính",
                                                labelStyle: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize:
                                                      25 * SizeConfig.ratioFont,
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10 *
                                                            SizeConfig
                                                                .ratioHeight),
                                                hintText: "",
                                                hintStyle: TextStyle(
                                                    fontSize: 16 *
                                                        SizeConfig.ratioFont),
                                                border:
                                                    const UnderlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none),
                                                fillColor: Colors.blue),
                                        showAsSuffixIcons: true,
                                        popupTitle: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Text(
                                            "Chọn đơn vị tính?",
                                            style: TextStyle(
                                                fontSize:
                                                    22 * SizeConfig.ratioFont),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        popupBackgroundColor: Colors.grey[200],
                                        popupShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        items: ["cái", "kg"],
                                        selectedItem: unitUpdate,
                                        onChanged: (String? data) {
                                          unitUpdate = data.toString();
                                          // if (data != unit && unit == "cái") {
                                          //   kgPerPiece = 1 / piecePerKg;
                                          // } else if (data != unit &&
                                          //     unit == "kg") {
                                          //   piecePerKg = 1 / piecePerKg;
                                          // }
                                        })),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5 * SizeConfig.ratioHeight),
                                    alignment: Alignment.centerRight,
                                    width: 350 * SizeConfig.ratioWidth,
                                    height: 55 * SizeConfig.ratioHeight,
                                    //color: Colors.grey[200],
                                    child: TextField(
                                      enabled: true,

                                      //  readOnly: true,
                                      onChanged: (value) => {lotId = value},
                                      controller:
                                          TextEditingController(text: lotId),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20 * SizeConfig.ratioFont),
                                      decoration: InputDecoration(
                                        labelText: "Mã lô",
                                        labelStyle: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 20 * SizeConfig.ratioFont,
                                        ),
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
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5 * SizeConfig.ratioHeight),
                                    alignment: Alignment.centerRight,
                                    width: 350 * SizeConfig.ratioWidth,
                                    height: 55 * SizeConfig.ratioHeight,
                                    //color: Colors.grey[200],
                                    child: TextField(
                                      enabled: true,

                                      //  readOnly: true,
                                      onChanged: (value) => {actual = value},
                                      controller:
                                          TextEditingController(text: actual),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20 * SizeConfig.ratioFont),
                                      decoration: InputDecoration(
                                        labelText: "Khối lượng / Số lượng",
                                        labelStyle: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 20 * SizeConfig.ratioFont,
                                        ),
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
                              ]),
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
                                    lotId != '') {
                                  // thêm rổ vừa điền thông tin vào danh sách
                                  if (hasManyUnits == false &&
                                      unit == "cái" &&
                                      unitUpdate == "cái") {
                                    goodsReceiptEntryConainerDataTemp.add(
                                      GoodsReceiptEntryContainerData(
                                        lotId,
                                        itemId,
                                        double.parse(actual),
                                        0.0,
                                        piecePerKg,
                                        unit,
                                        employeeId,
                                        date.toString(),
                                        noteShift,
                                      ),
                                    );
                                  } else if (hasManyUnits == false &&
                                      unit == "cái" &&
                                      unitUpdate == "kg") {
                                    goodsReceiptEntryConainerDataTemp.add(
                                      GoodsReceiptEntryContainerData(
                                        lotId,
                                        itemId,
                                        double.parse((double.parse(actual) * piecePerKg).toStringAsFixed(2)),
                                        0.0,
                                        piecePerKg,
                                        unit,
                                        employeeId,
                                        date.toString(),
                                        noteShift,
                                      ),
                                    );
                                  } else if (hasManyUnits == true &&
                                      unit == "cái" &&
                                      unitUpdate == "cái") {
                                    goodsReceiptEntryConainerDataTemp.add(
                                      GoodsReceiptEntryContainerData(
                                        lotId,
                                        itemId,
                                        double.parse(actual),
                                       double.parse((double.parse(actual) * (1 / piecePerKg)).toStringAsFixed(2)),
                                        piecePerKg,
                                        unit,
                                        employeeId,
                                        date.toString(),
                                        noteShift,
                                      ),
                                    );
                                  } else if (hasManyUnits == true &&
                                      unit == "cái" &&
                                      unitUpdate == "kg") {
                                    goodsReceiptEntryConainerDataTemp.add(
                                      GoodsReceiptEntryContainerData(
                                        lotId,
                                        itemId,
                                       double.parse((double.parse(actual) * piecePerKg).toStringAsFixed(2)),
                                        double.parse(actual),
                                        piecePerKg,
                                        unit,
                                        employeeId,
                                        date.toString(),
                                        noteShift,
                                      ),
                                    );
                                  }

                                  Navigator.pushNamed(
                                      context, '/receipt_screen');
                                } else {
                                  AlertDialogOneBtnCustomized(
                                          context,
                                          "Cảnh báo",
                                          "Chưa hoàn thành nhập thông tin lô",
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
          )),
    );
  }
}
