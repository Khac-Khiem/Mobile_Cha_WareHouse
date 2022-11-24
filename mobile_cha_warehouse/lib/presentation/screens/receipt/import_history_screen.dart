import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/domain/entities/stock_card.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/injector.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/stockcard_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/stockcard_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/stockcard_state.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../bloc/blocs/receipt_bloc.dart';
import '../../dialog/dialog.dart';

class ImportHistoryScreen extends StatelessWidget {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
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
          endDrawer: DrawerUser(),
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
              'Lịch sử nhập kho',
              style: TextStyle(fontSize: 22), //chuẩn
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
                width: 380 * SizeConfig.ratioWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15 * SizeConfig.ratioHeight,
                            ),
                            TextTitle(title: "Từ ngày"),
                            SizedBox(
                              height: 27 * SizeConfig.ratioHeight,
                            ),
                            TextTitle(title: "Đến ngày"),
                            SizedBox(
                              height: 27 * SizeConfig.ratioHeight,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 30 * SizeConfig.ratioWidth,
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 180 * SizeConfig.ratioWidth,
                                height: 45 * SizeConfig.ratioHeight,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Constants.mainColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: CustomizeDatePicker(
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  initDateTime: _startDate,
                                  okBtnClickedFunction: (pickedTime) {
                                    _startDate = pickedTime;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10 * SizeConfig.ratioHeight,
                              ),
                              //Date picker end date
                              Container(
                                width: 180 * SizeConfig.ratioWidth,
                                height: 45 * SizeConfig.ratioHeight,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Constants.mainColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: CustomizeDatePicker(
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  initDateTime: DateTime.now(),
                                  okBtnClickedFunction: (pickedTime) {
                                    _endDate = pickedTime;
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Constants.mainColor,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 380 * SizeConfig.ratioHeight,
                      child: BlocBuilder<ReceiptBloc, ReceiptState>(
                          builder: (context, state) {
                        if (state is ReceiptLoadingState) {
                          return Container(
                              width: 380 * SizeConfig.ratioWidth,
                              height: 280 * SizeConfig.ratioHeight,
                              alignment: Alignment.center,
                              child: CircularLoading());
                        } else if (state is HistoryStateLoadSuccess) {
                          GoodsReceiptData receiptData = state.lots;
                          // TextStyle _textContentInTable =
                          //     TextStyle(fontSize: 14 * SizeConfig.ratioFont);
                          TextStyle _textHeaderInTable = TextStyle(
                              fontSize: 15 * SizeConfig.ratioFont,
                              color: Colors.white);
                          return SizedBox(
                            height: 380 * SizeConfig.ratioHeight,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Container(
                                        color: Constants.mainColor,
                                        width: 310 * SizeConfig.ratioWidth,
                                        height: 50 * SizeConfig.ratioHeight,
                                        // ignore: deprecated_member_use
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width:
                                                    80 * SizeConfig.ratioWidth,
                                                child: Text(
                                                  "Ngày nhập",
                                                  style: _textHeaderInTable,
                                                  textAlign: TextAlign.center,
                                                )),
                                            SizedBox(
                                                width:
                                                    55 * SizeConfig.ratioWidth,
                                                child: Text(
                                                  "Mã đơn",
                                                  style: _textHeaderInTable,
                                                  textAlign: TextAlign.center,
                                                )),
                                            SizedBox(
                                                width:
                                                    55 * SizeConfig.ratioWidth,
                                                child: Text(
                                                  "Mã nv",
                                                  style: _textHeaderInTable,
                                                  textAlign: TextAlign.center,
                                                )),
                                          ],
                                        )),
                                  ),
                                  Column(
                                    children: receiptData.items
                                        .map((item) => ReceiptRow(
                                              item,
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (state is HistoryStateLoadFailed) {
                          return const Text('fail');
                        } else {
                          return Center(
                            child: ExceptionErrorState(
                              title: "Vui lòng chọn khoảng thời gian",
                              message: "",
                              distanceTextImage: 20,
                              imageHeight: 120,
                              imageDirectory: 'lib/assets/touch.png',
                            ),
                          );
                        }
                      }),
                    ),
                    SizedBox(
                      height: 15 * SizeConfig.ratioHeight,
                    ),
                    BlocBuilder<ReceiptBloc, ReceiptState>(
                        builder: (context, state) => CustomizedButton(
                            text: "Truy xuất",
                            onPressed: () {
                              BlocProvider.of<ReceiptBloc>(context).add(
                                  LoadReceiptHistoryEvent(
                                      DateTime.now(), _startDate, _endDate));
                            }))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class TextTitle extends StatelessWidget {
  String title;
  TextTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 20 * SizeConfig.ratioFont, fontWeight: FontWeight.bold),
    );
  }
}

class ReceiptRow extends StatelessWidget {
  GoodsReceipt receipt;
  ReceiptRow(this.receipt);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: 310 * SizeConfig.ratioWidth,
          height: 50 * SizeConfig.ratioHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 100 * SizeConfig.ratioWidth,
                  child: Text(
                    //stockCardEntry.date,
                    DateFormat("yyyy-MM-dd")
                        .parse(receipt.timestamp)
                        .toString(),
                    style: TextStyle(fontSize: 15 * SizeConfig.ratioFont),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                  width: 100 * SizeConfig.ratioWidth,
                  child: Text(
                    receipt.goodsReceiptId,
                    style: TextStyle(fontSize: 15 * SizeConfig.ratioFont),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                  width: 100 * SizeConfig.ratioWidth,
                  child: Text(
                    receipt.employee!.employeeId,
                    style: TextStyle(fontSize: 15 * SizeConfig.ratioFont),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HistoryReceiptDetail(receipt)),
        );
      },
    );
  }
}

