import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';

import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/scan_location_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';

class ScanContainerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<ScanContainerScreen> {
  // lưu Id rổ để cập nhật vị trí
  String containerId = '';
  String scanContainerReceiptresult = "-1";
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
      scanContainerReceiptresult = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.west_outlined),
              onPressed: () {
                if (scanContainerReceiptresult != "-1") {
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
                        scanContainerReceiptresult != '-1'
                            ? 'Kết quả : $scanContainerReceiptresult\n'
                            : 'Vui lòng quét mã QR',
                        style: TextStyle(
                            fontSize: 22 * SizeConfig.ratioFont,
                            color: scanContainerReceiptresult != '-1'
                                ? Colors.black
                                : Colors.red)),
                    SizedBox(
                      height: 20 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                      onPressed: () {
                        scanContainerReceiptresult = '1';
                        scanQR();
                      },
                      text: "Quét mã QR",
                    ),
                    SizedBox(
                      height: 10 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                        onPressed: scanContainerReceiptresult == '-1'
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
                            : () {
                                for (var element
                                    in goodsReceiptEntryConainerDataTemp) {
                                  if (element.containerId ==
                                      scanContainerReceiptresult) {
                                    // containerId = scanContainerReceiptresult;
                                    // Navigator.pushNamed(
                                    //     context, '/qr_location_screen');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            QRScannerLocationScreen(
                                                containerId: containerId),
                                      ),
                                    );
                                  } else {
                                    AlertDialogTwoBtnCustomized(
                                            context,
                                            'Bạn có chắc',
                                            'Rổ này chưa được nhập thông tin? Ấn tiếp tục để tiến hành điền thông tin',
                                            'Tiếp tục',
                                            'Trở lại', () async {
                                      Navigator.pushNamed(
                                          context, '/receipt_screen');
                                    }, () {}, 18, 22)
                                        .show();
                                  }
                                }
                              },
                        text: 'Xác nhận')
                  ]));
        }));
  }
}
