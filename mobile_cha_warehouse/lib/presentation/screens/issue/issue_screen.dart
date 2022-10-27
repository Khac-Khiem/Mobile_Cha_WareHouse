import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';
import '../../bloc/events/issue_event.dart';
import '../../bloc/states/issue_state.dart';
import '../../widget/exception_widget.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({Key? key}) : super(key: key);

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
   List<String> idListView = [];
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
            leading: IconButton(
              icon: const Icon(
                Icons.west, //mũi tên back
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '///');
              }, //sự kiện mũi tên back
            ),
            backgroundColor: Color(0xff001D37), //màu xanh dương đậm
            //nút bên phải
            title: const Text(
              'Xuất kho',
              style: TextStyle(fontSize: 22), //chuẩn
            ),
          ),
          endDrawer: DrawerUser(),
          body: BlocConsumer<IssueBloc, IssueState>(
              listener: (context, issueState) {
            if (issueState is IssueStateLoadSuccess) {
              idListView = issueState.listIssueId;
              // goodsIssueEntryDataTemp = issueState.goodsIssueEntryData;
              // print(goodsIssueEntryDataTemp);
            }
          }, builder: (context, issueState) {
            if (issueState is IssueStateInitial) {
              return CircularLoading();
            } else {
              return Center(
                child: SingleChildScrollView(
                  child: Builder(builder: (BuildContext context) {
                   
                    if (issueState is IssueStateLoadSuccess ) {
                      return issueState.listIssueId.isNotEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  // danh sách các đơn
                                  children: issueState.listIssueId
                                      .map((item) => ListIssue(
                                            item,
                                          ))
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 100 * SizeConfig.ratioHeight,
                                ),
                                CustomizedButton(
                                    text: 'Trở lại',
                                    onPressed: () async {
                                      Navigator.pushNamed(context, '///');
                                    }),
                                // CustomizedButton(
                                //     text: 'Hoàn thành',
                                //     onPressed: () async {
                                //       // xóa dữ liệu các rổ đã xuất
                                //     }),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ExceptionErrorState(
                                  height: 300,
                                  title: "Không tìm thấy đơn xuất kho",
                                  message: "Vui lòng kiểm tra lại tài khoản.",
                                  imageDirectory:
                                      'lib/assets/sad_face_search.png',
                                  imageHeight: 140,
                                ),
                                CustomizedButton(
                                    text: 'Trở lại',
                                    onPressed: () async {
                                      Navigator.pushNamed(context, '///');
                                    }),
                              ],
                            );
                    } else if (issueState is IssueStateFailure) {
                      return ExceptionErrorState(
                        height: 300,
                        title: "Không tìm thấy dữ liệu",
                        message: "Đã có lỗi trong quá trình truy cập.",
                        imageDirectory: 'lib/assets/sad_face_search.png',
                        imageHeight: 140,
                      );
                    } else {
                      print(issueState);
                      return CircularLoading();
                    }
                  }),
                ),
              );
            }
          })),
    );
  }
}

class ListIssue extends StatelessWidget {
  String issueId;
  ListIssue(this.issueId);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(20),
          ),
          width: 360 * SizeConfig.ratioWidth,
          height: 70 * SizeConfig.ratioHeight,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 60 * SizeConfig.ratioHeight,
                  decoration: BoxDecoration(
                    color: Constants.mainColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Text(issueId,
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectedGoodIssueId = issueId;
                  BlocProvider.of<IssueBloc>(context)
                      .add(ChooseIssueEvent(DateTime.now(), issueId));
                  Navigator.pushNamed(
                    context,
                    '/list_issue_screen',
                  );
                },
                child: const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Constants.mainColor,
                  size: 50,
                ),
              ),
              SizedBox(
                width: 10 * SizeConfig.ratioWidth,
              )
            ],
          ),
        ),
      ),
    );
  }
}
