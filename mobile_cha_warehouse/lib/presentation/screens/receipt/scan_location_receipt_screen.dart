import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/scan_container_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../../constant.dart';
import '../../bloc/states/receipt_state.dart';

String scanQRLocationresult = '-1'; //Scan QR ra

//bb210505141725631
class QRScannerLocationScreen extends StatefulWidget {
  //final String containerId;
  const QRScannerLocationScreen({
    Key? key,
  }) : super(key: key);
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerLocationScreen> {
  Future<void> scanQRLocation() async {
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
      scanQRLocationresult = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.west_outlined),
              onPressed: () {
                if (scanQRLocationresult != "-1") {
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
                  Navigator.pushNamed(context, '///');
                }
              }),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Quét mã QR vị trí',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        endDrawer: DrawerUser(),
        body:
            BlocConsumer<ReceiptBloc, ReceiptState>(listener: (context, state) {
          if (state is UpdateLocationReceiptStateFailure) {
            print('fail nè');
            AlertDialogOneBtnCustomized(
                    context,
                    "Thất bại",
                    "Error",
                    "Trở lại", () {
              // Navigator.pushNamed(context, '///');
            }, 18, 22, () {})
                .show();}
           else if (state is UpdateLocationReceiptStateSuccess) {
              print('success nè');
              AlertDialogOneBtnCustomized(
                      context,
                      "Thành công",
                      "Đã cập nhật vị trí thành công",
                      "Tiếp tụcqa", () {
                         Navigator.pushNamed(
                                    context, '/scan_container_screen');
             //   Navigator.pushNamed(context, '/scan_container_screen');
              }, 18, 22, () {})
                  .show();
            }
          
        }, builder: (context, state) {
          return Container(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        scanQRLocationresult != '-1'
                            ? 'Kết quả : $scanQRLocationresult\n'
                            : 'Vui lòng quét mã vị trí',
                        style: TextStyle(
                            fontSize: 22 * SizeConfig.ratioFont,
                            color: scanQRLocationresult != '-1'
                                ? Colors.black
                                : Colors.red)),
                    SizedBox(
                      height: 20 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                      onPressed: () {
                        scanQRLocationresult = '1';
                        scanQRLocation();
                      },
                      text: "Quét mã QR",
                    ),
                    SizedBox(
                      height: 10 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                        onPressed: scanQRLocationresult == '-1'
                            ? () {
                                AlertDialogTwoBtnCustomized(
                                        context,
                                        'Bạn có chắc',
                                        'Chưa có vị trí được quét?',
                                        'Quét lại',
                                        'Trở lại',
                                        () {}, () {
                                  Navigator.pushNamed(context, '///');
                                }, 18, 22)
                                    .show();
                              }
                            : () {
                                AlertDialogTwoBtnCustomized(
                                        context,
                                        'Bạn có chắc',
                                        'Rổ vừa được đặt tại vị trí ' +
                                            scanQRLocationresult +
                                            "?",
                                        'Xác nhận',
                                        'Trở lại', () async {
                                  // bloc event update location
                                  BlocProvider.of<ReceiptBloc>(context).add(
                                      UpdateLocationReceiptEvent(
                                          containerid,
                                          scanQRLocationresult[0],
                                          int.parse(scanQRLocationresult[1]),
                                          int.parse(scanQRLocationresult[2])));
                                 
                                  // Navigator.pushNamed(
                                  //     context, '/receipt_screen');
                                }, () {}, 18, 22)
                                    .show();
                              },
                        text: 'Xác nhận')
                  ]));
        }));
  }
}
