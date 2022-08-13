import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/screens/inventory/inventory_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../widget/exception_widget.dart';

//to check info basket with QRcode
int basketIssueIndex = 0;

class ListContainerScreen extends StatelessWidget {
 // ListContainerScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () async {
              AlertDialogTwoBtnCustomized(
                      context,
                      'Bạn có chắc',
                      'Khi nhấn trở lại, mọi dữ liệu sẽ không được lưu',
                      'Trở lại',
                      'Tiếp tục', () {
                Navigator.pushNamed(context, '/list_issue_screen');
              }, () {}, 18, 22)
                  .show();
            },
          ),
          backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
          title: const Text(
            'Danh sách các rổ cần xuất',
            style: TextStyle(fontSize: 22), //chuẩn
          ),
        ),
        endDrawer: DrawerUser(),
        body: BlocConsumer<IssueBloc, IssueState>(
            listener: (context, issueState) {},
            builder: (context, issueState) {
              return Column(
                children: [
                  SizedBox(
                      width: 380 * SizeConfig.ratioWidth,
                      height: 60 * SizeConfig.ratioHeight,
                      // ignore: deprecated_member_use
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 140 * SizeConfig.ratioWidth,
                              child: Text(
                                "Mã SP",
                                style: TextStyle(
                                    fontSize: 21 * SizeConfig.ratioFont,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(
                            width: 80 * SizeConfig.ratioWidth,
                            child: Text(
                              "Mã NV",
                              style: TextStyle(
                                  fontSize: 21 * SizeConfig.ratioFont,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 140 * SizeConfig.ratioWidth,
                            child: Text(
                              "SL/KL",
                              style: TextStyle(
                                  fontSize: 21 * SizeConfig.ratioFont,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 400,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: goodsIssueEntryContainerData.isEmpty
                          ? ExceptionErrorState(
                              height: 300,
                              title: "Chưa có rổ được xuất",
                              message: "Quét mã để tiến hành xuất kho",
                              imageDirectory: 'lib/assets/sad_face_search.png',
                              imageHeight: 140,
                            )
                          : Column(
                              children: [
                                Column(
                                  children: goodsIssueEntryContainerData
                                      .map((item) => RowContainer(item))
                                      .toList(),
                                ),
                                Divider(
                                  indent: 50,
                                  endIndent: 50,
                                  thickness: 1,
                                  color: Colors.grey[400],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        LabelText("Nhu cầu"),
                                        LabelText('Tổng đã xuất')
                                      ],
                                    ),
                                    Column(
                                      children: [LabelText(''), LabelText('')],
                                    )
                                  ],
                                )
                              ],
                            ),
                    ),
                  ),
                  CustomizedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/qr_scanner_issue_screen');
                      },
                      text: 'QUÉT MÃ'),
                  CustomizedButton(
                      text: 'XÁC NHẬN',
                      onPressed: () async {
                        // BlocProvider.of<IssueBloc>(context).add(
                        //     ConFirmExportingContainer(
                        //         selectedGoodIssueId, listBasketIdConfirm));
                        Navigator.pushNamed(context, '/list_issue_screen');
                      })
                ],
              );
            }));
  }
}

class RowContainer extends StatelessWidget {
  GoodsIssueEntryContainer goodsIssueEntryContainer;
  RowContainer(this.goodsIssueEntryContainer);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 380 * SizeConfig.ratioWidth,
        height: 80 * SizeConfig.ratioHeight,
        child: GestureDetector(
            // ignore: deprecated_member_use
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  primary: Colors.grey[300],
                  //   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                ),
                // padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 150 * SizeConfig.ratioWidth,
                        child: Text(
                          goodsIssueEntryContainer
                              .containerId,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      width: 60 * SizeConfig.ratioWidth,
                      child: Text(
                          goodsIssueEntryContainer
                              .quantity
                              .toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(
                      width: 150 * SizeConfig.ratioWidth,
                      child: Text(
                          DateFormat("dd-MM-yyyy").format(
                              goodsIssueEntryContainer
                                  .productionDate),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                // color: goodsIssueEntryContainer.goodsIssueEntryContainer.isTaken
                //     ? Colors.grey[700]
                //     : Colors.grey[300],
                // shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(8))),
                onPressed: () {}
                //nếu rổ đã được taken thì không cho phép ấn vào

                )),
      ),
    );
  }
}
