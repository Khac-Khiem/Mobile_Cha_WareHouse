import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';

String scanQRIssueresult = '-1'; //Scan QR ra

class QRScannerIssueScreen extends StatefulWidget {
  @override
  _QRScannerIssueScreenState createState() => _QRScannerIssueScreenState();
}

class _QRScannerIssueScreenState extends State<QRScannerIssueScreen> {
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
      scanQRIssueresult = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.west_outlined),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Quét mã QR',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        endDrawer: DrawerUser(),
        body: BlocBuilder<IssueBloc, IssueState>(
            builder: (context, checkInfoState) {
          return Container(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        scanQRIssueresult != '-1'
                            ? 'Kết quả : $scanQRIssueresult\n'
                            : 'Vui lòng quét mã QR',
                        style: TextStyle(
                            fontSize: 22 * SizeConfig.ratioFont,
                            color: scanQRIssueresult != '-1'
                                ? Colors.black
                                : Colors.red)),
                    SizedBox(
                      height: 20 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                      onPressed: () {
                        scanQRIssueresult = '-1';
                        scanQR();
                      },
                      text: "Quét mã QR",
                    ),
                    SizedBox(
                      height: 10 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                        // bloc event kiểm tra thông tin rổ xem mã sp rổ có đúng mã sp đơn không?
                        // => nghẽn luồng dữ liệu => dời event này qua trang modify
                        onPressed: () {
                          // AlertDialogTwoBtnCustomized(
                          //         context,
                          //         "Xác Nhận",
                          //         "Bạn đã lấy đúng mã sản phẩm, nhấn xác nhận để tiếp tục",
                          //         "Xác nhận",
                          //         "Trở lại", () async {
                          //   // add basket to confirm
                          //   // listBasketIdConfirm.add(scanQRIssueresult);
                          //   BlocProvider.of<CheckInfoBloc>(context).add(
                          //       CheckInfoEventRequested(
                          //           timeStamp: DateTime.now(),
                          //           basketID: scanQRIssueresult));
                          //   Navigator.pushNamed(
                          //       context, '/confirm_container_screen');
                          // }, () {}, 18, 22)
                          //     .show();

                          // dời thông báo qua trang sau
                          BlocProvider.of<IssueBloc>(context).add(
                              CheckInfoIssueEventRequested(
                                  timeStamp: DateTime.now(),
                                  basketID: scanQRIssueresult));
                          Navigator.pushNamed(
                              context, '/confirm_container_screen');
                        },
                        text: 'Xác Nhận'),
                  ]));
        }));
  }
}
