import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/confirm_location_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/update_info_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../router/app_router.dart';

class ListUnlocatedScreen extends StatefulWidget {
  const ListUnlocatedScreen({Key? key}) : super(key: key);
  @override
  State<ListUnlocatedScreen> createState() => _ReceiptUnlocatedScreenState();
}

class _ReceiptUnlocatedScreenState extends State<ListUnlocatedScreen> {
  TextEditingController controller = TextEditingController();

  List<UnlocatedLotReceipt> receipts = [];

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
            if (receiptState is LoadUnlocatedLotSuccess) {
              receipts = receiptState.receipts;
            }
          }, builder: (context, receiptState) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
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
                        if (receiptState is LoadUnlocatedLotSuccess) {
                          return receiptState.receipts.isEmpty
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
                                    height: 470 * SizeConfig.ratioHeight,
                                    child: _searchResult.length != 0 ||
                                            controller.text.isNotEmpty
                                        ? ListView.builder(
                                            padding: const EdgeInsets.all(8),
                                            itemCount: _searchResult.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: SizedBox(
                                                  width: 380 *
                                                      SizeConfig.ratioWidth,
                                                  height: 140 *
                                                      SizeConfig.ratioHeight,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.grey[300],
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
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
                                                              _searchResult[
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
                                                                  TextAlign
                                                                      .left,
                                                            )),
                                                        const Divider(
                                                          indent: 30,
                                                          endIndent: 30,
                                                          color: Constants
                                                              .mainColor,
                                                          thickness: 1,
                                                        ),

                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "Mã SP: " +
                                                                  _searchResult[index]
                                                                      .item!
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
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "Tên SP: " +
                                                                  _searchResult[index]
                                                                      .item!
                                                                      .name,
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
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "SL: " +
                                                                  _searchResult[index]
                                                                      .quantity
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
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                            
                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child:    _searchResult[index].item!.hasManyUnits == true ?

                                                          Text(
                                                              "KL: " +
                                                                  (_searchResult[index]
                                                                              .quantity *
                                                                          _searchResult[index]
                                                                              .item!
                                                                              .piecesPerKilogram)
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
                                                                  TextAlign
                                                                      .left):Text(
                                                              "KL: không xác định" 
                                                                ,
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
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: (() {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ConfirmLocationScreen(
                                                                    _searchResult[
                                                                        index])),
                                                      );
                                                      // Navigator.pushNamed(
                                                      //   context,
                                                      //   '/confirm_location_screen',
                                                      //   arguments:
                                                      //       ScreenArguments(
                                                      //          _searchResult[
                                                      //                   index]
                                                      //     ,
                                                      //   ),
                                                      // );
                                                    }),
                                                  ),
                                                ),
                                              );
                                            })
                                        : ListView.builder(
                                            padding: const EdgeInsets.all(8),
                                            itemCount:
                                                receiptState.receipts.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: SizedBox(
                                                  width: 380 *
                                                      SizeConfig.ratioWidth,
                                                  height: 140 *
                                                      SizeConfig.ratioHeight,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.grey[300],
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
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
                                                              receiptState
                                                                  .receipts[
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
                                                                  TextAlign
                                                                      .left,
                                                            )),
                                                        const Divider(
                                                          indent: 30,
                                                          endIndent: 30,
                                                          color: Constants
                                                              .mainColor,
                                                          thickness: 1,
                                                        ),
                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "Mã SP: " +
                                                                  receiptState
                                                                      .receipts[
                                                                          index]
                                                                      .item!
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
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "Tên SP: " +
                                                                  receiptState
                                                                      .receipts[
                                                                          index]
                                                                      .item!
                                                                      .name,
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
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                              "SL: " +
                                                                  receiptState
                                                                      .receipts[
                                                                          index]
                                                                      .quantity
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
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                                        SizedBox(
                                                          width: 380 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: receiptState.receipts[index].item!.hasManyUnits == true?
                                                          Text(
                                                              "KL: " +
                                                                  (receiptState
                                                                              .receipts[
                                                                                  index]
                                                                              .quantity *
                                                                          receiptState
                                                                              .receipts[
                                                                                  index]
                                                                              .item!
                                                                              .piecesPerKilogram)
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
                                                                  TextAlign
                                                                      .left): Text(
                                                              "KL: không xác định" 
                                                                  ,
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
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: (() {
                                                      //                         BlocProvider.of<ReceiptBloc>(context)
                                                      // .add(LoadAllDataEvent(DateTime.now()));
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ConfirmLocationScreen(
                                                                    receiptState
                                                                            .receipts[
                                                                        index])),
                                                      );
                                                      //  Navigator.pushNamed(
                                                      //   context,
                                                      //   '/confirm_location_screen',
                                                      //   arguments:
                                                      //       ScreenArguments(
                                                      //          receiptState.receipts[
                                                      //                   index]
                                                      //     ,
                                                      //   ),
                                                      // );
                                                    }),
                                                  ),
                                                ),
                                              );
                                            }),
                                  ));
                        } else {
                          return Center(
                            child: CircularLoading(),
                          );
                        }
                      }),
                    ],
                  ),
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

    receipts.forEach((userDetail) {
      if (userDetail.lotId.contains(text) ||
          userDetail.goodsReceiptId.contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }

  List<UnlocatedLotReceipt> _searchResult = [];
}
