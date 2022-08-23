import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/check_info_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/edit_per_basket_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/edit_per_basket_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/check_info_state.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/edit_per_basket_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/text_input_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';
import '../../../function.dart';

class InventoryScreen extends StatelessWidget {
  String containerId = '';
  String itemId = '';
  //String employeeId = '';
  String note = '';
  double before = 0;
  String after = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/qr_inventory_screen');
              },
              icon: const Icon(
                Icons.west,
                color: Colors.white,
              )),
          backgroundColor: Color(0xff001D37),
          title: Text('Kiểm kê',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont)),
        ),
        endDrawer: DrawerUser(),
        body: BlocConsumer<EditPerBasketBloc, EditPerBasketState>(
           listener: (context, checkInfoState) {
            if(checkInfoState is EditPerBasketStateUploadSuccess){
                AlertDialogOneBtnCustomized(context, "Thành công",
                        "Rổ đã được báo cáo", "Trở lại", () {
                  
                  Navigator.pushNamed(context, '///');
                }, 18, 22, () {})
                    .show();
            }
           },
            builder: (context, checkInfoState) {
          if (checkInfoState is EditPerBasketStateUploadLoading) {
            return CircularLoading();
          } else if (checkInfoState is CheckInfoInventoryStateFailure) {
            //lỗi
            return Center(
              child: Column(
                children: [
                  ExceptionErrorState(
                    height: 300,
                    title: "Không tìm thấy dữ liệu",
                    message:
                        "Rổ này có thể \nđã được lấy ra khỏi kho, \nvui lòng kiểm tra lại.",
                    imageDirectory: 'lib/assets/sad_commander.png',
                    imageHeight: 100,
                  ),
                  CustomizedButton(
                    text: "Quét lại",
                    bgColor: Constants.mainColor,
                    fgColor: Colors.white,
                    onPressed: () async {
                      Navigator.pushNamed(context, '/qr_inventory_screen');
                    },
                  ),
                ],
              ),
            );
          }
          //state này là CheckInfoStateSuccess
          else {
            //dùng if nhưng mục đích là để ép kiểu, do không dùng as để ép được
            if (checkInfoState is CheckInfoInventoryStateSuccess) {
              containerId = checkInfoState.basket.containerId;
            //  employeeId = checkInfoState.basket.item.;
              itemId = checkInfoState.basket.item!.itemId;
              before = double.parse(checkInfoState.basket.quantity.toString());
              // location = checkInfoState.basket.location!.shelfId.toString() +
              //     checkInfoState.basket.location!.rowId.toString() +
              //     checkInfoState.basket.location!.id.toString();
            }
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
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
                            TextInput(containerId),
                            TextInput(itemId),
                           // TextInput(employeeId),
                           // TextInput(location),
                            TextInput(before.toString()),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5 * SizeConfig.ratioHeight),
                                alignment: Alignment.centerRight,
                                width: 200 * SizeConfig.ratioWidth,
                                height: 55 * SizeConfig.ratioHeight,
                                //color: Colors.grey[200],
                                child: TextField(
                                  enabled: true,
                                  onChanged: (value) =>
                                      {after = value},
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
                                  onChanged: (value) =>
                                      {note = value},
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
                            // gửi thông tin lên server chờ xác nhận
                            // bloc event
                             BlocProvider.of<EditPerBasketBloc>(context)
                      .add(EditPerBasketEventEditClick(containerId, note, int.parse(after), DateTime.now()));
                            // nên hiển thị loading đến khi gửi request thành công
                            // Navigator.pushNamed(
                            //     context, '/qr_inventory_screen');
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        }));
  }
}

List<String> labelTextList = [
  "Mã Rổ:",
  "Mã Sản phẩm:",
 // "Mã Nhân viên:",
 // "Vị trí:",
  "Sl/KL cũ:",
  "Sl/KL mới:",
  "Ghi chú:"
];

class LabelText extends StatelessWidget {
  String text;
  LabelText(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * SizeConfig.ratioHeight),
      alignment: Alignment.centerRight,

      width: 120 * SizeConfig.ratioWidth,
      height: 55 * SizeConfig.ratioHeight,
      //color: Colors.amber,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18 * SizeConfig.ratioFont, fontWeight: FontWeight.bold),
      ),
    );
  }
}
