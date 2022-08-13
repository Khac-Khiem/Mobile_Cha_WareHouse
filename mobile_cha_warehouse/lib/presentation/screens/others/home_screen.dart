import 'package:flutter/material.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/widget/main_app_name.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60 * SizeConfig.ratioHeight,
        backgroundColor: Constants.mainColor,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              iconSize: 25 * SizeConfig.ratioRadius,
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      // endDrawer: DrawerUser(),
      body: SingleChildScrollView(
        child: Container(
          height: 600 * SizeConfig.ratioHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainAppName(),
              SizedBox(
                height: 80 * SizeConfig.ratioHeight,
              ),
              CustomizedButton(
                text: "Đăng nhập",
                onPressed: () {
                  Navigator.pushNamed(context, '//');
                },
              ),
             
              TextButton(
                  onPressed: () {
                    // AlertDialogOneBtnCustomized(
                    //         context: context,
                    //         title: "Thông báo",
                    //         desc:
                    //             "Tính năng chưa được phát triển, liên hệ với phòng IT để được hỗ trợ")
                    //     .show();
                  },
                  child: Text(
                    "Quên mật khẩu?",
                    style: TextStyle(
                        fontSize: 20 * SizeConfig.ratioFont,
                        color: Constants.mainColor,
                        fontWeight: FontWeight.normal),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
