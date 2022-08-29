import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../constant.dart';
import '../../function.dart';

void showDialogChooseSlotContinue(BuildContext newContext, String slotID) {
  showDialog(
      context: newContext,
      builder: (_) => AlertDialog(
            title: const Text("Bạn có đồng ý?"),
            content: Text("Vị trí sẽ chọn là: $slotID"),
            actions: <Widget>[
              // ignore: deprecated_member_use
              TextButton(
                child: Text('Đồng ý',
                    style: TextStyle(
                        fontSize: 18 * SizeConfig.ratioFont,
                        color: Constants.mainColor)),
                onPressed: () {
                  Navigator.of(newContext)
                      .pop(); //phải để pop trước khi bật 1 cái Dialog khác.
                  showDialogChooseSlotContinueSuccess(newContext, slotID);
                },
              ),
              // ignore: deprecated_member_use
              TextButton(
                child: Text(
                  'Hủy bỏ',
                  style: TextStyle(
                      fontSize: 18 * SizeConfig.ratioFont, color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(newContext).pop();
                },
              )
            ],
          ));
}

void showDialogChooseSlotContinueSuccess(
    BuildContext newContext, String slotID) {
  showDialog(
      context: newContext,
      builder: (_) => AlertDialog(
            title: const Text("Thành công"),
            content: Text("Đã chọn vị trí $slotID"),
            actions: <Widget>[
              // ignore: deprecated_member_use
              TextButton(
                child: Text('Đồng ý',
                    style: TextStyle(
                        fontSize: 18 * SizeConfig.ratioFont,
                        color: Constants.mainColor)),
                onPressed: () {
                  Navigator.of(newContext).pop();
                },
              ),
            ],
          ));
}

class AlertDialogTwoBtnCustomized {
  BuildContext context;
  String title;
  String desc;
  String textBtn1;
  String textBtn2;
  //Color bgBtn1, bgBtn2, fgBtn1, fgBtn2;
  double titleFSize, descFSize;
  VoidCallback onPressedBtn1, onPressedBtn2;
  AlertDialogTwoBtnCustomized(
    this.context,
    this.title,
    this.desc,
    this.textBtn1,
    this.textBtn2,
    this.onPressedBtn1,
    this.onPressedBtn2,
    //18
    this.descFSize,
    //22
    this.titleFSize,
  );
  void show() {
    Alert(
            context: context,
            content: Container(
              width: SizeConfig.screenWidth * 0.8,
            ),
            title: title,
            desc: desc,
            closeFunction: () {
              Navigator.of(context).pop();
            },
            buttons: [
              DialogButton(
                height: 45 * SizeConfig.ratioHeight,
                radius: BorderRadius.all(
                    Radius.circular(8 * SizeConfig.ratioRadius)),
                color: Constants.mainColor,
                child: Text(textBtn1,
                    style: TextStyle(
                        fontSize: 20 * SizeConfig.ratioFont,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                   if (onPressedBtn1 != null) {
                    onPressedBtn1();
                  }
                },
              ),
              DialogButton(
                color: Colors.transparent,
                child: Text(textBtn2,
                    style: TextStyle(
                        fontSize: 20 * SizeConfig.ratioFont,
                        color: Constants.mainColor,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                   if (onPressedBtn2 != null) {
                    onPressedBtn2();
                  }
                },
              )
            ],
            style: AlertStyle(
                descStyle: TextStyle(
                    fontSize: descFSize * SizeConfig.ratioFont,
                    fontWeight: FontWeight.normal,
                    height: 1.5),
                titleStyle:
                    TextStyle(fontSize: titleFSize * SizeConfig.ratioFont)))
        .show();
  }
}

class AlertDialogOneBtnCustomized {
  BuildContext context;
  String title;
  String desc;
  String textBtn;
 // Color bgBtn, fgBtn;
  double titleFSize, descFSize;
  VoidCallback onPressedBtn;
  VoidCallback closePressed;
  AlertDialogOneBtnCustomized(
     this.context,
      this.title ,
      this.desc ,
      this.textBtn ,
    //  this.bgBtn ,
     // this.fgBtn ,
     this.onPressedBtn,
      this.descFSize ,
      this.titleFSize,
       this.closePressed,
     );
  void show() {
    Alert(
            closeFunction: () {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
              
            },
            context: context,
            title: title,
            desc: desc,
            buttons: [
              DialogButton(
                height: 45 * SizeConfig.ratioHeight,
                radius: BorderRadius.all(
                    Radius.circular(8 * SizeConfig.ratioRadius)),
                color: Constants.mainColor,
                child: Text(textBtn,
                    style: TextStyle(
                        fontSize: 20 * SizeConfig.ratioFont,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  // if (Navigator.canPop(context)) {
                  //   Navigator.of(context).pop();
                  // }
                 Navigator.of(context).pop();
                   if (onPressedBtn != null) {
                    onPressedBtn();
                  }
                },
              ),
            ],
            style: AlertStyle(
                descStyle: TextStyle(
                    fontSize: descFSize * SizeConfig.ratioFont,
                    fontWeight: FontWeight.normal),
                titleStyle:
                    TextStyle(fontSize: titleFSize * SizeConfig.ratioFont)))
        .show();
  }
}

class LoadingDialog {
  BuildContext buildContext;
  //ProgressDialog progressDialog;
  bool
      dismissable; //để khi nhấn ra ngoài thì ko bị dismiss tự động, cái này đôi khi cần, đôi khi ko cần
  LoadingDialog(
      {required this.buildContext,
      required this.dismissable,
      required this.progressDialog}) {
   // print("Hello");
    progressDialog = ProgressDialog(
      buildContext,
      title: const SizedBox(
        width: 0,
        height: 0,
      ),
      message: Padding(
        padding: EdgeInsets.all(5 * SizeConfig.ratioRadius),
        child: Text(
          "Đang tải dữ liệu",
          style: TextStyle(fontSize: 20 * SizeConfig.ratioFont),
        ),
      ),
      dismissable: dismissable,
      defaultLoadingWidget: Container(
          //Do dialog ko có kích thước, nên dùng chính Container để chỉnh kích thước cho Dialog và padding để ép size Circular
          padding: EdgeInsets.all(15 * SizeConfig.ratioRadius),
          width: 60 * SizeConfig.ratioRadius,
          height: 60 *
              SizeConfig
                  .ratioRadius, //Chỗ này là width thì nó mới ra hình vuông được
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Constants.mainColor),
            strokeWidth: 3 * SizeConfig.ratioRadius,
          )),
    );
  }
  ProgressDialog progressDialog;
  void show() {
    // Nếu thêm title vào thì sẽ bị lệch nên thôi khỏi luôn

    progressDialog.show();
  }

  void dismiss() {
    progressDialog.dismiss();
    //Navigator.pop(buildContext);
  }
}
