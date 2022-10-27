import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/inventory/inventory_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/qr_scanner_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

String receiptId = '';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key? key}) : super(key: key);
  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  DateTime selectedDate = DateTime.now();

  List<ContainerData> containers = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              // bottom: TabBar(
              //   //  unselectedLabelColor: Colors.blueGrey,
              //   indicator: BoxDecoration(
              //     borderRadius: BorderRadius.circular(50),
              //     color: Constants.secondaryColor,
              //   ),
              //   tabs: [
              //     const Tab(text: "Tạo đơn"),
              //     const Tab(text: "Cập nhật vị trí"),
              //   ],
              // ),

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
                listener: (context, receiptState) {
              if (receiptState is PostReceiptStateSuccess) {
                receiptId = '';
                AlertDialogOneBtnCustomized(context, "Thành công",
                        "Đã hoàn thành tạo đơn nhập kho", "Trở lại", () {
                  goodsReceiptEntryConainerDataTemp.clear();
                  Navigator.pushNamed(context, '///');
                }, 18, 22, () {})
                    .show();
              } else if (receiptState is ReceiptLoadingState) {
                CircularLoading();
              } else if (receiptState is PostReceiptStateFailure) {
                AlertDialogOneBtnCustomized(
                        context, "Thất bại", receiptState.error, "Nhập lại",
                        () {
                  Navigator.pushNamed(context, '/receipt_screen');
                  // Navigator.pushNamed(context, '///');
                }, 18, 22, () {})
                    .show();
              } else if (receiptState is LoadContainerExportingStateSuccess) {
                containers = receiptState.containers;
              }
            }, builder: (context, receiptState) {
              //  if (receiptState is ReceiptInitialState) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          // mainAxisAlignment:
                          //     MainAxisAlignment.spaceAround,
                          children: [
                            LabelText("Mã đơn"),
                            SizedBox(
                              width: 40 * SizeConfig.ratioWidth,
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5 * SizeConfig.ratioHeight),
                                alignment: Alignment.centerRight,
                                width: 180 * SizeConfig.ratioWidth,
                                height: 55 * SizeConfig.ratioHeight,
                                // color: Colors.grey[200],
                                child: TextField(
                                  enabled: true,
                                  //  readOnly: true,
                                  onChanged: (value) => {receiptId = value},

                                  controller:
                                      TextEditingController(text: receiptId),
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
                          ],
                        ),
                        const Divider(
                          indent: 30,
                          endIndent: 30,
                          color: Constants.mainColor,
                          thickness: 1,
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
                                  "Mã Lô",
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
                        Builder(builder: (BuildContext context) {
                          if (receiptState is ReceiptLoadingState) {
                            return Center(child: CircularLoading());
                          } else {
                            return goodsReceiptEntryConainerDataTemp.isEmpty
                                ? ExceptionErrorState(
                                    height: 300,
                                    title: "Chưa có lô được nhập",
                                    message: "Tiến hành nhập kho",
                                    imageDirectory:
                                        'lib/assets/sad_face_search.png',
                                    imageHeight: 140,
                                  )
                                : SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child:
                                        // Column(
                                        //   children:
                                        //       goodsReceiptEntryConainerDataTemp
                                        //           .map((item) =>
                                        //               RowContainer(item))
                                        //           .toList(),
                                        // ),
                                        SizedBox(
                                      height: 300 * SizeConfig.ratioHeight,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(8),
                                          itemCount:
                                              goodsReceiptEntryConainerDataTemp
                                                  .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: SizedBox(
                                                width:
                                                    380 * SizeConfig.ratioWidth,
                                                height:
                                                    80 * SizeConfig.ratioHeight,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.grey[300],
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8))),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                          width: 100 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                            goodsReceiptEntryConainerDataTemp[
                                                                    index]
                                                                .lotId,
                                                            style: TextStyle(
                                                                fontSize: 21 *
                                                                    SizeConfig
                                                                        .ratioFont,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Constants
                                                                    .mainColor),
                                                            textAlign: TextAlign
                                                                .center,
                                                          )),
                                                      SizedBox(
                                                        width: 100 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        child: Text(
                                                            goodsReceiptEntryConainerDataTemp[index]
                                                                .itemId,
                                                            style: TextStyle(
                                                                fontSize: 21 *
                                                                    SizeConfig
                                                                        .ratioFont,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Constants
                                                                    .mainColor),
                                                            textAlign: TextAlign
                                                                .center),
                                                      ),
                                                      SizedBox(
                                                        width: 90 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        child: Text(
                                                            goodsReceiptEntryConainerDataTemp[index]
                                                                .actualQuantity
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 21 *
                                                                    SizeConfig
                                                                        .ratioFont,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Constants
                                                                    .mainColor),
                                                            textAlign: TextAlign
                                                                .center),
                                                      ),
                                                      // chuyển từ icon sang onLongPress
                                                      // IconButton(
                                                      //     onPressed: () {
                                                      //       AlertDialogTwoBtnCustomized(
                                                      //               context,
                                                      //               'Bạn có chắc?',
                                                      //               'Chọn Cập nhật hoặc Xóa lô để tiếp tục',
                                                      //               'Cập nhật',
                                                      //               'Xóa lô', () {
                                                      //         // xóa thông tin rổ đó và điền lại rổ đó
                                                      //         scanQRReceiptresult =
                                                      //             goodsReceiptEntryConainerDataTemp[
                                                      //                     index]
                                                      //                 .lotId;
                                                      //         goodsReceiptEntryConainerDataTemp
                                                      //             .removeAt(
                                                      //                 index);
                                                      //         Navigator.pushNamed(
                                                      //             context,
                                                      //             '/modify_info_screen');
                                                      //       }, () {
                                                      //         //bloc event xóa rổ
                                                      //         goodsReceiptEntryConainerDataTemp
                                                      //             .removeAt(
                                                      //                 index);
                                                      //         BlocProvider.of<
                                                      //                     ReceiptBloc>(
                                                      //                 context)
                                                      //             .add(RefershReceiptEvent(
                                                      //                 DateTime
                                                      //                     .now()));
                                                      //       }, 18, 22)
                                                      //           .show();
                                                      //     },
                                                      //     icon: const Icon(Icons
                                                      //         .mode_edit_rounded))
                                                    ],
                                                  ),
                                                  onPressed: (() {}),
                                                  onLongPress: () async {
                                                    AlertDialogTwoBtnCustomized(
                                                            context,
                                                            'Bạn có chắc?',
                                                            'Chọn Cập nhật hoặc Xóa lô để tiếp tục',
                                                            'Cập nhật',
                                                            'Xóa lô', () {
                                                      // xóa thông tin rổ đó và điền lại rổ đó
                                                      // scanQRReceiptresult =
                                                      //     goodsReceiptEntryConainerDataTemp[
                                                      //             index]
                                                      //         .lotId;
                                                      goodsReceiptEntryConainerDataTemp
                                                          .removeAt(index);
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/modify_info_screen');
                                                    }, () {
                                                      //bloc event xóa rổ
                                                      goodsReceiptEntryConainerDataTemp
                                                          .removeAt(index);
                                                      BlocProvider.of<
                                                                  ReceiptBloc>(
                                                              context)
                                                          .add(
                                                              RefershReceiptEvent(
                                                                  DateTime
                                                                      .now()));
                                                    }, 18, 22)
                                                        .show();
                                                  },
                                                ),
                                              ),
                                            );
                                          }),
                                    ));
                          }
                        }),
                      ],
                    ),
                    Column(
                      children: [
                        CustomizedButton(
                            text: 'Nhập Kho',
                            onPressed: () async {
                              // phase 1
                              // BlocProvider.of<ReceiptBloc>(context)
                              //     .add(LoadAllDataEvent());
                              // scanQRReceiptresult = "-1";
                              // Navigator.pushNamed(
                              //     context, '/qr_scanner_screen');

                              // phase 2
                              BlocProvider.of<ReceiptBloc>(context)
                                  .add(LoadAllDataEvent(DateTime.now()));

                              Navigator.pushNamed(
                                  context, '/modify_info_screen');
                            }),
                        CustomizedButton(
                            text: 'Hoàn Thành',
                            onPressed: () {
                              if (goodsReceiptEntryConainerDataTemp.isEmpty) {
                                AlertDialogOneBtnCustomized(
                                        context,
                                        "Cảnh báo",
                                        "Chưa có lô nào trong đơn",
                                        "Trở lại",
                                        () {},
                                        18,
                                        22,
                                        () {})
                                    .show();
                              } else {
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
                                        //bloc event cập nhật vị trí rổ
                                        BlocProvider.of<ReceiptBloc>(context)
                                            .add(PostNewReceiptEvent(
                                                goodsReceiptEntryConainerDataTemp,
                                                DateTime.now(),
                                                receiptId));
                                        // khi xác nhận hoàn thành đơn dữ liệu phải được đẩy lên server
                                      }, () {}, 18, 22)
                                        .show();
                              }
                            })
                      ],
                    )
                  ],
                ),
              );
            })));
  }
}

