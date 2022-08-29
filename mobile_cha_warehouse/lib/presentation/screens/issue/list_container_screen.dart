import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/inventory/inventory_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/issue_params.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../widget/exception_widget.dart';

class ListContainerScreen extends StatelessWidget {
  // ListContainerScreen();
  List<ContainerIssueExportServer> containers = [];

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
              // AlertDialogTwoBtnCustomized(
              //         context,
              //         'Bạn có chắc',
              //         'Khi nhấn trở lại, mọi dữ liệu sẽ không được lưu',
              //         'Trở lại',
              //         'Tiếp tục', () {
              //   goodsIssueEntryContainerData.clear();
              //   Navigator.pushNamed(context, '/list_issue_screen');
              // }, () {}, 18, 22)
              //     .show();
              Navigator.pushNamed(context, '/list_issue_screen');
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
            listener: (context, issueState) {
          // if (issueState is IssueStateListLoading) {
          // }
          //else if(issueState is ConfirmFailureIssueState){
          //    AlertDialogOneBtnCustomized(context, "Thất bại",
          //           "Không thể hoàn thành đơn xuất kho", "Trở lại", () {
          //    // Navigator.pushNamed(context, '///');
          //   }, 18, 22, () {})
          //       .show();
          // }
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
                          width: 140 * SizeConfig.ratioWidth,
                          child: Text(
                            "Mã Rổ",
                            style: TextStyle(
                                fontSize: 21 * SizeConfig.ratioFont,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                      // SizedBox(
                      //   width: 80 * SizeConfig.ratioWidth,
                      //   child: Text(
                      //     "Mã NV",
                      //     style: TextStyle(
                      //         fontSize: 21 * SizeConfig.ratioFont,
                      //         fontWeight: FontWeight.bold),
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),
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
                  height: 350,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Builder(builder: (BuildContext context) {
                        if (issueState is LoadContainerExportStateSuccess) {
                          //return (goodsIssueEntryContainerData.isNotEmpty)
                          return (issueState.containers.isNotEmpty)
                              ? Column(
                                  children: [
                                    // Column(
                                    //   children: containerExported!
                                    //       .map((item) =>
                                    //           RowContainerExported(item))
                                    //       .toList(),
                                    // ),
                                    Column(
                                      children: issueState.containers
                                          .map((item) =>
                                              RowContainerExported(item))
                                          .toList(),
                                    ),
                                    Divider(
                                      indent: 50,
                                      endIndent: 50,
                                      thickness: 1,
                                      color: Colors.grey[400],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            LabelText("Nhu cầu"),
                                            LabelText('Tổng đã xuất')
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            LabelText(planned.toString()),
                                            LabelText(issueState.totalQuatity
                                                .toString())
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : ExceptionErrorState(
                                  height: 300,
                                  title: "Chưa có rổ được xuất",
                                  message: "Quét mã để tiến hành xuất kho",
                                  imageDirectory:
                                      'lib/assets/sad_face_search.png',
                                  imageHeight: 140,
                                );
                        } else if (issueState is LoadContainerExportStateFail) {
                          return ExceptionErrorState(
                            height: 300,
                            title: "Không truy xuất được",
                            message: "Quét mã để tiến hành xuất kho",
                            imageDirectory: 'lib/assets/sad_face_search.png',
                            imageHeight: 140,
                          );
                        } else {
                          return Center(
                            child: CircularLoading(),
                          );
                        }
                      }))),
              CustomizedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/qr_scanner_issue_screen');
                  },
                  text: 'QUÉT MÃ'),
              CustomizedButton(
                  text: 'XÁC NHẬN',
                  onPressed: () async {
                    // BlocProvider.of<IssueBloc>(context).add(
                    //     ConFirmExportingContainer(selectedGoodIssueId,
                    //         goodsIssueEntryContainerData, DateTime.now()));
                    Navigator.pushNamed(context, '/list_issue_screen');
                  })
            ],
          );
        }));
  }
}

class RowContainer extends StatelessWidget {
  ContainerIssueExportServer goodsIssueEntryContainer;
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
                          goodsIssueEntryContainer.containerId,
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
                      width: 150 * SizeConfig.ratioWidth,
                      child: Text(goodsIssueEntryContainer.quantity.toString(),
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
                //Sau này sẽ cho phép xuất lại để điều chỉnh thông tin nếu có sai sót

                )),
      ),
    );
  }
}

class RowContainerExported extends StatelessWidget {
  GoodsIssueEntryContainer goodsIssueEntryContainer;
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
                        width: 150 * SizeConfig.ratioWidth,
                        child: Text(
                          goodsIssueEntryContainer.containerId,
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
                      width: 150 * SizeConfig.ratioWidth,
                      child: Text(goodsIssueEntryContainer.quantity.toString(),
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
                //Sau này sẽ cho phép xuất lại để điều chỉnh thông tin nếu có sai sót

                )),
      ),
    );
  }
}
