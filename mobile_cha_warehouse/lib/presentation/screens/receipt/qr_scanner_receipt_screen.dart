import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';

String scanQRReceiptresult = '-1'; //Scan QR ra

//bb210505141725631
class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#e60000', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      scanQRReceiptresult = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.west_outlined),
              onPressed: () {
                if (scanQRReceiptresult != "-1") {
                  AlertDialogTwoBtnCustomized(
                          context,
                          'Bạn có chắc',
                          'Khi nhấn trở lại, mọi dữ liệu sẽ không được lưu',
                          'Trở lại',
                          'Tiếp tục', () {
                    Navigator.pushNamed(context, '///');
                  }, () {}, 18, 22)
                      .show();
                } else {
                  Navigator.of(context).pop();
                }
              }),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Quét mã QR',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        endDrawer: DrawerUser(),
        body: Builder(builder: (BuildContext context) {
          return Container(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        scanQRReceiptresult != '-1'
                            ? 'Kết quả : $scanQRReceiptresult\n'
                            : 'Vui lòng quét mã QR',
                        style: TextStyle(
                            fontSize: 22 * SizeConfig.ratioFont,
                            color: scanQRReceiptresult != '-1'
                                ? Colors.black
                                : Colors.red)),
                    SizedBox(
                      height: 20 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                      onPressed: () {
                        scanQRReceiptresult = '-1';
                        scanQR();
                      },
                      text: "Quét mã QR",
                    ),
                    SizedBox(
                      height: 10 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                        onPressed: scanQRReceiptresult == '-1'
                            ? () {
                                AlertDialogTwoBtnCustomized(
                                        context,
                                        'Bạn có chắc',
                                        'Chưa có rổ được quét? Ấn tiếp tục để quét lại',
                                        'Tiếp tục',
                                        'Trở lại',
                                        () async {}, () {
                                  Navigator.pushNamed(
                                      context, '/receipt_screen');
                                }, 18, 22)
                                    .show();
                              }
                            : () async {
                                for (int i = 0;
                                    i <
                                        goodsReceiptEntryConainerDataTemp
                                            .length;
                                    i++) {
                                  if (goodsReceiptEntryConainerDataTemp[i]
                                          .containerId ==
                                      scanQRReceiptresult) {
                                    AlertDialogTwoBtnCustomized(
                                            context,
                                            'Bạn có chắc',
                                            'Rổ này đã được quét? Chọn tiếp tục để xóa rổ và nhập lại',
                                            'Tiếp tục',
                                            'Trở lại', () async {
                                      scanQRReceiptresult =
                                          goodsReceiptEntryConainerDataTemp[i]
                                              .containerId;
                                      goodsReceiptEntryConainerDataTemp
                                          .removeAt(i);
                                      Navigator.pushNamed(
                                          context, '/modify_info_screen');
                                    }, () {
                                      Navigator.pushNamed(
                                          context, '/receipt_screen');
                                    }, 18, 22)
                                        .show();
                                  } else {
                                    // kiểm tra rổ
                                    BlocProvider.of<ReceiptBloc>(context).add(
                                        CheckContainerAvailableEvent(scanQRReceiptresult, DateTime.now()));
                                    Navigator.pushNamed(
                                        context, '/modify_info_screen');
                                  }
                                }
                                if (goodsReceiptEntryConainerDataTemp.isEmpty) {
                                  // kiểm tra rổ
                                  BlocProvider.of<ReceiptBloc>(context)
                                      .add(CheckContainerAvailableEvent(scanQRReceiptresult, DateTime.now()));
                                  Navigator.pushNamed(
                                      context, '/modify_info_screen');
                                }
                                // BlocProvider.of<ReceiptBloc>(context)
                                //     .add(LoadAllDataEvent());
                              },
                        text: 'Xác nhận')
                  ]));
        }));
  }
}
