import 'package:flutter/material.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/function.dart';

class MainAppName extends StatelessWidget {
  String title;
  MainAppName({this.title = "QUẢN LÝ KHO"});
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 45 * SizeConfig.ratioFont,
                fontWeight: FontWeight.bold,
                color: Constants.mainColor),
          ),
          SizedBox(height: 20 * SizeConfig.ratioHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage('lib/assets/logo_CHA_new_version.png'),
                width: 100 * SizeConfig.ratioWidth,
              ),
              SizedBox(
                width: 40 * SizeConfig.ratioWidth,
              ),
              Image(
                  image: const AssetImage(
                      'lib/assets/logo_BK_new_version.png'),
                  width: 100 * SizeConfig.ratioWidth)
            ],
          ),
        ]);
  }
}
