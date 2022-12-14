import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/edit_per_basket_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/login_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/stockcard_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/edit_per_basket_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/stockcard_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/login_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/qr_issue_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/main_app_name.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';
import '../../bloc/events/issue_event.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          AlertDialogTwoBtnCustomized(context, 'Bạn có chắc?',
                  'Đăng xuất khỏi hệ thống', 'Đăng xuất', 'Trở lại', () {
            logout(context);
          }, () {
            Navigator.pushNamed(context, '///');
          }, 18, 22)
              .show();
          // AlertDialogTwoBtnCustomized(
          //     context: context,
          //     title: "Bạn có chắc?",
          //     desc: "Đăng xuất khỏi hệ thống.",
          //     bgBtn1: Colors.white,
          //     fgBtn1: Constants.mainColor,
          //     textBtn1: "Đăng xuất",
          //     textBtn2: "Trở lại",
          //     onPressedBtn1: () {
          //       logout(context);
          //     }).show();
          return true;
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
          body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            if (state is LoginStateLoginSuccessful) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MainAppName(),
                    SizedBox(
                      height: 50 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                      text: "Nhập kho",
                      onPressed: () async {
                        BlocProvider.of<ReceiptBloc>(context)
                              .add(LoadAllDataEvent(DateTime.now()));
                        Navigator.pushNamed(context, '/receipt_main_screen');

                        //scanQRresult = "bb210611150004035";
                      },
                    ),
                    SizedBox(
                      height: 4 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                      text: "Xuất kho",
                      onPressed: () async {
                        scanQRIssueresult = "-1";

                        // load tất cả các đơn xuất hiện có

                        BlocProvider.of<IssueBloc>(context)
                            .add(LoadIssueEvent(DateTime.now(), "2021-03-01"));
                        Navigator.pushNamed(context, '/issue_screen');
                      },
                    ),
                    SizedBox(
                      height: 4 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                      text: "Thẻ kho",
                      onPressed: () async {
                        BlocProvider.of<StockCardViewBloc>(context).add(
                            StockCardViewEventLoadAllProductID(DateTime.now()));
                        Navigator.pushNamed(context, '/stockcard_screen');
                      },
                    ),
                    SizedBox(
                      height: 4 * SizeConfig.ratioHeight,
                    ),
                    CustomizedButton(
                      text: "Kiểm kê",
                      onPressed: () async {
                        BlocProvider.of<EditPerBasketBloc>(context)
                            .add(LoadAllItemIInventoryEvent(DateTime.now()));
                        Navigator.pushNamed(context, '/choose_lot_screen');
                      },
                    ),
                  ],
                ),
              );
            } else if (state is LoginStateLoginFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ExceptionErrorState(
                      height: 300,
                      title: "Đăng nhập thất bại",
                      message: "Vui lòng kiểm tra lại thông tin",
                      imageDirectory: 'lib/assets/sad_face_search.png',
                      imageHeight: 140,
                    ),
                    CustomizedButton(
                      text: "Đăng nhập",
                      onPressed: () {
                        Navigator.pushNamed(context, '//');
                      },
                    )
                  ],
                ),
              );
            } else {
              return CircularLoading();
            }
          }),
        ));
  }
}
