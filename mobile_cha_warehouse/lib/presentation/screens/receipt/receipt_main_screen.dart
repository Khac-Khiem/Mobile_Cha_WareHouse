import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';

import '../../../constant.dart';
import '../../bloc/blocs/receipt_bloc.dart';
import '../../bloc/states/receipt_state.dart';
import '../../widget/main_app_name.dart';
import '../../widget/widget.dart';

class ReceiptMainScreen extends StatelessWidget {
  const ReceiptMainScreen({Key? key}) : super(key: key);

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
        appBar: AppBar(
          toolbarHeight: 60 * SizeConfig.ratioHeight,
          backgroundColor: Constants.mainColor,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 25 * SizeConfig.ratioRadius,
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
        ),
        endDrawer: DrawerUser(),
        body: BlocBuilder<ReceiptBloc, ReceiptState>(
          builder: (context, state) {
            if (state is ReceiptLoadingState) {
              return CircularLoading();
            }
            else{
            return Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 600 * SizeConfig.ratioHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80 * SizeConfig.ratioHeight,
                      ),
                      CustomizedButton(
                        text: "Tạo phiếu nhập",
                        onPressed: () {
                          BlocProvider.of<ReceiptBloc>(context)
                              .add(LoadAllReceiptExported(DateTime.now()));
                          Navigator.pushNamed(context, '/receipt_screen');
                        },
                      ),
                      CustomizedButton(
                        text: "Cập nhật vị trí",
                        onPressed: () async {
                          BlocProvider.of<ReceiptBloc>(context)
                              .add(LoadUnlocatedLotEvent(DateTime.now()));
                          Navigator.pushNamed(
                              context, '/list_unlocated_screen');
                        },
                      ),
                      CustomizedButton(
                        text: "Lịch sử",
                        onPressed: () {
                          Navigator.pushNamed(context, '/history_screen');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
            }
          },
        ),
      ),
    );
  }
}
