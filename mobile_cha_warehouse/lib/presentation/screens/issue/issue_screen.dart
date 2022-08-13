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
          if (issueState is IssueStateListLoadSuccess) {
            goodsIssueEntryData = issueState.goodsIssueEntryData;
            print(goodsIssueEntryData);
          }
        }, builder: (context, issueState) {
          if (issueState is IssueStateInitial) {
            return CircularLoading();
          } else {
            return Center(
              child: SingleChildScrollView(
                child: Builder(builder: (BuildContext context) {
                  if (issueState is IssueStateLoadSuccess) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        issueState.listIssueId.isNotEmpty
                            ? Column(
                              children: [
                                Column(
                                    // danh sách các đơn
                                    children: goodIssueIdsView
                                        .map((item) => ListIssue(
                                              item,
                                            ))
                                        .toList(),
                                  ),
                                    CustomizedButton(
                                    text: 'Trở lại',
                                    onPressed: () async {
                                      Navigator.pushNamed(
                                          context, '///');
                                    }),
                              ],
                            )

                            : ExceptionErrorState(
                                height: 300,
                                title: "Không tìm thấy đơn xuất kho",
                                message:
                                    "Vui lòng kiểm tra lại tài khoản.",
                                imageDirectory: 'lib/assets/sad_face_search.png',
                                imageHeight: 140,
                              ),
                                CustomizedButton(
                                    text: 'Trở lại',
                                    onPressed: () async {
                                      Navigator.pushNamed(
                                          context, '///');
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
                    return CircularLoading();
                  }
                }),
              ),
            );
          }
        }));
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
          width: 380 * SizeConfig.ratioWidth,
          height: 60 * SizeConfig.ratioHeight,
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
                          style: TextStyle(color: Colors.white, fontSize: 30))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<IssueBloc>(context)
                      .add(ChooseIssueEvent(DateTime.now(), issueId));
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
