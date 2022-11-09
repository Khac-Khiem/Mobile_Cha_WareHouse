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

  String actual = '';

  String lotId = '';

  String selectedShift = '';

  String unitUpdate = '';

  double ratioQuantity = 1;

  String unit = '', shelfId = '', rowId = '', columnId = '';

  String itemId2 = '';

  String itemName2 = '';

  String actual2 = '';

  String lotId2 = '';

  String unitUpdate2 = '';

  double ratioQuantity2 = 1;

  String unit2 = '', shelfId2 = '', rowId2 = '', columnId2 = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
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
              bottom: TabBar(
                //  unselectedLabelColor: Colors.blueGrey,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Constants.secondaryColor,
                ),
                tabs: [
                  const Tab(text: "Nhập SX"),
                  const Tab(text: "Nhập ngoài"),
                ],
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
                  return TabBarView(children: [
                    SingleChildScrollView(
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
                                            vertical:
                                                5 * SizeConfig.ratioHeight),
                                        alignment: Alignment.centerRight,
                                        width: 200 * SizeConfig.ratioWidth,
                                        height: 55 * SizeConfig.ratioHeight,
                                        //color: Colors.grey[200],
                                        child: TextField(
                                          enabled: true,
                                          //  readOnly: true,
                                          onChanged: (value) => {lotId = value},
                                          controller: TextEditingController(
                                              text: lotId),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize:
                                                  20 * SizeConfig.ratioFont),
                                          decoration: InputDecoration(
                                            // filled: true,
                                            // fillColor: Colors.grey[300],
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10 *
                                                        SizeConfig.ratioHeight),

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
                                    Container(
                                      width: 200 * SizeConfig.ratioWidth,
                                      height: 50 * SizeConfig.ratioHeight,
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        // borderRadius: const BorderRadius.all(
                                        //     const Radius.circular(10))
                                      ),
                                      child: DropdownSearch(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                contentPadding:
                                                    // SizeConfig
                                                    //             .ratioHeight >=
                                                    //         1
                                                    //     ? EdgeInsets.fromLTRB(
                                                    //         50 *
                                                    //             SizeConfig
                                                    //                 .ratioWidth,
                                                    //         14 *
                                                    //             SizeConfig
                                                    //                 .ratioHeight,
                                                    //         3 *
                                                    //             SizeConfig
                                                    //                 .ratioWidth,
                                                    //         3 *
                                                    //             SizeConfig
                                                    //                 .ratioHeight)
                                                    //     :
                                                    const EdgeInsets.fromLTRB(
                                                        45,
                                                        7,
                                                        3,
                                                        3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                                                hintText: "Chọn mã",
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
                                                ratioQuantity = double.parse(
                                                    element.piecesPerKilogram
                                                        .toString());
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
                                      width: 200 * SizeConfig.ratioWidth,
                                      height: 50 * SizeConfig.ratioHeight,
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        // borderRadius: const BorderRadius.all(
                                        //     const Radius.circular(10))
                                      ),
                                      child: DropdownSearch(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                contentPadding: SizeConfig
                                                            .ratioHeight >=
                                                        1
                                                    ? EdgeInsets.fromLTRB(
                                                        50 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        14 *
                                                            SizeConfig
                                                                .ratioHeight,
                                                        3 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        3 *
                                                            SizeConfig
                                                                .ratioHeight)
                                                    : const EdgeInsets.fromLTRB(
                                                        45,
                                                        7,
                                                        3,
                                                        3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                                                hintText: "Tên sản phẩm",
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
                                                ratioQuantity = double.parse(
                                                    element.piecesPerKilogram
                                                        .toString());
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
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                5 * SizeConfig.ratioHeight),
                                        alignment: Alignment.centerRight,
                                        width: 200 * SizeConfig.ratioWidth,
                                        height: 55 * SizeConfig.ratioHeight,
                                        //color: Colors.grey[200],
                                        child: TextField(
                                          enabled: true,
                                          //  readOnly: true,
                                          controller: TextEditingController(
                                              text: DateFormat('yyyy-MM-dd')
                                                  .format(DateTime.now()
                                                      .subtract(const Duration(
                                                          days: 1)))),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize:
                                                  20 * SizeConfig.ratioFont),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10 *
                                                        SizeConfig.ratioHeight),
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
                                    Container(
                                        width: 200 * SizeConfig.ratioWidth,
                                        height: 50 * SizeConfig.ratioHeight,
                                        padding: const EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Constants.mainColor),
                                          // borderRadius: const BorderRadius.all(
                                          //     const Radius.circular(10))
                                        ),
                                        child: DropdownSearch(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                                    contentPadding: SizeConfig
                                                                .ratioHeight >=
                                                            1
                                                        ? EdgeInsets.fromLTRB(
                                                            50 *
                                                                SizeConfig
                                                                    .ratioWidth,
                                                            14 *
                                                                SizeConfig
                                                                    .ratioHeight,
                                                            3 *
                                                                SizeConfig
                                                                    .ratioWidth,
                                                            3 *
                                                                SizeConfig
                                                                    .ratioHeight)
                                                        : const EdgeInsets.fromLTRB(
                                                            45,
                                                            7,
                                                            3,
                                                            3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                                                    hintText: "",
                                                    hintStyle: TextStyle(
                                                        fontSize: 16 *
                                                            SizeConfig
                                                                .ratioFont),
                                                    border:
                                                        const UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                    fillColor: Colors.blue),
                                            showAsSuffixIcons: true,
                                            popupTitle: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Text(
                                                "Chọn ca sản xuất?",
                                                style: TextStyle(
                                                    fontSize: 22 *
                                                        SizeConfig.ratioFont),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            popupBackgroundColor:
                                                Colors.grey[200],
                                            popupShape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            items: ["1", "2"],
                                            selectedItem: selectedShift,
                                            onChanged: (String? data) {
                                              setState(() {
                                                lotId = "$itemId - " +
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(DateTime.now()
                                                            .subtract(
                                                                const Duration(
                                                                    days: 1))) +
                                                    " - $data";
                                              });
                                            })),
                                    Container(
                                        width: 200 * SizeConfig.ratioWidth,
                                        height: 50 * SizeConfig.ratioHeight,
                                        padding: const EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Constants.mainColor),
                                          // borderRadius: const BorderRadius.all(
                                          //     const Radius.circular(10))
                                        ),
                                        child: DropdownSearch(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                                    contentPadding: SizeConfig
                                                                .ratioHeight >=
                                                            1
                                                        ? EdgeInsets.fromLTRB(
                                                            50 *
                                                                SizeConfig
                                                                    .ratioWidth,
                                                            14 *
                                                                SizeConfig
                                                                    .ratioHeight,
                                                            3 *
                                                                SizeConfig
                                                                    .ratioWidth,
                                                            3 *
                                                                SizeConfig
                                                                    .ratioHeight)
                                                        : const EdgeInsets.fromLTRB(
                                                            45,
                                                            7,
                                                            3,
                                                            3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                                                    hintText: "",
                                                    hintStyle: TextStyle(
                                                        fontSize: 16 *
                                                            SizeConfig
                                                                .ratioFont),
                                                    border:
                                                        const UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                    fillColor: Colors.blue),
                                            showAsSuffixIcons: true,
                                            popupTitle: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Text(
                                                "Chọn đơn vị tính?",
                                                style: TextStyle(
                                                    fontSize: 22 *
                                                        SizeConfig.ratioFont),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            popupBackgroundColor:
                                                Colors.grey[200],
                                            popupShape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            items: ["cái", "kg"],
                                            selectedItem: unitUpdate,
                                            onChanged: (String? data) {
                                              unitUpdate = data.toString();
                                              if (data != unit &&
                                                  unit == "cái") {
                                              } else if (data != unit &&
                                                  unit == "kg") {
                                                ratioQuantity =
                                                    1 / ratioQuantity;
                                              }
                                            })),
                                    // Container(
                                    //     padding: EdgeInsets.symmetric(
                                    //         vertical:
                                    //             5 * SizeConfig.ratioHeight),
                                    //     alignment: Alignment.centerRight,
                                    //     width: 200 * SizeConfig.ratioWidth,
                                    //     height: 55 * SizeConfig.ratioHeight,
                                    //     //color: Colors.grey[200],
                                    //     child: TextField(
                                    //       enabled: true,
                                    //       // onChanged: (value) => {actual = value},
                                    //       readOnly: true,
                                    //       controller:
                                    //           TextEditingController(text: unit),
                                    //       textAlignVertical:
                                    //           TextAlignVertical.center,
                                    //       textAlign: TextAlign.center,
                                    //       style: TextStyle(
                                    //           fontSize:
                                    //               20 * SizeConfig.ratioFont),
                                    //       decoration: InputDecoration(
                                    //         contentPadding:
                                    //             EdgeInsets.symmetric(
                                    //                 horizontal: 10 *
                                    //                     SizeConfig.ratioHeight),
                                    //         border: OutlineInputBorder(
                                    //             borderSide: BorderSide(
                                    //                 width: 1.0 *
                                    //                     SizeConfig.ratioWidth,
                                    //                 color: Colors.black)),
                                    //         focusedBorder: OutlineInputBorder(
                                    //             borderSide: BorderSide(
                                    //                 width: 1.0 *
                                    //                     SizeConfig.ratioWidth,
                                    //                 color: Colors.black)),
                                    //       ),
                                    //     )),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                5 * SizeConfig.ratioHeight),
                                        alignment: Alignment.centerRight,
                                        width: 200 * SizeConfig.ratioWidth,
                                        height: 55 * SizeConfig.ratioHeight,
                                        //color: Colors.grey[200],
                                        child: TextField(
                                          enabled: true,
                                          onChanged: (value) =>
                                              {actual = value},
                                          //    readOnly: true,
                                          controller: TextEditingController(),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize:
                                                  20 * SizeConfig.ratioFont),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10 *
                                                        SizeConfig.ratioHeight),
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
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    5 * SizeConfig.ratioHeight),
                                            alignment: Alignment.centerRight,
                                            width: 60 * SizeConfig.ratioWidth,
                                            height: 55 * SizeConfig.ratioHeight,
                                            //color: Colors.grey[200],
                                            child: TextField(
                                              enabled: true,
                                              //  readOnly: true,
                                              onChanged: (value) =>
                                                  {shelfId = value},

                                              controller:
                                                  TextEditingController(),
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20 *
                                                      SizeConfig.ratioFont),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10 *
                                                            SizeConfig
                                                                .ratioHeight),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        color: Colors.black)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        color: Colors.black)),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 9,
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    5 * SizeConfig.ratioHeight),
                                            alignment: Alignment.centerRight,
                                            width: 60 * SizeConfig.ratioWidth,
                                            height: 55 * SizeConfig.ratioHeight,
                                            //color: Colors.grey[200],
                                            child: TextField(
                                              enabled: true,
                                              //  readOnly: true,
                                              onChanged: (value) =>
                                                  {rowId = value},
                                              controller: TextEditingController(
                                                  text: ''),
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20 *
                                                      SizeConfig.ratioFont),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10 *
                                                            SizeConfig
                                                                .ratioHeight),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        color: Colors.black)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        color: Colors.black)),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 9,
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    5 * SizeConfig.ratioHeight),
                                            alignment: Alignment.centerRight,
                                            width: 60 * SizeConfig.ratioWidth,
                                            height: 55 * SizeConfig.ratioHeight,
                                            //color: Colors.grey[200],
                                            child: TextField(
                                              enabled: true,
                                              //  readOnly: true,
                                              onChanged: (value) =>
                                                  {columnId = value},
                                              controller: TextEditingController(
                                                  text: ''),
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20 *
                                                      SizeConfig.ratioFont),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10 *
                                                            SizeConfig
                                                                .ratioHeight),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        color: Colors.black)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        color: Colors.black)),
                                              ),
                                            )),
                                      ],
                                    ),
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
                                        lotId != '') {
                                      // thêm rổ vừa điền thông tin vào danh sách

                                      goodsReceiptEntryConainerDataTemp.add(
                                        GoodsReceiptEntryContainerData(
                                            lotId,
                                            itemId,
                                            double.parse(actual) *
                                                ratioQuantity,
                                            DateFormat('yyyy-MM-dd')
                                                .format(DateTime.now().subtract(
                                                    const Duration(days: 1)))
                                                .toString(),
                                            LocationServer(
                                                shelfId,
                                                int.parse(rowId),
                                                int.parse(columnId))),
                                      );

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
                    ),
                    SingleChildScrollView(
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
                                      children: labelTextList2
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
                                            vertical:
                                                5 * SizeConfig.ratioHeight),
                                        alignment: Alignment.centerRight,
                                        width: 200 * SizeConfig.ratioWidth,
                                        height: 55 * SizeConfig.ratioHeight,
                                        //color: Colors.grey[200],
                                        child: TextField(
                                          enabled: true,
                                          //  readOnly: true,
                                          onChanged: (value) =>
                                              {lotId2 = value},
                                          controller: TextEditingController(
                                              text: lotId2),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize:
                                                  20 * SizeConfig.ratioFont),
                                          decoration: InputDecoration(
                                            // filled: true,
                                            // fillColor: Colors.grey[300],
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10 *
                                                        SizeConfig.ratioHeight),

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
                                    Container(
                                      width: 200 * SizeConfig.ratioWidth,
                                      height: 50 * SizeConfig.ratioHeight,
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        // borderRadius: const BorderRadius.all(
                                        //     const Radius.circular(10))
                                      ),
                                      child: DropdownSearch(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                contentPadding: SizeConfig
                                                            .ratioHeight >=
                                                        1
                                                    ? EdgeInsets.fromLTRB(
                                                        50 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        14 *
                                                            SizeConfig
                                                                .ratioHeight,
                                                        3 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        3 *
                                                            SizeConfig
                                                                .ratioHeight)
                                                    : const EdgeInsets.fromLTRB(
                                                        45,
                                                        7,
                                                        3,
                                                        3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                                                hintText: "Chọn mã",
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
                                            "Chọn mã sản phẩm",
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
                                        items: listitemId,
                                        selectedItem: itemId2,
                                        //searchBoxDecoration: InputDecoration(),
                                        onChanged: (String? data) {
                                          itemId2 = data.toString();
                                          setState(() {
                                            lotId2 = "$itemId2 - " +
                                                DateFormat('yyyy-MM-dd').format(
                                                    DateTime.now().subtract(
                                                        const Duration(
                                                            days: 1)));
                                            for (var element in listItem) {
                                              if (element.itemId == itemId2) {
                                                ratioQuantity2 = double.parse(
                                                    element.piecesPerKilogram
                                                        .toString());
                                                itemName2 = element.name;
                                                if (element.unit == 1) {
                                                  unit2 = "kg";
                                                } else {
                                                  unit2 = "cái";
                                                }
                                                unitUpdate2 = unit2;
                                              }
                                            }
                                          });
                                        },
                                        showSearchBox: true,
                                        //  autoFocusSearchBox: true,
                                      ),
                                    ),
                                    Container(
                                      width: 200 * SizeConfig.ratioWidth,
                                      height: 50 * SizeConfig.ratioHeight,
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        // borderRadius: const BorderRadius.all(
                                        //     const Radius.circular(10))
                                      ),
                                      child: DropdownSearch(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                                contentPadding: SizeConfig
                                                            .ratioHeight >=
                                                        1
                                                    ? EdgeInsets.fromLTRB(
                                                        50 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        14 *
                                                            SizeConfig
                                                                .ratioHeight,
                                                        3 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        3 *
                                                            SizeConfig
                                                                .ratioHeight)
                                                    : const EdgeInsets.fromLTRB(
                                                        45,
                                                        7,
                                                        3,
                                                        3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                                                hintText: "Mã sản phẩm",
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
                                            "Chọn tên sản phẩm",
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
                                        items: listItemName,
                                        selectedItem: itemName2,
                                        //searchBoxDecoration: InputDecoration(),
                                        onChanged: (String? data) {
                                          itemName2 = data.toString();
                                          setState(() {
                                            for (var element in listItem) {
                                              if (element.itemId == itemId2) {
                                                itemId2 = element.itemId;
                                                ratioQuantity2 = double.parse(
                                                    element.piecesPerKilogram
                                                        .toString());
                                                lotId2 = "$itemId2 - " +
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(DateTime.now()
                                                            .subtract(
                                                                const Duration(
                                                                    days: 1)));
                                                if (element.unit == 1) {
                                                  unit2 = "kg";
                                                } else {
                                                  unit2 = "cái";
                                                }
                                                unitUpdate2 = unit2;
                                              }
                                            }
                                          });
                                        },
                                        showSearchBox: true,
                                        //  autoFocusSearchBox: true,
                                      ),
                                    ),
                                    Container(
                                        width: 200 * SizeConfig.ratioWidth,
                                        height: 50 * SizeConfig.ratioHeight,
                                        padding: const EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Constants.mainColor),
                                          // borderRadius: const BorderRadius.all(
                                          //     const Radius.circular(10))
                                        ),
                                        child: DropdownSearch(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                                    contentPadding: SizeConfig
                                                                .ratioHeight >=
                                                            1
                                                        ? EdgeInsets.fromLTRB(
                                                            50 *
                                                                SizeConfig
                                                                    .ratioWidth,
                                                            14 *
                                                                SizeConfig
                                                                    .ratioHeight,
                                                            3 *
                                                                SizeConfig
                                                                    .ratioWidth,
                                                            3 *
                                                                SizeConfig
                                                                    .ratioHeight)
                                                        : const EdgeInsets.fromLTRB(
                                                            45,
                                                            7,
                                                            3,
                                                            3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                                                    hintText: "",
                                                    hintStyle: TextStyle(
                                                        fontSize: 16 *
                                                            SizeConfig
                                                                .ratioFont),
                                                    border:
                                                        const UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                    fillColor: Colors.blue),
                                            showAsSuffixIcons: true,
                                            popupTitle: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Text(
                                                "Chọn đơn vị tính?",
                                                style: TextStyle(
                                                    fontSize: 22 *
                                                        SizeConfig.ratioFont),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            popupBackgroundColor:
                                                Colors.grey[200],
                                            popupShape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            items: ["cái", "kg"],
                                            selectedItem: unitUpdate2,
                                            onChanged: (String? data) {
                                              unitUpdate2 = data.toString();
                                              if (data != unit2 &&
                                                  unit2 == "cái") {
                                              } else if (data != unit2 &&
                                                  unit2 == "kg") {
                                                ratioQuantity2 =
                                                    1 / ratioQuantity2;
                                              }
                                            })),
                                    // Container(
                                    //     padding: EdgeInsets.symmetric(
                                    //         vertical:
                                    //             5 * SizeConfig.ratioHeight),
                                    //     alignment: Alignment.centerRight,
                                    //     width: 200 * SizeConfig.ratioWidth,
                                    //     height: 55 * SizeConfig.ratioHeight,
                                    //     //color: Colors.grey[200],
                                    //     child: TextField(
                                    //       enabled: true,
                                    //       // onChanged: (value) => {actual = value},
                                    //       readOnly: true,
                                    //       controller: TextEditingController(
                                    //           text: unit2),
                                    //       textAlignVertical:
                                    //           TextAlignVertical.center,
                                    //       textAlign: TextAlign.center,
                                    //       style: TextStyle(
                                    //           fontSize:
                                    //               20 * SizeConfig.ratioFont),
                                    //       decoration: InputDecoration(
                                    //         contentPadding:
                                    //             EdgeInsets.symmetric(
                                    //                 horizontal: 10 *
                                    //                     SizeConfig.ratioHeight),
                                    //         border: OutlineInputBorder(
                                    //             borderSide: BorderSide(
                                    //                 width: 1.0 *
                                    //                     SizeConfig.ratioWidth,
                                    //                 color: Colors.black)),
                                    //         focusedBorder: OutlineInputBorder(
                                    //             borderSide: BorderSide(
                                    //                 width: 1.0 *
                                    //                     SizeConfig.ratioWidth,
                                    //                 color: Colors.black)),
                                    //       ),
                                    //     )),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                5 * SizeConfig.ratioHeight),
                                        alignment: Alignment.centerRight,
                                        width: 200 * SizeConfig.ratioWidth,
                                        height: 55 * SizeConfig.ratioHeight,
                                        //color: Colors.grey[200],
                                        child: TextField(
                                          enabled: true,
                                          onChanged: (value) =>
                                              {actual2 = value},
                                          //    readOnly: true,
                                          controller: TextEditingController(),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize:
                                                  20 * SizeConfig.ratioFont),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10 *
                                                        SizeConfig.ratioHeight),
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
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                5 * SizeConfig.ratioHeight),
                                        alignment: Alignment.centerRight,
                                        width: 200 * SizeConfig.ratioWidth,
                                        height: 55 * SizeConfig.ratioHeight,
                                        //color: Colors.grey[200],
                                        child: TextField(
                                          enabled: true,
                                          //  readOnly: true,
                                          controller: TextEditingController(
                                              text: DateFormat('yyyy-MM-dd')
                                                  .format(DateTime.now()
                                                      .subtract(const Duration(
                                                          days: 1)))),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize:
                                                  20 * SizeConfig.ratioFont),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10 *
                                                        SizeConfig.ratioHeight),
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
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    5 * SizeConfig.ratioHeight),
                                            alignment: Alignment.centerRight,
                                            width: 60 * SizeConfig.ratioWidth,
                                            height: 55 * SizeConfig.ratioHeight,
                                            //color: Colors.grey[200],
                                            child: TextField(
                                              enabled: true,
                                              //  readOnly: true,
                                              onChanged: (value) =>
                                                  {shelfId2 = value},

                                              controller:
                                                  TextEditingController(),
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20 *
                                                      SizeConfig.ratioFont),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10 *
                                                            SizeConfig
                                                                .ratioHeight),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        color: Colors.black)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        color: Colors.black)),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 9,
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    5 * SizeConfig.ratioHeight),
                                            alignment: Alignment.centerRight,
                                            width: 60 * SizeConfig.ratioWidth,
                                            height: 55 * SizeConfig.ratioHeight,
                                            //color: Colors.grey[200],
                                            child: TextField(
                                              enabled: true,
                                              //  readOnly: true,
                                              onChanged: (value) =>
                                                  {rowId2 = value},
                                              controller: TextEditingController(
                                                  text: ''),
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20 *
                                                      SizeConfig.ratioFont),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10 *
                                                            SizeConfig
                                                                .ratioHeight),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        color: Colors.black)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        color: Colors.black)),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 9,
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    5 * SizeConfig.ratioHeight),
                                            alignment: Alignment.centerRight,
                                            width: 60 * SizeConfig.ratioWidth,
                                            height: 55 * SizeConfig.ratioHeight,
                                            //color: Colors.grey[200],
                                            child: TextField(
                                              enabled: true,
                                              //  readOnly: true,
                                              onChanged: (value) =>
                                                  {columnId2 = value},
                                              controller: TextEditingController(
                                                  text: ''),
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20 *
                                                      SizeConfig.ratioFont),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10 *
                                                            SizeConfig
                                                                .ratioHeight),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        color: Colors.black)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        color: Colors.black)),
                                              ),
                                            )),
                                      ],
                                    ),
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
                                    if (actual2 != '' &&
                                        itemId2 != '' &&
                                        lotId2 != '') {
                                      // thêm lô vừa điền thông tin vào danh sách

                                      goodsReceiptEntryConainerDataTemp.add(
                                        GoodsReceiptEntryContainerData(
                                            lotId2,
                                            itemId2,
                                            double.parse(actual2)*ratioQuantity2,
                                            DateFormat('yyyy-MM-dd')
                                                .format(DateTime.now().subtract(
                                                    const Duration(days: 1)))
                                                .toString(),
                                            LocationServer(
                                                shelfId2,
                                                int.parse(rowId2),
                                                int.parse(columnId2))),
                                      );
                                      print(goodsReceiptEntryConainerDataTemp);
                                      Navigator.pushNamed(
                                          context, '/receipt_screen');
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
                    ),
                  ]);
                }
              },
            )),
      ),
    );
  }
}
