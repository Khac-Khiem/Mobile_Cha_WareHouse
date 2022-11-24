import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/modify_info_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../../constant.dart';

class UpdateInfoScreen extends StatefulWidget {
  String itemIdConfirm;
  GoodsReceiptEntryContainerData lotReceipt;
  UpdateInfoScreen(this.itemIdConfirm, this.lotReceipt);
  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  String itemId = '';

  String itemName = '';

  DateTime date = DateFormat('yyyy-MM-dd').parse(DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(const Duration(days: 1))));

  String actualQuantity = '';

  String actualMass = '';

  String lotId = '';

  String employeeId = '';

  String noteShift = '';

  String unitUpdate = '';

  double peicesPerKg = 1;

  String unit = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lotId = widget.lotReceipt.lotId;
    itemId = widget.lotReceipt.itemId;
    for (var element in listItem) {
      if (element.itemId == itemId) {
        itemName = element.name;
        element.unit == 1 ? unit = "kg" : unit = "cái";
      }
    }
    unit = widget.lotReceipt.unit;
    employeeId = widget.lotReceipt.productionEmployeeId;
    noteShift = widget.lotReceipt.note;
    peicesPerKg = widget.lotReceipt.piecesPerKg;
    date = DateFormat('yyyy-MM-dd').parse(widget.lotReceipt.productionDate);
    actualQuantity = widget.lotReceipt.actualQuantity.toString();
    actualMass = widget.lotReceipt.actualMass.toString();
  }

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
              // bottom: TabBar(
              //   //  unselectedLabelColor: Colors.blueGrey,
              //   indicator: BoxDecoration(
              //     borderRadius: BorderRadius.circular(50),
              //     color: Constants.secondaryColor,
              //   ),
              //   tabs: [
              //     const Tab(text: "Nhập SX"),
              //     const Tab(text: "Nhập ngoài"),
              //   ],
              // ),
              backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
              //nút bên phải
              title: const Text(
                'Cập nhật lô hàng',
                style: TextStyle(fontSize: 22), //chuẩn
              ),
            ),
            endDrawer: DrawerUser(),
            body: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350 * SizeConfig.ratioWidth,
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 5 * SizeConfig.ratioHeight),
                          width: 300 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          padding: EdgeInsets.symmetric(
                              vertical: 5 * SizeConfig.ratioHeight),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
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
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                hintText: "Chọn mã",
                                hintStyle: TextStyle(
                                    fontSize: 16 * SizeConfig.ratioFont),
                                border: const UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                fillColor: Colors.blue),
                            showAsSuffixIcons: true,
                            popupTitle: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Chọn mã sản phẩm",
                                style: TextStyle(
                                    fontSize: 16 * SizeConfig.ratioFont),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            popupBackgroundColor: Colors.grey[200],
                            popupShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            items: listitemId,

                            selectedItem: itemId,
                            //searchBoxDecoration: InputDecoration(),
                            onChanged: (String? data) {
                              itemId = data.toString();
                              setState(() {
                                for (var element in listItem) {
                                  if (element.itemId == itemId) {
                                    peicesPerKg = double.parse(
                                        element.piecesPerKilogram.toString());
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
                          width: 300 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          padding: EdgeInsets.symmetric(
                              vertical: 5 * SizeConfig.ratioHeight),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
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
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                hintText: "Tên sản phẩm",
                                hintStyle: TextStyle(
                                    fontSize: 16 * SizeConfig.ratioFont),
                                border: const UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                fillColor: Colors.blue),
                            showAsSuffixIcons: true,
                            popupTitle: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "Chọn tên sản phẩm",
                                style: TextStyle(
                                    fontSize: 16 * SizeConfig.ratioFont),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            popupBackgroundColor: Colors.grey[200],
                            popupShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            items: listItemName,
                            selectedItem: itemName,
                            //searchBoxDecoration: InputDecoration(),
                            onChanged: (String? data) {
                              itemName = data.toString();
                              setState(() {
                                for (var element in listItem) {
                                  if (element.name == itemName) {
                                    itemId = element.itemId;
                                    peicesPerKg = double.parse(
                                        element.piecesPerKilogram.toString());
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
                          width: 300 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          padding: EdgeInsets.symmetric(
                              vertical: 5 * SizeConfig.ratioHeight),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
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
                                    horizontal: 10 * SizeConfig.ratioHeight),
                                // contentPadding: SizeConfig
                                //             .ratioHeight >=
                                //         1
                                //     ? EdgeInsets.fromLTRB(
                                //         50 * SizeConfig.ratioWidth,
                                //         14 * SizeConfig.ratioHeight,
                                //         3 * SizeConfig.ratioWidth,
                                //         3 * SizeConfig.ratioHeight)
                                //     : const EdgeInsets.fromLTRB(
                                //         45,
                                //         7,
                                //         3,
                                //         3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                                hintText: "Mã nhân viên",
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
                                    fontSize: 16 * SizeConfig.ratioFont),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            popupBackgroundColor: Colors.grey[200],
                            popupShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
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
                          width: 300 * SizeConfig.ratioWidth,
                          height: 60 * SizeConfig.ratioHeight,
                          padding: EdgeInsets.symmetric(
                              vertical: 5 * SizeConfig.ratioHeight),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
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
                            width: 300 * SizeConfig.ratioWidth,
                            height: 60 * SizeConfig.ratioHeight,
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(5))),
                            child: DropdownSearch(
                                dropdownSearchDecoration: InputDecoration(
                                    labelText: "Ca sản xuất",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 25 * SizeConfig.ratioFont,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal:
                                            10 * SizeConfig.ratioHeight),
                                    hintText: "",
                                    hintStyle: TextStyle(
                                        fontSize: 16 * SizeConfig.ratioFont),
                                    border: const UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    fillColor: Colors.blue),
                                showAsSuffixIcons: true,
                                popupTitle: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    "Chọn ca sản xuất?",
                                    style: TextStyle(
                                        fontSize: 22 * SizeConfig.ratioFont),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                popupBackgroundColor: Colors.grey[200],
                                popupShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                items: ["0", "1", "2"],
                                selectedItem: noteShift,
                                onChanged: (String? data) {
                                  setState(() {
                                    noteShift = data.toString();
                                    data != "0"
                                        ? lotId = "$itemId - " +
                                            DateFormat('yyyy-MM-dd')
                                                .format(date) +
                                            " - $data"
                                        : lotId = "$itemId - " +
                                            DateFormat('yyyy-MM-dd')
                                                .format(date);
                                  });
                                })),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            width: 300 * SizeConfig.ratioWidth,
                            height: 60 * SizeConfig.ratioHeight,
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(5))),
                            child: DropdownSearch(
                                dropdownSearchDecoration: InputDecoration(
                                    labelText: "Đơn vị tính",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 25 * SizeConfig.ratioFont,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal:
                                            10 * SizeConfig.ratioHeight),
                                    hintText: "",
                                    hintStyle: TextStyle(
                                        fontSize: 16 * SizeConfig.ratioFont),
                                    border: const UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    fillColor: Colors.blue),
                                showAsSuffixIcons: true,
                                popupTitle: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    "Chọn đơn vị tính?",
                                    style: TextStyle(
                                        fontSize: 22 * SizeConfig.ratioFont),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                popupBackgroundColor: Colors.grey[200],
                                popupShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                items: ["cái", "kg"],
                                selectedItem: unitUpdate,
                                onChanged: (String? data) {
                                  unitUpdate = data.toString();
                                  // if (data != unit && unit == "cái") {
                                  // } else if (data != unit && unit == "kg") {
                                  //   ratioQuantity = 1 / ratioQuantity;
                                  // }
                                })),
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 300 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,

                              //  readOnly: true,
                              onChanged: (value) => {lotId = value},
                              controller: TextEditingController(text: lotId),
                              textAlignVertical: TextAlignVertical.center,
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
                            width: 300 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,

                              //  readOnly: true,
                              //  onChanged: (value) => {actualMass = value

                              //  },
                              onChanged: (data) {
                                setState(() {
                                  actualMass = data.toString();
                                  actualQuantity =
                                      (double.parse(actualMass) * peicesPerKg)
                                          .toString();
                                });
                              },
                              controller:
                                  TextEditingController(text: actualMass),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                labelText: "Khối lượng: ",
                                labelStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 20 * SizeConfig.ratioFont,
                                ),
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
                            width: 300 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,

                              //  readOnly: true,
                              // onChanged: (value) => {actualQuantity = value},
                              onChanged: (data) {
                                setState(() {
                                  actualQuantity = data.toString();
                                  actualMass = (double.parse(actualQuantity) *
                                          1 /
                                          peicesPerKg)
                                      .toString();
                                });
                              },
                              controller:
                                  TextEditingController(text: actualQuantity),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                labelText: "Số lượng: ",
                                labelStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 20 * SizeConfig.ratioFont,
                                ),
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
                            // if (actual != '' &&
                            //     itemId != '' &&
                            //     lotId != '') {
                            //   // thêm rổ vừa điền thông tin vào danh sách
                            // goodsReceiptEntryConainerDataTemp.removeAt(widget.index);
                            goodsReceiptEntryConainerDataTemp.removeWhere(
                                (element) =>
                                    element.itemId == widget.itemIdConfirm);
                            goodsReceiptEntryConainerDataTemp.add(
                              GoodsReceiptEntryContainerData(
                                lotId,
                                itemId,
                                double.parse(actualQuantity),
                                double.parse(actualMass),
                                peicesPerKg,
                                unit,
                                employeeId,
                                date.toString(),
                                noteShift,
                              ),
                            );

                            Navigator.pushNamed(context, '/receipt_screen');
                            // } else {
                            //   AlertDialogOneBtnCustomized(
                            //           context,
                            //           "Cảnh báo",
                            //           "Chưa hoàn thành nhập thông tin lô",
                            //           "Trở lại",
                            //           () {},
                            //           18,
                            //           22,
                            //           () {})
                            //       .show();
                            // }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
