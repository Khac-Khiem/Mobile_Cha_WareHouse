import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/entities/lots_data.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/check_lot_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/issue_params.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../../constant.dart';
import '../../dialog/dialog.dart';
import '../../widget/exception_widget.dart';

class ListContainerScreen extends StatelessWidget {
  // ListContainerScreen();
  List<LotIssueExportServer> containers = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: WillPopScope(
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
                      Navigator.pushNamed(context, '/list_issue_screen');
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
                    listLotExportServer.clear();
                    Navigator.pushNamed(context, '/list_issue_screen');
                  }, () {}, 18, 22)
                      .show();
                },
              ),
              backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
              title: const Text(
                'Danh sách hàng hóa cần xuất',
                style: TextStyle(fontSize: 22), //chuẩn
              ),
            ),
            endDrawer: DrawerUser(),
            body: BlocConsumer<IssueBloc, IssueState>(
                listener: (context, issueState) {
              if (issueState is ConfirmSuccessIssueState) {
                AlertDialogOneBtnCustomized(context, "Thành công",
                        "Đã hoàn thành xuất kho", "Tiếp tục", () {
                  listLotExportServer.clear();
                  BlocProvider.of<IssueBloc>(context).add(
                      ChooseIssueEvent(DateTime.now(), selectedGoodIssueId));
                  Navigator.pushNamed(
                    context,
                    '/list_issue_screen',
                  );
                }, 18, 22, () {})
                    .show();
              } else if (issueState is ConfirmFailureIssueState) {
                AlertDialogOneBtnCustomized(context, "Thất bại",
                        "Không thể hoàn thành đơn xuất kho", "Trở lại", () {
                  // BlocProvider.of<IssueBloc>(context).add(
                  //     ChooseIssueEvent(DateTime.now(), selectedGoodIssueId));
                  // Navigator.pushNamed(
                  //   context,
                  //   '/list_issue_screen',
                  // );
                  // Navigator.pushNamed(context, '///');
                }, 18, 22, () {})
                    .show();
              } else if (issueState is IssueStateConfirmLoading) {
                Center(child: CircularLoading());
              }
            }, builder: (context, issueState) {
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
                              width: 100 * SizeConfig.ratioWidth,
                              child: Text(
                                "Mã Lô",
                                style: TextStyle(
                                    fontSize: 21 * SizeConfig.ratioFont,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(
                            width: 100 * SizeConfig.ratioWidth,
                            child: Text(
                              "SL/KL",
                              style: TextStyle(
                                  fontSize: 21 * SizeConfig.ratioFont,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 100 * SizeConfig.ratioWidth,
                            child: Text(
                              "Vị trí",
                              style: TextStyle(
                                  fontSize: 21 * SizeConfig.ratioFont,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )),
                  Divider(
                    indent: 50,
                    endIndent: 50,
                    thickness: 1,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                      height: 450 * SizeConfig.ratioHeight,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Builder(builder: (BuildContext context) {
                            if (issueState is LoadLotSuccess) {
                              //return (goodsIssueEntryContainerData.isNotEmpty)
                              return (issueState.listLotsSuggest.isNotEmpty ||
                                      issueState.listLotExpected.isNotEmpty)
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 220 * SizeConfig.ratioHeight,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Danh sách đề xuất',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 21 *
                                                        SizeConfig.ratioFont,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                issueState.listLotsSuggest
                                                        .isNotEmpty
                                                    ? Column(
                                                        children: listLotSuggest
                                                            .map((item) =>
                                                                RowContainer(
                                                                    item))
                                                            .toList(),
                                                      )
                                                    : ExceptionErrorState(
                                                        height: 300,
                                                        title: "No Data",
                                                        message:
                                                            "Sản phẩm hiện tại không còn tồn kho",
                                                        imageDirectory:
                                                            'lib/assets/sad_face_search.png',
                                                        imageHeight: 140,
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          indent: 50,
                                          endIndent: 50,
                                          thickness: 1,
                                          color: Colors.grey[400],
                                        ),
                                        SizedBox(
                                          height: 220 * SizeConfig.ratioHeight,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Danh sách dự kiến',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 21 *
                                                        SizeConfig.ratioFont,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Column(
                                                  children: issueState
                                                      .listLotExpected
                                                      .map((item) =>
                                                          RowContainerExported(
                                                              item))
                                                      .toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : ExceptionErrorState(
                                      height: 300,
                                      title: "Cảnh báo",
                                      message:
                                          "Sản phẩm hiện tại không còn tồn kho",
                                      imageDirectory:
                                          'lib/assets/sad_face_search.png',
                                      imageHeight: 140,
                                    );
                            } else if (issueState
                                is LoadContainerExportStateFail) {
                              return ExceptionErrorState(
                                height: 300,
                                title: "Không truy xuất được",
                                message: "Quét mã để tiến hành xuất kho",
                                imageDirectory:
                                    'lib/assets/sad_face_search.png',
                                imageHeight: 140,
                              );
                            } else if (issueState is ConfirmFailureIssueState) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 220 * SizeConfig.ratioHeight,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Danh sách đề xuất',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize:
                                                  21 * SizeConfig.ratioFont,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          listLotSuggest.isNotEmpty
                                              ? Column(
                                                  children: listLotSuggest
                                                      .map((item) =>
                                                          RowContainer(item))
                                                      .toList(),
                                                )
                                              : ExceptionErrorState(
                                                  height: 300,
                                                  title: "No Data",
                                                  message:
                                                      "Sản phẩm hiện tại không còn tồn kho",
                                                  imageDirectory:
                                                      'lib/assets/sad_face_search.png',
                                                  imageHeight: 140,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    indent: 50,
                                    endIndent: 50,
                                    thickness: 1,
                                    color: Colors.grey[400],
                                  ),
                                  SizedBox(
                                    height: 220 * SizeConfig.ratioHeight,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Danh sách dự kiến',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize:
                                                  21 * SizeConfig.ratioFont,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Column(
                                            children: listLotExportServer
                                                .map((item) =>
                                                    RowContainerExported(item))
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: CircularLoading(),
                              );
                            }
                          }))),
                  listLotExportServer.isNotEmpty
                      ? CustomizedButton(
                          text: "Xác nhận",
                          bgColor: Constants.mainColor,
                          fgColor: Colors.white,
                          onPressed: () async {
                            BlocProvider.of<IssueBloc>(context).add(
                                ConFirmExportingContainer(selectedGoodIssueId,
                                    listLotExportServer, DateTime.now()));
                          })
                      : CustomizedButton(
                          text: "Trở lại",
                          bgColor: Constants.mainColor,
                          fgColor: Colors.white,
                          onPressed: () async {
                            Navigator.pushNamed(
                              context,
                              '/list_issue_screen',
                            );
                          })
                ],
              );
            })),
      ),
    );
  }
}