class HistoryReceiptDetail extends StatelessWidget {
  GoodsReceipt receipt;
  HistoryReceiptDetail(this.receipt);

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
                    Navigator.pushNamed(context, '/history_screen');
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
          endDrawer: DrawerUser(),
          appBar: AppBar(
            backgroundColor: Constants.mainColor,
            title: Text(
              'Quản lý kho',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextTitle(title: "Ngày nhập :"),
                      TextTitle(title: "Mã đơn :"),
                      TextTitle(title: "Nhân viên ID :"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 100 * SizeConfig.ratioWidth,
                          child: Text(
                            DateFormat("yyyy-MM-dd").format(
                                DateFormat("yyyy-MM-dd")
                                    .parse(receipt.timestamp)),
                            style:
                                TextStyle(fontSize: 20 * SizeConfig.ratioFont),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                          width: 100 * SizeConfig.ratioWidth,
                          child: Text(
                            receipt.goodsReceiptId,
                            style:
                                TextStyle(fontSize: 20 * SizeConfig.ratioFont),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                          width: 100 * SizeConfig.ratioWidth,
                          child: Text(
                            receipt.employee!.employeeId,
                            style:
                                TextStyle(fontSize: 20 * SizeConfig.ratioFont),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  )
                ],
              ),
              TextTitle(title: "Danh sách lô hàng"),
              SizedBox(
                height: 300 * SizeConfig.ratioHeight,
                child: ListView.builder(
                    itemCount: receipt.lots.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          width: 380 * SizeConfig.ratioWidth,
                          height: 100 * SizeConfig.ratioHeight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey[300],
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 350 * SizeConfig.ratioWidth,
                                    child: Text(
                                      receipt.lots[index].lotId,
                                      style: TextStyle(
                                          fontSize: 18 * SizeConfig.ratioFont,
                                          fontWeight: FontWeight.bold,
                                          color: Constants.mainColor),
                                      textAlign: TextAlign.left,
                                    )),
                                const Divider(
                                  indent: 30,
                                  endIndent: 30,
                                  color: Constants.mainColor,
                                  thickness: 1,
                                ),
                                SizedBox(
                                  width: 350 * SizeConfig.ratioWidth,
                                  child: Text(
                                      "Mã sản phẩm: " +
                                          receipt.lots[index].item!.itemId,
                                      style: TextStyle(
                                          fontSize: 16 * SizeConfig.ratioFont,
                                          fontWeight: FontWeight.bold,
                                          color: Constants.mainColor),
                                      textAlign: TextAlign.left),
                                ),
                                SizedBox(
                                  width: 350 * SizeConfig.ratioWidth,
                                  child: Text(
                                      "SL/KL: " +
                                          receipt.lots[index].quantity
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 16 * SizeConfig.ratioFont,
                                          fontWeight: FontWeight.bold,
                                          color: Constants.mainColor),
                                      textAlign: TextAlign.left),
                                ),
                              ],
                            ),
                            onPressed: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateQuantityLotReceiptScreen(
                                            receipt.lots[index],
                                            receipt.goodsReceiptId)),
                              );
                            }),
                          ),
                        ),
                      );
                    }),
              )
            ],
          )),
    );
  }
}

