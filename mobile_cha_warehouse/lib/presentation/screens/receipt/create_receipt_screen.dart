import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/datasource/models/goods_receipts_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/inventory/inventory_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/confirm_location_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/update_info_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

String receiptId = '';
// danh sach ma don da nhap => nguoi dung tham khao khi dat ten
List<String> receipts = [];

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key? key}) : super(key: key);
  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
 
  TextEditingController controller = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
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
                    Navigator.pushNamed(context, '///');
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
           
            leading: IconButton(
              icon: const Icon(
                Icons.west, //mũi tên back
                color: Colors.white,
              ),
              onPressed: () {
               
                    Navigator.pushNamed(context, '///');
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
                      context, "Thất bại", receiptState.error, "Nhập lại", () {
                //Navigator.pushNamed(context, '///');
                // Navigator.pushNamed(context, '///');
              }, 18, 22, () {})
                  .show();
            } else if (receiptState is LoadReceiptExportingStateSuccess) {
              receipts.clear();
              for (var element in receiptState.receipts) {
                receipts.add(element.goodsReceiptId);
              }
              
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
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                        children: [
                          LabelText("Mã đơn"),
                          // SizedBox(
                          //   width: 5 * SizeConfig.ratioWidth,
                          // ),
                           SizedBox(
                              width: 180 * SizeConfig.ratioWidth,
                              height: 55 * SizeConfig.ratioHeight,
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
                                ),
                           ),
                          Container(
                             
                              alignment: Alignment.centerRight,
                              width: 55 * SizeConfig.ratioWidth,
                              height: 55 * SizeConfig.ratioHeight,
                              // color: Colors.grey[200],
                              child: 
                              DropdownSearch(
                                  // dropdownSearchDecoration: 
                                  // InputDecoration(
                                  //  //  labelText: "Mã sản phẩm",
                                  //     labelStyle: TextStyle(
                                  //       color: Colors.grey[700],
                                  //       fontSize: 25 * SizeConfig.ratioFont,
                                  //     ),
                                      
                                  //     hintText: "Mã đơn",
                                  //     hintStyle: TextStyle(
                                  //         fontSize:
                                  //             16 * SizeConfig.ratioFont),
                                  //     border: const UnderlineInputBorder(
                                  //         borderSide: BorderSide.none),
                                  //     fillColor: Colors.blue),
                                  showAsSuffixIcons: true,
                                 
                                  popupBackgroundColor: Colors.grey[200],
                                  popupShape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  items: receipts,
                    
                                  //selectedItem: receiptId,
                                  //searchBoxDecoration: InputDecoration(),
                                  onChanged: (String? data) {
                                   // receiptId = data.toString();
                                  
                                  },
                                 // showSearchBox: true,
                                  //  autoFocusSearchBox: true,
                                ),
                             
                              ),
                          
                         
                        ],
                      ),
                      const Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Constants.mainColor,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: onSearchTextChanged,
                          controller: controller,
                          decoration: const InputDecoration(
                              labelText: "Search",
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)))),
                        ),
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
                                  child: SizedBox(
                                    height: 300 * SizeConfig.ratioHeight,
                                    child: _searchResult.length != 0 ||
                                            controller.text.isNotEmpty
                                        ? ListView.builder(
                                            padding: const EdgeInsets.all(8),
                                            itemCount: _searchResult.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: SizedBox(
                                                  width:
                                                      380 * SizeConfig.ratioWidth,
                                                  height: 100 *
                                                      SizeConfig.ratioHeight,
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
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                            width: 380 *
                                                                SizeConfig
                                                                    .ratioWidth,
                                                            child: Text(
                                                              _searchResult[index]
                                                                  .lotId,
                                                              style: TextStyle(
                                                                  fontSize: 18 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Constants
                                                                      .mainColor),
                                                              textAlign:
                                                                  TextAlign.left,
                                                            )),
                                                        const Divider(
                                                          indent: 30,
                                                          endIndent: 30,
                                                          color:
                                                              Constants.mainColor,
                                                          thickness: 1,
                                                        ),
                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "Mã sản phẩm: " +
                                                                  _searchResult[
                                                                          index]
                                                                      .itemId,
                                                              style: TextStyle(
                                                                  fontSize: 16 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Constants
                                                                      .mainColor),
                                                              textAlign:
                                                                  TextAlign.left),
                                                        ),
                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "SL: " +
                                                                  _searchResult[
                                                                          index]
                                                                      .actualQuantity
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 16 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Constants
                                                                      .mainColor),
                                                              textAlign:
                                                                  TextAlign.left),
                                                        ),
                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "KL: " +
                                                                  _searchResult[
                                                                          index]
                                                                      .actualMass
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 16 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Constants
                                                                      .mainColor),
                                                              textAlign:
                                                                  TextAlign.left),
                                                        ),
                                                        // SizedBox(
                                                        //   width: 380 *
                                                        //       SizeConfig
                                                        //           .ratioWidth,
                                                        //   child: _searchResult[index].location.shelfId == "1"
                                                        //       ? Text(
                                                        //           "Vị trí: Chưa cập nhật ",
                                                        //           style: TextStyle(
                                                        //               fontSize: 16 *
                                                        //                   SizeConfig
                                                        //                       .ratioFont,
                                                        //               fontWeight:
                                                        //                   FontWeight
                                                        //                       .bold,
                                                        //               color: Constants
                                                        //                   .mainColor),
                                                        //           textAlign:
                                                        //               TextAlign
                                                        //                   .left)
                                                        //       : Text(
                                                        //           "Vị trí: " +
                                                        //               _searchResult[index]
                                                        //                   .location
                                                        //                   .shelfId +
                                                        //               _searchResult[index]
                                                        //                   .location
                                                        //                   .rowId
                                                        //                   .toString() +
                                                        //               _searchResult[index]
                                                        //                   .location
                                                        //                   .id
                                                        //                   .toString()
                                                        //                   .toString(),
                                                        //           style: TextStyle(fontSize: 16 * SizeConfig.ratioFont, fontWeight: FontWeight.bold, color: Constants.mainColor),
                                                        //           textAlign: TextAlign.left),
                                                        // ),
                                                      ],
                                                    ),
                                                    onPressed: (() {
                                                      // BlocProvider.of<ReceiptBloc>(
                                                    
                                                    }),
                                                    onLongPress: () async {
                                                      AlertDialogTwoBtnCustomized(
                                                              context,
                                                              'Bạn có chắc?',
                                                              'Chọn Cập nhật hoặc Xóa lô để tiếp tục',
                                                              'Cập nhật',
                                                              'Xóa lô', () async {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  UpdateInfoScreen(
                                                                      goodsReceiptEntryConainerDataTemp[
                                                                              index]
                                                                          .itemId,
                                                                      goodsReceiptEntryConainerDataTemp[
                                                                          index])),
                                                        );
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
                                            })
                                        : ListView.builder(
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
                                                  height: 100 *
                                                      SizeConfig.ratioHeight,
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
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                            width: 380 *
                                                                SizeConfig
                                                                    .ratioWidth,
                                                            child: Text(
                                                              goodsReceiptEntryConainerDataTemp[
                                                                      index]
                                                                  .lotId,
                                                              style: TextStyle(
                                                                  fontSize: 18 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Constants
                                                                      .mainColor),
                                                              textAlign:
                                                                  TextAlign.left,
                                                            )),
                                                        const Divider(
                                                          indent: 30,
                                                          endIndent: 30,
                                                          color:
                                                              Constants.mainColor,
                                                          thickness: 1,
                                                        ),
                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "Mã sản phẩm: " +
                                                                  goodsReceiptEntryConainerDataTemp[index]
                                                                      .itemId,
                                                              style: TextStyle(
                                                                  fontSize: 16 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Constants
                                                                      .mainColor),
                                                              textAlign:
                                                                  TextAlign.left),
                                                        ),
                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "SL: " +
                                                                  goodsReceiptEntryConainerDataTemp[index]
                                                                      .actualQuantity
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 16 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Constants
                                                                      .mainColor),
                                                              textAlign:
                                                                  TextAlign.left),
                                                        ),
                                                     SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "KL: " +
                                                                  goodsReceiptEntryConainerDataTemp[index]
                                                                      .actualMass
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 16 *
                                                                      SizeConfig
                                                                          .ratioFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Constants
                                                                      .mainColor),
                                                              textAlign:
                                                                  TextAlign.left),
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: (() {
                                                    
                                                    }),
                                                    onLongPress: () async {
                                                      AlertDialogTwoBtnCustomized(
                                                              context,
                                                              'Bạn có chắc?',
                                                              'Chọn Cập nhật hoặc Xóa lô để tiếp tục',
                                                              'Cập nhật',
                                                              'Xóa lô', () async {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  UpdateInfoScreen(
                                                                      goodsReceiptEntryConainerDataTemp[
                                                                              index]
                                                                          .itemId,
                                                                      goodsReceiptEntryConainerDataTemp[
                                                                          index])),
                                                        );
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
                            // BlocProvider.of<ReceiptBloc>(context)
                            //     .add(LoadAllDataEvent(DateTime.now()));
    
                            Navigator.pushNamed(context, '/modify_info_screen');
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
                              if (receiptId == '') {
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
                                    .show();
                              } else {
                                
                                  AlertDialogTwoBtnCustomized(
                                          context,
                                          'Xác nhận',
                                          'Bạn đã hoàn thành tạo đơn nhập kho?',
                                          'Xác nhận',
                                          'Trở lại', () {
                                    //bloc event cập nhật vị trí rổ
                                    BlocProvider.of<ReceiptBloc>(context).add(
                                        PostNewReceiptEvent(
                                            goodsReceiptEntryConainerDataTemp,
                                            DateTime.now(),
                                            receiptId));
                                    // khi xác nhận hoàn thành đơn dữ liệu phải được đẩy lên server
                                  }, () {}, 18, 22)
                                      .show();
                                
                              }
                            }
                          })
                    ],
                  )
                ],
              ),
            );
          })),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    goodsReceiptEntryConainerDataTemp.forEach((userDetail) {
      if (userDetail.itemId.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }

  List<GoodsReceiptEntryContainerData> _searchResult = [];
}