class RowContainer extends StatelessWidget {
  Lots lot;
  RowContainer(this.lot);
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
                        width: 100 * SizeConfig.ratioWidth,
                        child: Text(
                          lot.lotId,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    // SizedBox(
                    //   width: 60 * SizeConfig.ratioWidth,
                    //   child: Text(goodsIssueEntryContainer.employeeId,
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 21 * SizeConfig.ratioFont,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //       textAlign: TextAlign.center),
                    // ),
                    SizedBox(
                      width: 100 * SizeConfig.ratioWidth,
                      child: Text(lot.quantity.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(
                      width: 100 * SizeConfig.ratioWidth,
                      child: Text(
                          lot.cell!.shelfId.toString() +
                              lot.cell!.rowId.toString() +
                              lot.cell!.id.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                onPressed: () {
                  checkLot.clear();
                  checkLot.add(lot);
                  quantity.clear();
                  if (planned > lot.quantity) {
                    quantity.add(lot.quantity);
                  } else {
                    quantity.add(planned);
                  }
                  Navigator.pushNamed(context, '/check_lot_screen');
                })),
      ),
    );
  }
}

class RowContainerExported extends StatelessWidget {
  Lots goodsIssueEntryContainer;
  RowContainerExported(this.goodsIssueEntryContainer);
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
                        width: 100 * SizeConfig.ratioWidth,
                        child: Text(
                          goodsIssueEntryContainer.lotId,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    // SizedBox(
                    //   width: 60 * SizeConfig.ratioWidth,
                    //   child: Text(goodsIssueEntryContainer.employeeId,
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 21 * SizeConfig.ratioFont,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //       textAlign: TextAlign.center),
                    // ),
                    SizedBox(
                      width: 100 * SizeConfig.ratioWidth,
                      child: Text(goodsIssueEntryContainer.quantity.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(
                      width: 100 * SizeConfig.ratioWidth,
                      child: Text(
                          goodsIssueEntryContainer.cell!.shelfId.toString() +
                              goodsIssueEntryContainer.cell!.rowId.toString() +
                              goodsIssueEntryContainer.cell!.id.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21 * SizeConfig.ratioFont,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                onPressed: () async {
                  checkLot.clear();
                  checkLot.add(goodsIssueEntryContainer);
                  listLotExportServer = listLotExportServer
                    ..removeWhere((element) =>
                        element.lotId == goodsIssueEntryContainer.lotId);
                  for (var element in listLotSuggest) {
                    if (element.lotId == goodsIssueEntryContainer.lotId) {
                      element.quantity =
                          element.quantity + goodsIssueEntryContainer.quantity;
                    }
                  }
                  Navigator.pushNamed(context, '/check_lot_screen');
                })),
      ),
    );
  }
}