// class RowContainerLocation extends StatelessWidget {
//   ContainerData locationContainer;
//   RowContainerLocation(this.locationContainer);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: SizedBox(
//         width: 380 * SizeConfig.ratioWidth,
//         height: 80 * SizeConfig.ratioHeight,
//         child: GestureDetector(
//           // ignore: deprecated_member_use
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Colors.grey[300],
//               shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(8))),
//               padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),

//               // primary: bgColor,
//               // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//             ),
//             // padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: 160 * SizeConfig.ratioWidth,
//                   child: Text(locationContainer.containerId,
//                       style: TextStyle(
//                           fontSize: 21 * SizeConfig.ratioFont,
//                           fontWeight: FontWeight.bold,
//                           color: Constants.mainColor),
//                       textAlign: TextAlign.center),
//                 ),
//                 SizedBox(
//                   width: 160 * SizeConfig.ratioWidth,
//                   child: Text('',
//                       style: TextStyle(
//                           fontSize: 21 * SizeConfig.ratioFont,
//                           fontWeight: FontWeight.bold,
//                           color: Constants.mainColor),
//                       textAlign: TextAlign.center),
//                 ),
//               ],
//             ),
//             onPressed: () async {
//               //     Navigator.pushNamed(context, '/qr_scanner_screen');
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
