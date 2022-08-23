import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/check_info_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/check_info_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/issue_params.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/qr_issue_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/modify_info_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';
import '../../bloc/events/issue_event.dart';
import '../../dialog/dialog.dart';
import '../../widget/exception_widget.dart';

// tương tự trang modify nhưng khác sự kiện xác nhận
List<String> labelTextList = [
  "Mã QR:",
  "Mã sản phẩm:",
  //"Mã nhân viên:",
  "Lấy hết rổ:",
  "SL thực tế:",
  "Ngày SX:",
];

class ConfirmContainerScreen extends StatefulWidget {
  @override
  State<ConfirmContainerScreen> createState() => _ConfirmContainerScreenState();
}

class _ConfirmContainerScreenState extends State<ConfirmContainerScreen> {
  String selectedFormat = '';

//  String employeeId = '';
  String itemId = '';

  String quanlity = '';

  String productionDate = "";

  bool isFull = false;

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
        body: BlocConsumer<CheckInfoBloc, CheckInfoState>(
            listener: (context, checkInfoState) {
          if (checkInfoState is CheckInfoStateSuccess) {
            // goodsIssueEntryData = issueState.goodsIssueEntryData;
            // String employeeId =
            //     checkInfoState.basket.productionEmployee.employeeId;
            itemId = checkInfoState.basket.item!.itemId;
            productionDate = checkInfoState.basket.productionDate;
            print(checkInfoState.basket);
            if (itemId != selectedItemId) {
              AlertDialogOneBtnCustomized(
                  context,
                  "Cảnh báo",
                  "Bạn đã chọn rổ sai mã sản phẩm",
                  "Trở lại",
                  () {
                    Navigator.pushNamed(context, '/qr_scanner_issue_screen');
                  },
                  18,
                  22,
                  () {
                    Navigator.pushNamed(context, '/qr_scanner_issue_screen');
                  }).show();
            }
          }
        }, builder: (context, checkInfoState) {
          if (checkInfoState is CheckInfoStateLoading) {
            return CircularLoading();
          }
          if (checkInfoState is CheckInfoStateSuccess) {
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
                                        horizontal:
                                            10 * SizeConfig.ratioHeight),

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
                            // Container(
                            //     padding: EdgeInsets.symmetric(
                            //         vertical: 5 * SizeConfig.ratioHeight),
                            //     alignment: Alignment.centerRight,
                            //     width: 200 * SizeConfig.ratioWidth,
                            //     height: 55 * SizeConfig.ratioHeight,
                            //     // color: Colors.grey[200],
                            //     child: TextField(
                            //       enabled: true,
                            //       //  readOnly: true
                            //       controller:
                            //           TextEditingController(text: employeeId),
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
                            //                 width: 1.0 * SizeConfig.ratioWidth,
                            //                 color: Colors.black)),
                            //         focusedBorder: OutlineInputBorder(
                            //             borderSide: BorderSide(
                            //                 width: 1.0 * SizeConfig.ratioWidth,
                            //                 color: Colors.black)),
                            //       ),
                            //     )),
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
                                  controller:
                                      TextEditingController(text: itemId),
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
                                            width: 1.0 * SizeConfig.ratioWidth,
                                            color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.0 * SizeConfig.ratioWidth,
                                            color: Colors.black)),
                                  ),
                                )),
                            // Container(
                            //   width: 200 * SizeConfig.ratioWidth,
                            //   height: 45 * SizeConfig.ratioHeight,
                            //   padding: const EdgeInsets.all(10),
                            //   decoration: BoxDecoration(
                            //       border: Border.all(
                            //           width: 0.5, color: Colors.black),
                            //       borderRadius: const BorderRadius.all(
                            //           Radius.circular(5))),
                            //   //Dropdown
                            //   child: DropdownSearch<String>(
                            //     dropdownSearchDecoration: InputDecoration(
                            //         hintText: "Lấy cả rổ",
                            //         hintStyle: TextStyle(
                            //             fontSize: 18 * SizeConfig.ratioFont),
                            //         // prefixText: "    ",
                            //         // prefixStyle: TextStyle(
                            //         //     fontSize: 18 * SizeConfig.ratioFont),
                            //         border: const UnderlineInputBorder(
                            //             borderSide: BorderSide.none)),
                            //     showAsSuffixIcons: true,
                            //     // popupTitle: Padding(
                            //     //   padding: EdgeInsets.all(
                            //     //       20 * SizeConfig.ratioRadius),
                            //     //   child: Text(
                            //     //     "Chọn cách thức xuất rổ",
                            //     //     style: TextStyle(
                            //     //         fontSize: 20 * SizeConfig.ratioFont),
                            //     //   ),
                            //     // ),
                            //     popupBackgroundColor: Colors.grey[200],
                            //     popupShape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(20)),
                            //     items: ["Có", "Không"],
                            //     selectedItem: selectedFormat,
                            //     onChanged: (String? data) {
                            //       selectedFormat = data.toString();
                            //       if (selectedFormat == "Có") {
                            //         setState(() {
                            //           isFull = true;
                            //           quanlity = checkInfoState.basket.quantity
                            //               .toString();
                            //         });
                            //       } else {
                            //         setState(() {
                            //           isFull = false;
                            //         });
                            //       }
                            //     },
                            //   ),
                            // ),
                              Container(
                                width: 200 * SizeConfig.ratioWidth,
                                height: 50 * SizeConfig.ratioHeight,
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Constants.mainColor),
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
                                      hintText: "Lấy cả rổ",
                                      hintStyle: TextStyle(
                                          fontSize: 16 * SizeConfig.ratioFont),
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      fillColor: Colors.blue),
                                  showAsSuffixIcons: true,
                                  popupTitle: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      "Bạn sẽ lấy cả rổ ?",
                                      style: TextStyle(
                                          fontSize: 22 * SizeConfig.ratioFont),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  popupBackgroundColor: Colors.grey[200],
                                  popupShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  items: ["Có", "Không"],
                                  //searchBoxDecoration: InputDecoration(),
                                   selectedItem: selectedFormat,
                                  onChanged: (String? data) {
                                   selectedFormat = data.toString();
                                  if (selectedFormat == "Có") {
                                    setState(() {
                                      isFull = true;
                                      quanlity = checkInfoState.basket.quantity
                                          .toString();
                                    });
                                  } else {
                                    setState(() {
                                      isFull = false;
                                    });
                                  }
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
                                  onChanged: (value) => {quanlity = value},
                                  readOnly: isFull,
                                  controller: isFull == true
                                      ? TextEditingController(
                                          text: checkInfoState.basket.quantity
                                              .toString())
                                      : TextEditingController(
                                          text: quanlity.toString()),
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
                                        horizontal:
                                            10 * SizeConfig.ratioHeight),
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
                            goodsIssueEntryContainerData.add(
                                ContainerIssueExportServer(
                                    selectedGoodIssueId,
                                    itemId,
                                    scanQRIssueresult,
                                    double.parse(quanlity)));
                            print(goodsIssueEntryContainerData);
                            BlocProvider.of<IssueBloc>(context).add(
                                LoadContainerExportEvent(DateTime.now(),
                                    selectedGoodIssueId, selectedItemId));
                            Navigator.pushNamed(
                              context,
                              '/list_container_screen',
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return ExceptionErrorState(
              height: 300,
              title: "Không tìm thấy dữ liệu rổ",
              message: "Vui lòng kiểm tra lại.",
              imageDirectory: 'lib/assets/sad_face_search.png',
              imageHeight: 140,
            );
          }
        }));
  }
}
