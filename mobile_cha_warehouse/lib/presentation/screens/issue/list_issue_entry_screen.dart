import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/injector.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/dialog/dialog.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

class ListIssueScreen extends StatefulWidget {
  const ListIssueScreen({Key? key}) : super(key: key);

  @override
  State<ListIssueScreen> createState() => _ListIssueScreenState();
}

class _ListIssueScreenState extends State<ListIssueScreen> {
// chứa mã sản phẩm ứng với mỗi entry để xác nhận lấy đúng má sp khi quét mã
  String itemIdPerEntry = '';
// sl/kl cần xuất => hiển thị
  double actualQuantity = 0;
  //
  String issueId = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        return false;

      //   final shouldPop = await showDialog<bool>(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: const Text('Do you want to go back?'),
      //         actionsAlignment: MainAxisAlignment.spaceBetween,
      //         actions: [
      //           BlocProvider(
      //             create: (context) =>
      //                 IssueBloc(injector(), injector(), injector()),
      //             child: BlocBuilder<IssueBloc, IssueState>(
      //               builder: (context, state) {
      //                 return TextButton(
      //                   onPressed: () {
      //                        BlocProvider.of<IssueBloc>(context)
      //                     .add(LoadIssueEvent(DateTime.now(), "2021-03-01"));
      //                     Navigator.pushNamed(context, '/issue_screen');
      //                   },
      //                   child: const Text('Yes'),
      //                 );
      //               },
      //             ),
      //           ),
      //           TextButton(
      //             onPressed: () {
      //               Navigator.pop(context, false);
      //             },
      //             child: const Text('No'),
      //           ),
      //         ],
      //       );
      //     },
      //   );
      //  return shouldPop!;
       
      }),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.west, //mũi tên back
                color: Colors.white,
              ),
              onPressed: () {
                // khong cho phep thoat khoi giao dien khi ddang lamf viec, chi thoat khi da xac nhan
                // AlertDialogTwoBtnCustomized(
                //         context,
                //         'Bạn có chắc',
                //         'Khi nhấn trở lại, mọi dữ liệu sẽ không được lưu',
                //         'Trở lại',
                //         'Tiếp tục', () {
                //   goodsIssueEntryContainerData.clear();
                //   BlocProvider.of<IssueBloc>(context)
                //       .add(LoadIssueEvent(DateTime.now(), "2021-03-01"));
                //   Navigator.pushNamed(context, '/issue_screen');
                // }, () {}, 18, 22)
                //     .show();
                BlocProvider.of<IssueBloc>(context)
                    .add(LoadIssueEvent(DateTime.now(), "2021-03-01"));
                Navigator.pushNamed(context, '/issue_screen');
              },
            ),
            backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
            //nút bên phải
            title: Text(
              "DANH SÁCH HÀNG HÓA CẦN XUẤT",
              style: const TextStyle(fontSize: 22), //chuẩn
            ),
          ),
          endDrawer: DrawerUser(),
          body: BlocConsumer<IssueBloc, IssueState>(
              listener: (context, issueState) {
            // if (issueState is IssueStateListLoadSuccess) {
            //   goodsIssueEntryDataTemp = issueState.goodsIssueEntryData;
            //   print(goodsIssueEntryDataTemp);
            // } else if (issueState is ConfirmSuccessIssueState) {
            //   AlertDialogOneBtnCustomized(context, "Thành công",
            //           "Đã hoàn thành xuất kho", "Tiếp tục", () {
            //     Navigator.pushNamed(context, '///');
            //   }, 18, 22, () {})
            //       .show();
            // } else if (issueState is ConfirmFailureIssueState) {
            //   AlertDialogOneBtnCustomized(context, "Thất bại",
            //           "Không thể hoàn thành đơn xuất kho", "Trở lại", () {
            //     // Navigator.pushNamed(context, '///');
            //   }, 18, 22, () {})
            //       .show();
            // } else if (issueState is IssueStateConfirmLoading) {
            //   CircularLoading();
            // }
          }, builder: (context, issueState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ColumnHeaderIssue(),
                  Builder(builder: (BuildContext context) {
                    if (issueState is IssueStateListLoading) {
                      return Center(child: CircularLoading());
                    } else if (issueState is IssueStateFailure) {
                      return ExceptionErrorState(
                        height: 300,
                        title: "Không tìm thấy dữ liệu",
                        message: "Vui lòng thử lại sau.",
                        imageDirectory: 'lib/assets/sad_face_search.png',
                        imageHeight: 140,
                      );
                    } else {
                      return goodsIssueEntryDataTemp.isNotEmpty
                          ?
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.vertical,
                          //   child: Column(
                          //     children: goodsIssueEntryDataTemp
                          //         .map((item) => RowIssue(
                          //               item,
                          //             ))
                          //         .toList(),
                          //   ),
                          // ),
                          Column(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: SizedBox(
                                    height: 380 * SizeConfig.ratioHeight,
                                    child: ListView.builder(
                                        itemCount:
                                            goodsIssueEntryDataTemp.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: SizedBox(
                                              width:
                                                  380 * SizeConfig.ratioWidth,
                                              height:
                                                  70 * SizeConfig.ratioHeight,
                                              child: GestureDetector(
                                                // ignore: deprecated_member_use
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                    ),
                                                    primary: Colors.grey[300],
                                                    // padding: ,
                                                  ),
                                                  // padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                          width: 100 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          child: Text(
                                                            goodsIssueEntryDataTemp[
                                                                    index]
                                                                .itemId
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 21 *
                                                                  SizeConfig
                                                                      .ratioFont,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          )),
                                                      SizedBox(
                                                        width: 100 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        child: Text(
                                                            goodsIssueEntryDataTemp[
                                                                    index]
                                                                .planQuantity
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 21 *
                                                                  SizeConfig
                                                                      .ratioFont,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center),
                                                      ),
                                                      SizedBox(
                                                        width: 100 *
                                                            SizeConfig
                                                                .ratioWidth,
                                                        // giá trị actual
                                                        child: Text(
                                                            goodsIssueEntryDataTemp[
                                                                    index]
                                                                .actualQuantity
                                                                .toString(),
                                                            //totalExportedList[index].toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 21 *
                                                                  SizeConfig
                                                                      .ratioFont,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center),
                                                      ),
                                                    ],
                                                  ),
                                                  onPressed: () async {
                                                    //Sự kiện click vào từng dòng
                                                    // lưu biến planned
                                                    planned =
                                                        goodsIssueEntryDataTemp[
                                                                index]
                                                            .planQuantity;
                                                    //
                                                    // containerExported =
                                                    //     goodsIssueEntryDataTemp[
                                                    //             index]
                                                    //         .container;
                                                    // print(containerExported);
                                                    //lưu mã sản phẩm
                                                    selectedItemId =
                                                        goodsIssueEntryDataTemp[
                                                                index]
                                                            .itemId;
                                                    BlocProvider.of<IssueBloc>(
                                                            context)
                                                        .add(ChooseIssueEntryEvent(
                                                            selectedGoodIssueId,
                                                            selectedItemId,
                                                            DateTime.now()));
                                                    // BlocProvider.of<IssueBloc>(
                                                    //         context)
                                                    //     .add(LoadContainerExportEvent(
                                                    //         DateTime.now(),
                                                    //         selectedGoodIssueId,
                                                    //         selectedItemId));
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/list_container_screen',
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            )
                          : ExceptionErrorState(
                              height: 300,
                              title: "Không tìm thấy dữ liệu",
                              message:
                                  "Các rổ trong đơn này đã được \nlấy ra khỏi kho, vui lòng \nkiểm tra lại đơn.",
                              imageDirectory: 'lib/assets/sad_commander.png',
                              imageHeight: 100,
                            );
                    }
                  }),
                  // goodsIssueEntryDataTemp.isNotEmpty
                  //     ? CustomizedButton(
                  //         text: 'Hoàn Thành',
                  //         onPressed: () {
                  //           // confirm exporting container event

                  //           // BlocProvider.of<IssueBloc>(context).add(
                  //           //     ConFirmExportingContainer(
                  //           //         selectedGoodIssueId,
                  //           //         goodsIssueEntryContainerData,
                  //           //         DateTime.now()));
                  //           // Navigator.pushNamed(context, '/list_issue_screen');
                  //         })
                  //     : CustomizedButton(
                  //         text: "Trở lại",
                  //         onPressed: () => Navigator.pushNamed(context, '///')),
                  // SizedBox(
                  //   height: 30 * SizeConfig.ratioHeight,
                  // ),

                  CustomizedButton(
                    text: "Trở lại",
                    onPressed:  () async {
                         BlocProvider.of<IssueBloc>(context).add(LoadIssueEvent(DateTime.now(), "2021-03-01"));
                Navigator.pushNamed(context, '/issue_screen');
                    }
                 
                  )
                ],
              ),
            );
          })),
    );
  }
}

class ColumnHeaderIssue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: SizedBox(
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
                    "Mã SP",
                    style: TextStyle(
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                width: 100 * SizeConfig.ratioWidth,
                child: Text(
                  "Nhu cầu",
                  style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 100 * SizeConfig.ratioWidth,
                child: Text(
                  "Thực tế",
                  style: TextStyle(
                      fontSize: 21 * SizeConfig.ratioFont,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
    );
  }
}
