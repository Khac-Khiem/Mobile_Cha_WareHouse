import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
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

  int itemType = 0;
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
        body: BlocConsumer<IssueBloc, IssueState>(
            listener: (context, issueState) {
          if (issueState is CheckInfoIssueStateSuccess) {
            // goodsIssueEntryData = issueState.goodsIssueEntryData;
            // String employeeId =
            //     checkInfoState.basket.productionEmployee.employeeId;
            itemId = issueState.basket.item!.itemId;
            productionDate = issueState.basket.productionDate.toString();
            itemType = issueState.basket.item!.unit;
            print(issueState.basket);
            if (itemId != selectedItemId) {
              AlertDialogOneBtnCustomized(
                  context,
                  "Cảnh báo",
                  "Bạn đã chọn rổ sai mã sản phẩm",
                  "Trở lại",
                  () {
                    scanQRIssueresult = "-1";
                    Navigator.pushNamed(context, '/qr_scanner_issue_screen');
                  },
                  18,
                  22,
                  () {
                    scanQRIssueresult = "-1";
                    Navigator.pushNamed(context, '/qr_scanner_issue_screen');
                  }).show();
            }
          } else if (issueState is IssueStateListLoadSuccess) {
            goodsIssueEntryDataTemp = issueState.goodsIssueEntryData;
            print(goodsIssueEntryDataTemp);
          } else if (issueState is ConfirmSuccessIssueState) {
            AlertDialogOneBtnCustomized(
                    context, "Thành công", "Đã hoàn thành xuất kho", "Tiếp tục",
                    () {
              BlocProvider.of<IssueBloc>(context).add(ChooseIssueEntryEvent(
                  selectedGoodIssueId, selectedItemId, DateTime.now()));
              Navigator.pushNamed(
                context,
                '/list_container_screen',
              );
            }, 18, 22, () {})
                .show();
          } else if (issueState is ConfirmFailureIssueState) {
            AlertDialogOneBtnCustomized(context, "Thất bại",
                    "Không thể hoàn thành đơn xuất kho", "Trở lại", () {
              // Navigator.pushNamed(context, '///');
            }, 18, 22, () {})
                .show();
          } else if (issueState is IssueStateConfirmLoading) {
            CircularLoading();
          }
        }, builder: (context, checkInfoState) {
          if (checkInfoState is CheckInfoStateLoading) {
            return CircularLoading();
          } else if (checkInfoState is IssueStateConfirmLoading) {
            return CircularLoading();
          } else if (checkInfoState is CheckInfoIssueStateSuccess) {
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
                                    contentPadding: SizeConfig.ratioHeight >= 1
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
                                child: Row(
                                  children: [
                                    TextField(
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
                                    ),
                                    itemType == 1 ?
                                    const Text("kg"): const Text("cái"),
                                  ],
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
                            goodsIssueEntryContainerData.clear();
                            goodsIssueEntryContainerData.add(
                                ContainerIssueExportServer(
                                    selectedGoodIssueId,
                                    itemId,
                                    scanQRIssueresult,
                                    double.parse(quanlity)));
                            print(goodsIssueEntryContainerData);
                            BlocProvider.of<IssueBloc>(context).add(
                                ConFirmExportingContainer(
                                    selectedGoodIssueId,
                                    goodsIssueEntryContainerData,
                                    DateTime.now()));

                            // BlocProvider.of<IssueBloc>(context).add(
                            //     ChooseIssueEntryEvent(selectedGoodIssueId,
                            //         selectedItemId, DateTime.now()));
                            // BlocProvider.of<IssueBloc>(context).add(
                            //     LoadContainerExportEvent(DateTime.now(),
                            //         selectedGoodIssueId, selectedItemId));
                            // Navigator.pushNamed(
                            //   context,
                            //   '/list_container_screen',
                            // );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: ExceptionErrorState(
                height: 300,
                title: "Không tìm thấy dữ liệu rổ",
                message: "Vui lòng kiểm tra lại.",
                imageDirectory: 'lib/assets/sad_face_search.png',
                imageHeight: 140,
              ),
            );
          }
        }));
  }
}
