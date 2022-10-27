import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/edit_per_basket_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/edit_per_basket_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/edit_per_basket_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/inventory/inventory_screen.dart';
import 'package:mobile_cha_warehouse/presentation/widget/widget.dart';

import '../../../constant.dart';
import '../../../domain/entities/lots_data.dart';
import '../../../function.dart';
import '../../widget/exception_widget.dart';
import '../issue/list_container_screen.dart';

class ChooseLotScreen extends StatelessWidget {
  const ChooseLotScreen({Key? key}) : super(key: key);

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
            Navigator.pop(context);
          }, //sự kiện mũi tên back
        ),
        backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
        //nút bên phải
        title: const Text(
          'Kiểm kê',
          style: TextStyle(fontSize: 22), //chuẩn
        ),
      ),
      endDrawer: DrawerUser(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
          width: 380 * SizeConfig.ratioWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Mã sp',
                    style: TextStyle(
                        fontSize: 20 * SizeConfig.ratioFont,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 180 * SizeConfig.ratioWidth,
                    height: 50 * SizeConfig.ratioHeight,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Constants.mainColor),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(10))),
                    child: BlocBuilder<EditPerBasketBloc, EditPerBasketState>(
                        builder: (context, state) {
                      if (state is InventoryStateLoadingProduct) {
                        return const Center(child: Text("Loading...."));
                      } else {
                        return DropdownSearch(
                          dropdownSearchDecoration: InputDecoration(
                              contentPadding: SizeConfig.ratioHeight >= 1
                                  ? EdgeInsets.fromLTRB(
                                      50 * SizeConfig.ratioWidth,
                                      14 * SizeConfig.ratioHeight,
                                      3 * SizeConfig.ratioWidth,
                                      3 * SizeConfig.ratioHeight)
                                  : const EdgeInsets.fromLTRB(45, 7, 3,
                                      3), //Không thêm ratio do để nó cân với fontSize, fontSize trong đây ko chỉnh được
                              hintText: "Chọn mã",
                              hintStyle: TextStyle(
                                  fontSize: 16 * SizeConfig.ratioFont),
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              fillColor: Colors.blue),
                          showAsSuffixIcons: true,
                          popupTitle: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Chọn mã sản phẩm",
                              style: TextStyle(
                                  fontSize: 22 * SizeConfig.ratioFont),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          popupBackgroundColor: Colors.grey[200],
                          popupShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          items: allItemId,
                          //searchBoxDecoration: InputDecoration(),
                          onChanged: (String? data) {
                            BlocProvider.of<EditPerBasketBloc>(context)
                                .add(LoadLotInventoryEvent(data.toString()));
                          },
                          showSearchBox: true,
                          //  autoFocusSearchBox: true,
                        );
                      }
                    }),
                  ),
                ],
              ),
              const Divider(
                indent: 30,
                endIndent: 30,
                color: Constants.mainColor,
                thickness: 1,
              ),
              SizedBox(
                  height: 380,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: BlocBuilder<EditPerBasketBloc, EditPerBasketState>(
                        builder: (context, state) {
                      if (state is InventoryStateLoadLotSuccess) {
                        return (state.listLots.isNotEmpty)
                            ? Column(children: [
                                Text(
                                  'Danh sách đề xuất',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21 * SizeConfig.ratioFont,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  children: state.listLots
                                      .map(
                                          (item) => RowContainerInventory(item))
                                      .toList(),
                                )
                              ])
                            : ExceptionErrorState(
                                height: 300,
                                title: "No Data",
                                message: "Sản phẩm hiện tại không còn tồn kho",
                                imageDirectory:
                                    'lib/assets/sad_face_search.png',
                                imageHeight: 140,
                              );
                      } else if (state is InventoryStateLoadingLot) {
                        return CircularLoading();
                      } else {
                        return ExceptionErrorState(
                          height: 300,
                          title: "Chọn mã SP",
                          message: "Vui lòng chọn mã SP để tiếp tục",
                          imageDirectory: 'lib/assets/sad_face_search.png',
                          imageHeight: 140,
                        );
                      }
                    }),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class RowContainerInventory extends StatelessWidget {
  Lots lot;
  RowContainerInventory(this.lot);
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
                  lotInventory.clear();
                  lotInventory.add(lot);
                  Navigator.pushNamed(context, '/inventory_screen');
                })),
      ),
    );
  }
}
