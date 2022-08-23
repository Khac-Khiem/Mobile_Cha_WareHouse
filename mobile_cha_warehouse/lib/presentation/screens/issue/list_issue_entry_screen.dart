import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/function.dart';
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
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
              // khong cho phep thoat khoi giao dien khi ddang lamf viec, chi thoat khi da xac nhan
              AlertDialogTwoBtnCustomized(
                      context,
                      'Bạn có chắc',
                      'Khi nhấn trở lại, mọi dữ liệu sẽ không được lưu',
                      'Trở lại',
                      'Tiếp tục', () {
                goodsIssueEntryContainerData.clear();
                BlocProvider.of<IssueBloc>(context)
                    .add(LoadIssueEvent(DateTime.now(), "2021-03-01"));
                Navigator.pushNamed(context, '/issue_screen');
              }, () {}, 18, 22)
                  .show();
              //  Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
          //nút bên phải
          title: Text(
            "DANH SÁCH HÀNG HÓA CẦN XUẤT",
            style: TextStyle(fontSize: 22), //chuẩn
          ),
        ),
        endDrawer: DrawerUser(),
        body: BlocConsumer<IssueBloc, IssueState>(
            listener: (context, issueState) {
          if (issueState is IssueStateListLoadSuccess) {
            goodsIssueEntryData = issueState.goodsIssueEntryData;
            print(goodsIssueEntryData);
          }
        }, builder: (context, issueState) {
          if (issueState is IssueStateInitial) {
            return CircularLoading();
          } else {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Builder(builder: (BuildContext context) {
                      if (issueState is IssueStateLoadSuccess) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            issueState.listIssueId.isNotEmpty
                                ? ExceptionErrorState(
                                    height: 300,
                                    title: "Đã tìm thấy đơn xuất kho",
                                    message: "Vui lòng chọn đơn để tiếp tục",
                                    imageDirectory: 'lib/assets/touch.png',
                                    imageHeight: 120,
                                  )
                                : ExceptionErrorState(
                                    height: 300,
                                    title: "Không tìm thấy đơn xuất kho",
                                    message:
                                        "Vui lòng kiểm tra lại tài khoản \nvà ngày bắt đầu.",
                                    imageDirectory:
                                        'lib/assets/sad_face_search.png',
                                    imageHeight: 140,
                                  ),
                          ],
                        );
                      } else if (issueState is IssueStateListLoading) {
                        return CircularLoading();
                      } else if (issueState is IssueStateFailure) {
                        return ExceptionErrorState(
                          height: 300,
                          title: "Không tìm thấy dữ liệu",
                          message:
                              "Vui lòng kiểm tra lại tài khoản \nvà ngày bắt đầu.",
                          imageDirectory: 'lib/assets/sad_face_search.png',
                          imageHeight: 140,
                        );
                      } else {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: goodsIssueEntryData.isNotEmpty
                                ? [
                                    ColumnHeaderIssue(),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: goodsIssueEntryData
                                            .map((item) => RowIssue(
                                                  item,
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ]
                                : [
                                    ExceptionErrorState(
                                      height: 300,
                                      title: "Không tìm thấy dữ liệu",
                                      message:
                                          "Các rổ trong đơn này đã được \nlấy ra khỏi kho, vui lòng \nkiểm tra lại đơn.",
                                      imageDirectory:
                                          'lib/assets/sad_commander.png',
                                      imageHeight: 100,
                                    ),
                                  ]);
                      }
                    }),
                    goodsIssueEntryData.isNotEmpty
                        ? CustomizedButton(
                            text: 'Hoàn Thành',
                            onPressed: () {
                              // event
                              // confirm exporting container
                              // BlocProvider.of<IssueBloc>(context).add(
                              //     ConfirmClickedIssueEvent(DateTime.now()));
                              Navigator.pushNamed(context, '///');
                            })
                        : CustomizedButton(
                            text: "Trở lại",
                            onPressed: () =>
                                Navigator.pushNamed(context, '///')),
                    SizedBox(
                      height: 30 * SizeConfig.ratioHeight,
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }
}

class RowIssue extends StatelessWidget {
  GoodsIssueEntry goodsIssueEntryRow;

  RowIssue(this.goodsIssueEntryRow);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 380 * SizeConfig.ratioWidth,
        height: 70 * SizeConfig.ratioHeight,
        child: GestureDetector(
          // ignore: deprecated_member_use
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              primary: Colors.grey[300],
              // padding: ,
            ),
            // padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 100 * SizeConfig.ratioWidth,
                    child: Text(
                      goodsIssueEntryRow.item.itemId.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  width: 100 * SizeConfig.ratioWidth,
                  child: Text(goodsIssueEntryRow.plannedQuantity.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                  width: 100 * SizeConfig.ratioWidth,
                  // giá trị actual
                  child: Text('',
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
              //Sự kiện click vào từng dòng
              selectedItemId = goodsIssueEntryRow.item.itemId;
              BlocProvider.of<IssueBloc>(context).add(LoadContainerExportEvent(
                  DateTime.now(), selectedGoodIssueId, selectedItemId));
              Navigator.pushNamed(
                context,
                '/list_container_screen',
              );
            },
          ),
        ),
      ),
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
