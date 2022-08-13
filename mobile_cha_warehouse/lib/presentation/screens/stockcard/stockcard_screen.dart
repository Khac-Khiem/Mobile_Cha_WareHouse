import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/domain/entities/stock_card.dart';
import 'package:mobile_cha_warehouse/function.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/stockcard_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/stockcard_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/stockcard_state.dart';
import 'package:mobile_cha_warehouse/presentation/widget/exception_widget.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

class StockCardScreen extends StatelessWidget {
  String _productName = '';
  String _productId = '';
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: DrawerUser(),
        appBar: AppBar(
          backgroundColor: Constants.mainColor,
          leading: IconButton(
            icon: const Icon(Icons.west_outlined),
            onPressed: () {
                 Navigator.pushNamed(context, '///');
            },
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  }),
            )
          ],
          title: Text(
            'Thẻ kho',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
              width: 380 * SizeConfig.ratioWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15 * SizeConfig.ratioHeight,
                          ),
                          TextTitle(
                            title: "Mã SP",
                          ),
                          SizedBox(
                            height: 37 * SizeConfig.ratioHeight,
                          ),
                          TextTitle(title: "Tên SP"),
                          SizedBox(
                            height: 27 * SizeConfig.ratioHeight,
                          ),
                          TextTitle(title: "Từ ngày"),
                          SizedBox(
                            height: 27 * SizeConfig.ratioHeight,
                          ),
                          TextTitle(title: "Đến ngày"),
                          SizedBox(
                            height: 27 * SizeConfig.ratioHeight,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 30 * SizeConfig.ratioWidth,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 180 * SizeConfig.ratioWidth,
                              height: 50 * SizeConfig.ratioHeight,
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Constants.mainColor),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(10))),
                              child: BlocBuilder<StockCardViewBloc,
                                      StockCardViewState>(
                                  builder: (context, stockCardState) {
                                if (stockCardState
                                    is StockCardViewStateLoadingProduct) {
                                  return const Center(
                                      child: Text("Loading...."));
                                } else {
                                  return DropdownSearch(
                                    dropdownSearchDecoration: InputDecoration(
                                        contentPadding: SizeConfig
                                                    .ratioHeight >=
                                                1
                                            ? EdgeInsets.fromLTRB(
                                                50 * SizeConfig.ratioWidth,
                                                14 * SizeConfig.ratioHeight,
                                                3 * SizeConfig.ratioWidth,
                                                3 * SizeConfig.ratioHeight)
                                            : const EdgeInsets.fromLTRB(
                                                45,
                                                7,
                                                3,
                                                3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                                        hintText: "Chọn mã",
                                        hintStyle: TextStyle(
                                            fontSize:
                                                16 * SizeConfig.ratioFont),
                                        border: const UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        fillColor: Colors.blue),
                                    showAsSuffixIcons: true,
                                    popupTitle: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        "Chọn mã sản phẩm",
                                        style: TextStyle(
                                            fontSize:
                                                22 * SizeConfig.ratioFont),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    popupBackgroundColor: Colors.grey[200],
                                    popupShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    items: allProductIdList,
                                    //searchBoxDecoration: InputDecoration(),
                                    onChanged: (String? data) {
                                      BlocProvider.of<StockCardViewBloc>(
                                              context)
                                          .add(
                                              StockCardViewEventSelectProductId(
                                                  data.toString()));
                                      _productId = data.toString();
                                    },
                                    showSearchBox: true,
                                    //  autoFocusSearchBox: true,
                                  );
                                }
                              }),
                            ),
                            SizedBox(
                              height: 10 * SizeConfig.ratioHeight,
                            ),
                            BlocBuilder<StockCardViewBloc, StockCardViewState>(
                                builder: (context, stockCardState) {
                              if (stockCardState
                                  is StockCardViewStateSelectedProductID) {
                                _productName = stockCardState.productName;
                              }
                              _productName = _productName;
                              return Container(
                                
                                  alignment: Alignment.centerRight,
                                  width: 180 * SizeConfig.ratioWidth,
                                  height: 50 * SizeConfig.ratioHeight,
                                  //color: Colors.grey[200],
                                  child: TextField(
                                    enabled: true,
                                    readOnly: true,
                                    controller: TextEditingController(
                                        text: _productName),
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18 * SizeConfig.ratioFont),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              width: 1.0,
                                              color: Constants.mainColor)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              width: 1.0,
                                              color: Constants.mainColor)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              width: 1.0,
                                              color: Constants.mainColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              width: 1.0,
                                              color: Constants.mainColor)),
                                    ),
                                  ));
                            }),
                            SizedBox(
                              height: 10 * SizeConfig.ratioHeight,
                            ),
                            Container(
                              width: 180 * SizeConfig.ratioWidth,
                              height: 45 * SizeConfig.ratioHeight,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Constants.mainColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: CustomizeDatePicker(
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                                initDateTime: _startDate,
                                okBtnClickedFunction: (pickedTime) {
                                  _startDate = pickedTime;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10 * SizeConfig.ratioHeight,
                            ),
                            //Date picker end date
                            Container(
                              width: 180 * SizeConfig.ratioWidth,
                              height: 45 * SizeConfig.ratioHeight,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Constants.mainColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: CustomizeDatePicker(
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                                initDateTime: DateTime.now(),
                                okBtnClickedFunction: (pickedTime) {
                                  _endDate = pickedTime;
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Constants.mainColor,
                    thickness: 1,
                  ),
                  Container(
                    height: 280 * SizeConfig.ratioHeight,
                    child: BlocBuilder<StockCardViewBloc, StockCardViewState>(
                        builder: (context, stockCardState) {
                      if (stockCardState is StockCardViewStateLoading) {
                        return Container(
                            width: 380 * SizeConfig.ratioWidth,
                            height: 280 * SizeConfig.ratioHeight,
                            alignment: Alignment.center,
                            child: CircularLoading());
                      } else if (stockCardState
                          is StockCardViewStateLoadSuccess) {
                        List<StockCardEntry> stockcards =
                            stockCardState.stockCard;
                        TextStyle _textContentInTable =
                            TextStyle(fontSize: 14 * SizeConfig.ratioFont);
                        TextStyle _textHeaderInTable = TextStyle(
                            fontSize: 15 * SizeConfig.ratioFont,
                            color: Colors.white);
                        return Container(
                          height: 280 * SizeConfig.ratioHeight,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Container(
                                      color: Constants.mainColor,
                                      width: 310 * SizeConfig.ratioWidth,
                                      height: 50 * SizeConfig.ratioHeight,
                                      // ignore: deprecated_member_use
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 80 * SizeConfig.ratioWidth,
                                              child: Text(
                                                "Ngày",
                                                style: _textHeaderInTable,
                                                textAlign: TextAlign.center,
                                              )),
                                          SizedBox(
                                              width: 55 * SizeConfig.ratioWidth,
                                              child: Text(
                                                "Tồn đầu",
                                                style: _textHeaderInTable,
                                                textAlign: TextAlign.center,
                                              )),
                                          SizedBox(
                                              width: 55 * SizeConfig.ratioWidth,
                                              child: Text(
                                                "Nhập",
                                                style: _textHeaderInTable,
                                                textAlign: TextAlign.center,
                                              )),
                                          SizedBox(
                                              width: 55 * SizeConfig.ratioWidth,
                                              child: Text(
                                                "Xuất",
                                                style: _textHeaderInTable,
                                                textAlign: TextAlign.center,
                                              )),
                                          SizedBox(
                                              width: 55 * SizeConfig.ratioWidth,
                                              child: Text(
                                                "Tồn cuối",
                                                style: _textHeaderInTable,
                                                textAlign: TextAlign.center,
                                              )),
                                          // SizedBox(
                                          //     width: 60 * SizeConfig.ratioWidth,
                                          //     child: Text(
                                          //       "Note",
                                          //       style: _textHeaderInTable,
                                          //       textAlign: TextAlign.center,
                                          //     )),
                                        ],
                                      )),
                                ),
                                Column(
                                  children: stockcards
                                      .map((item) => StockcardRow(
                                            item,
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (stockCardState
                          is StockCardViewStateLoadFailed) {
                        return Container(
                          child: Text('fail'),
                        );
                      } else {
                        return Center(
                          child: ExceptionErrorState(
                            title:
                                "Vui lòng chọn mã sản phẩm \nvà khoảng thời gian",
                            message: "",
                            distanceTextImage: 20,
                            imageHeight: 120,
                            imageDirectory: 'lib/assets/touch.png',
                          ),
                        );
                      }
                    }),
                  ),
                  SizedBox(
                    height: 15 * SizeConfig.ratioHeight,
                  ),
                  BlocBuilder<StockCardViewBloc, StockCardViewState>(
                      builder: (context, state) => CustomizedButton(
                          text: "Truy xuất",
                          onPressed: _productId == ''
                              ? () {
                                  // màn hình yêu cầu chọn product id
                                }
                              : () {
                                  BlocProvider.of<StockCardViewBloc>(context)
                                      .add(StockCardViewEventLoad(
                                          DateTime.now(),
                                          _productId,
                                          _startDate,
                                          _endDate.add(Duration(days: 1))));
                                }))
                ],
              ),
            ),
          ),
        ));
  }
}

