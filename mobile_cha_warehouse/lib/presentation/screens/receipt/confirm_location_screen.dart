import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/create_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';

import '../../../function.dart';
import '../../../injector.dart';
import '../../widget/widget.dart';

class ConfirmLocationScreen extends StatefulWidget {
  UnlocatedLotReceipt lotReceipt;

  ConfirmLocationScreen(this.lotReceipt);

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {
  String shelfid = '';

  String columnId = '';

  String rowid = '';

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
                    Navigator.pushNamed(context, '/receipt_main_screen');
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
      child: BlocProvider<ReceiptBloc>(
        create: (context) => injector(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.west, //mũi tên back
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/receipt_main_screen');
              }, //sự kiện mũi tên back
            ),

            backgroundColor: const Color(0xff001D37), //màu xanh dương đậm
            //nút bên phải
            title: const Text(
              'Nhập kho',
              style: TextStyle(fontSize: 22), //chuẩn
            ),
          ),
          endDrawer: DrawerUser(),
          body: BlocBuilder<ReceiptBloc, ReceiptState>(
            builder: (context, state) {
              if (state is ReceiptLoadingState) {
                return CircularLoading();
              } else {
                return Container(
                  alignment: Alignment.center,
                 // padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     Column(children: [
                       SizedBox(
                             width: 350 * SizeConfig.ratioWidth,
                             child: Text(
                                 "Mã đơn: " +
                                     widget.lotReceipt.goodsReceiptId,
                                 style: TextStyle(
                                     fontSize: 16 * SizeConfig.ratioFont,
                                     fontWeight: FontWeight.bold,
                                     color: Constants.mainColor),
                                 textAlign: TextAlign.center),
                           ),
                      SizedBox(
                             width: 350 * SizeConfig.ratioWidth,
                             child: Text(
                                 "Mã SP: " +
                                     widget.lotReceipt.item!.itemId,
                                 style: TextStyle(
                                     fontSize: 16 * SizeConfig.ratioFont,
                                     fontWeight: FontWeight.bold,
                                     color: Constants.mainColor),
                                 textAlign: TextAlign.center),
                           ),
                            SizedBox(
                             width: 350 * SizeConfig.ratioWidth,
                             child: Text(
                                 "Tên SP: " +
                                     widget.lotReceipt.item!.name,
                                 style: TextStyle(
                                     fontSize: 16 * SizeConfig.ratioFont,
                                     fontWeight: FontWeight.bold,
                                     color: Constants.mainColor),
                                 textAlign: TextAlign.center),
                           ),
                     ],),
                     Column(children: [
Container(
                       margin: EdgeInsets.symmetric(
                           vertical: 5 * SizeConfig.ratioHeight),
                       width: 250 * SizeConfig.ratioWidth,
                       height: 55 * SizeConfig.ratioHeight,
                       padding: EdgeInsets.symmetric(
                           vertical: 5 * SizeConfig.ratioHeight),
                       decoration: BoxDecoration(
                           border:
                               Border.all(width: 1, color: Colors.grey),
                           borderRadius: const BorderRadius.all(
                               const Radius.circular(5))),
                       child: DropdownSearch(
                         dropdownSearchDecoration: InputDecoration(
                             labelText: "Mã kệ",
                             labelStyle: TextStyle(
                               color: Colors.grey[700],
                               fontSize: 25 * SizeConfig.ratioFont,
                             ),
                             contentPadding: EdgeInsets.symmetric(
                                 horizontal: 10 * SizeConfig.ratioHeight),
                             hintText: "Chọn mã",
                             hintStyle: TextStyle(
                                 fontSize: 16 * SizeConfig.ratioFont),
                             border: const UnderlineInputBorder(
                                 borderSide: BorderSide.none),
                             fillColor: Colors.blue),
                         showAsSuffixIcons: true,
                         popupTitle: Padding(
                           padding: const EdgeInsets.all(10),
                           child: Text(
                             "Chọn mã kệ",
                             style: TextStyle(
                                 fontSize: 16 * SizeConfig.ratioFont),
                             textAlign: TextAlign.center,
                           ),
                         ),
                         popupBackgroundColor: Colors.grey[200],
                         popupShape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10)),
                         items: shelfIds,

                         selectedItem: shelfid,
                         //searchBoxDecoration: InputDecoration(),
                         onChanged: (String? data) {
                           print(shelfIds);
                           shelfid = data.toString();
                         },
                         showSearchBox: true,
                         //  autoFocusSearchBox: true,
                       ),
                          ),
                          Container(
                       margin: EdgeInsets.symmetric(
                           vertical: 5 * SizeConfig.ratioHeight),
                       width: 250 * SizeConfig.ratioWidth,
                       height: 55 * SizeConfig.ratioHeight,
                       padding: EdgeInsets.symmetric(
                           vertical: 5 * SizeConfig.ratioHeight),
                       decoration: BoxDecoration(
                           border:
                               Border.all(width: 1, color: Colors.grey),
                           borderRadius: const BorderRadius.all(
                               const Radius.circular(5))),
                       child: DropdownSearch(
                         dropdownSearchDecoration: InputDecoration(
                             labelText: "Mã cột",
                             labelStyle: TextStyle(
                               color: Colors.grey[700],
                               fontSize: 25 * SizeConfig.ratioFont,
                             ),
                             contentPadding: EdgeInsets.symmetric(
                                 horizontal: 10 * SizeConfig.ratioHeight),
                             hintText: "Chọn mã cột",
                             hintStyle: TextStyle(
                                 fontSize: 16 * SizeConfig.ratioFont),
                             border: const UnderlineInputBorder(
                                 borderSide: BorderSide.none),
                             fillColor: Colors.blue),
                         showAsSuffixIcons: true,
                         popupTitle: Padding(
                           padding: const EdgeInsets.all(10),
                           child: Text(
                             "Chọn mã cột",
                             style: TextStyle(
                                 fontSize: 16 * SizeConfig.ratioFont),
                             textAlign: TextAlign.center,
                           ),
                         ),
                         popupBackgroundColor: Colors.grey[200],
                         popupShape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10)),
                         items: ["1", "2", "3", "4", "5", "6", "7", "8"],

                         selectedItem: columnId,
                         //searchBoxDecoration: InputDecoration(),
                         onChanged: (String? data) {
                           columnId = data.toString();
                         },
                         showSearchBox: true,
                         //  autoFocusSearchBox: true,
                       ),
                          ),
                          Container(
                       margin: EdgeInsets.symmetric(
                           vertical: 5 * SizeConfig.ratioHeight),
                       width: 250 * SizeConfig.ratioWidth,
                       height: 55 * SizeConfig.ratioHeight,
                       padding: EdgeInsets.symmetric(
                           vertical: 5 * SizeConfig.ratioHeight),
                       decoration: BoxDecoration(
                           border:
                               Border.all(width: 1, color: Colors.grey),
                           borderRadius: const BorderRadius.all(
                               const Radius.circular(5))),
                       child: DropdownSearch(
                         dropdownSearchDecoration: InputDecoration(
                             labelText: "Mã hàng",
                             labelStyle: TextStyle(
                               color: Colors.grey[700],
                               fontSize: 25 * SizeConfig.ratioFont,
                             ),
                             contentPadding: EdgeInsets.symmetric(
                                 horizontal: 10 * SizeConfig.ratioHeight),
                             hintText: "Chọn mã hàng",
                             hintStyle: TextStyle(
                                 fontSize: 16 * SizeConfig.ratioFont),
                             border: const UnderlineInputBorder(
                                 borderSide: BorderSide.none),
                             fillColor: Colors.blue),
                         showAsSuffixIcons: true,
                         popupTitle: Padding(
                           padding: const EdgeInsets.all(10),
                           child: Text(
                             "Chọn mã hàng",
                             style: TextStyle(
                                 fontSize: 16 * SizeConfig.ratioFont),
                             textAlign: TextAlign.center,
                           ),
                         ),
                         popupBackgroundColor: Colors.grey[200],
                         popupShape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10)),
                         items: ["1", "2", "3"],

                         selectedItem: rowid,
                         //searchBoxDecoration: InputDecoration(),
                         onChanged: (String? data) {
                           rowid = data.toString();
                         },
                         showSearchBox: true,
                         //  autoFocusSearchBox: true,
                       ),
                          ),
                     ],),
                          
                      CustomizedButton(
                          text: "Xác nhận",
                          onPressed: () {
                            // int index = goodsReceiptEntryConainerDataTemp.indexWhere(
                            //     (element) =>
                            //         element.itemId == widget.lotReceipt.itemId);
                            // goodsReceiptEntryConainerDataTemp[index].location =
                            //     LocationServer(
                            //         shelfid, int.parse(rowid), int.parse(columnId));
                            BlocProvider.of<ReceiptBloc>(context).add(
                                UpdateLocationReceiptEvent(
                                    widget.lotReceipt.goodsReceiptId,
                                    widget.lotReceipt.lotId,
                                    shelfid,
                                    int.parse(rowid),
                                    int.parse(columnId)));
                            Navigator.pushNamed(
                                context, '/list_unlocated_screen');
                          })
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