class UpdateQuantityLotReceiptScreen extends StatelessWidget {
  LotReceipt lotReceipt;
  String receiptId;
  String quantity = '';
  UpdateQuantityLotReceiptScreen(this.lotReceipt, this.receiptId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReceiptBloc>(
      create: (context) => injector(),
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
                      Navigator.pop(context, true);
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
          endDrawer: DrawerUser(),
          appBar: AppBar(
            backgroundColor: Constants.mainColor,
            title: Text(
              'Quản lý kho',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
            ),
          ),
          body: BlocConsumer<ReceiptBloc, ReceiptState>(
            listener: (context, state) {
              if (state is ReceiptLoadingState) {
                CircularLoading();
              } else if (state is UpdateQuantitySuccess) {
                AlertDialogOneBtnCustomized(
                    context,
                    "Thành công",
                    "Đã cập nhập lịch sử",
                    "Trở lại",
                    () {
                      goodsReceiptEntryConainerDataTemp.clear();
                      Navigator.pushNamed(context, '/history_screen');
                    },
                    18,
                    22,
                    () {
                      Navigator.pushNamed(context, '/history_screen');
                    }).show();
              } else if (state is UpdateQuantityFail) {
                AlertDialogOneBtnCustomized(
                    context,
                    "Thất bại",
                    "Không thể cập nhập lịch sử",
                    "Trở lại",
                    () {
                      goodsReceiptEntryConainerDataTemp.clear();
                      Navigator.pushNamed(context, '/history_screen');
                    },
                    18,
                    22,
                    () {
                      Navigator.pushNamed(context, '/history_screen');
                    }).show();
              }
            },
            builder: (context, state) {
              if (state is ReceiptLoadingState) {
                return CircularLoading();
              } else {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * SizeConfig.ratioHeight),
                            alignment: Alignment.centerRight,
                            width: 350 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,

                              readOnly: true,
                              //   onChanged: (value) => {actual = value},
                              controller:
                                  TextEditingController(text: lotReceipt.lotId),
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
                            width: 350 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,

                              readOnly: true,
                              //   onChanged: (value) => {actual = value},
                              controller: TextEditingController(
                                  text: lotReceipt.item!.itemId),
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20 * SizeConfig.ratioFont),
                              decoration: InputDecoration(
                                labelText: "Mã sản phẩm",
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
                            width: 350 * SizeConfig.ratioWidth,
                            height: 55 * SizeConfig.ratioHeight,
                            //color: Colors.grey[200],
                            child: TextField(
                              enabled: true,

                              //  readOnly: true,
                              onChanged: (value) => {quantity = value},
                              controller: TextEditingController(text: quantity),
                              textAlignVertical: TextAlignVertical.center,
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
                        CustomizedButton(
                            text: "Xác nhận",
                            onPressed: () {
                              quantity != ""
                                  ? BlocProvider.of<ReceiptBloc>(context).add(
                                      UpdateQuantityReceiptEvent(
                                          lotReceipt.lotId,
                                          quantity,
                                          receiptId,
                                          DateTime.now()))
                                  : () {};
                            })
                      ]),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