class TextTitle extends StatelessWidget {
  String title;
  TextTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 20 * SizeConfig.ratioFont, fontWeight: FontWeight.bold),
    );
  }
}

class StockcardRow extends StatelessWidget {
  StockCardEntry stockCardEntry;
  StockcardRow(this.stockCardEntry);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 310 * SizeConfig.ratioWidth,
        height: 50 * SizeConfig.ratioHeight,
        child: GestureDetector(
          // ignore: deprecated_member_use
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 80 * SizeConfig.ratioWidth,
                  child: Text(
                    DateFormat("yyyy-MM-dd")
                        .format(stockCardEntry.date)
                        .toString(),
                    style: TextStyle(fontSize: 15 * SizeConfig.ratioFont),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                  width: 55 * SizeConfig.ratioWidth,
                  child: Text(
                    stockCardEntry.beforeQuantity.toString(),
                    style: TextStyle(fontSize: 15 * SizeConfig.ratioFont),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                  width: 55 * SizeConfig.ratioWidth,
                  child: Text(
                    stockCardEntry.inputQUantity.toString(),
                    style: TextStyle(fontSize: 15 * SizeConfig.ratioFont),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                  width: 55 * SizeConfig.ratioWidth,
                  child: Text(
                    stockCardEntry.outputQuantity.toString(),
                    style: TextStyle(fontSize: 15 * SizeConfig.ratioFont),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                  width: 55 * SizeConfig.ratioWidth,
                  child: Text(
                    stockCardEntry.afterQuantity.toString(),
                    style: TextStyle(fontSize: 15 * SizeConfig.ratioFont),
                    textAlign: TextAlign.center,
                  )),
              // SizedBox(
              //     width: 60 * SizeConfig.ratioWidth,
              //     child: Text(
              //       stockCardEntry.note,
              //       style: TextStyle(fontSize: 18 * SizeConfig.ratioFont),
              //       textAlign: TextAlign.center,
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
