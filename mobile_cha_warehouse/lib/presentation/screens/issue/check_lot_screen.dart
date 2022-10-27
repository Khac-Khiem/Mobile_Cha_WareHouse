import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import '../../../constant.dart';
import '../../../domain/entities/lots_data.dart';
import '../../../function.dart';
import '../../bloc/blocs/issue_bloc.dart';
import '../../bloc/states/issue_state.dart';

import '../../widget/widget.dart';
import '../inventory/inventory_screen.dart';

//
List<Lots> checkLot = [];
List<String> labelTextCheckList = [
  "Mã lô",
  "Mã sản phẩm:",
  "Lấy hết rổ:",
  "SL thực tế:",
  "Ngày SX:",
];

class CheckLotScreen extends StatefulWidget {
  // final Lots lot;
  const CheckLotScreen();

  @override
  State<CheckLotScreen> createState() => _CheckLotScreenState();
}

class _CheckLotScreenState extends State<CheckLotScreen> {
  String selectedFormat = '';

//  String employeeId = '';
  String itemId = '';

  String quanlity = '';

  String productionDate = "";

  bool isFull = false;

  int itemType = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () async{
            final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go back?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                     Navigator.pushNamed(context, '/list_container_screen');
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
               Navigator.pushNamed(context, '/list_container_screen');
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
          body: BlocBuilder<IssueBloc, IssueState>(
              builder: (context, checkInfoState) {
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
                      child: Row(children: [
                        Column(
                            children: labelTextCheckList
                                .map((text) => LabelText(
                                      text,
                                    ))
                                .toList()),
                        SizedBox(
                          width: 15 * SizeConfig.ratioWidth,
                        ),
                        Column(
                          children: [
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
                                      text: checkLot[0].lotId),
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
                                //color: Colors.grey[200],
                                child: TextField(
                                  enabled: true,
                                  readOnly: true,
                                  controller: TextEditingController(
                                      text: checkLot[0].item!.itemId.toString()),
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
                                      quanlity = checkLot[0].quantity.toString();
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
                                          text: checkLot[0].quantity.toString())
                                      : TextEditingController(
                                          text: quanlity.toString()),
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
                          ],
                        )
                      ]),
                    ),
                    CustomizedButton(
                      text: "Xác nhận",
                      bgColor: Constants.mainColor,
                      fgColor: Colors.white,
                      onPressed: () async {
                        // goodsIssueEntryContainerData.clear();
                        // goodsIssueEntryContainerData.add(
                        //     ContainerIssueExportServer(
                        //         selectedGoodIssueId,
                        //         itemId,
                        //         scanQRIssueresult,
                        //         double.parse(quanlity)));
                        // print(goodsIssueEntryContainerData);
                        BlocProvider.of<IssueBloc>(context).add(
                            AddLotFromSuggestToExpected(
                                DateTime.now(), Lots(checkLot[0].lotId, checkLot[0].cell, int.parse(quanlity), checkLot[0].date, checkLot[0].item)));
            
                        Navigator.pushNamed(
                          context,
                          '/list_container_screen',
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }
}
