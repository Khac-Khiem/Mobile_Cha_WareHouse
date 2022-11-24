import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/injector.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/check_info_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/edit_per_basket_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/login_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/stockcard_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/screens/inventory/choose_lot_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/inventory/inventory_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/inventory/qr_inventory.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/check_lot_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/confirm_container_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_container_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_issue_entry_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/qr_issue_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/others/home_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/others/login_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/others/main_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/confirm_location_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/create_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/import_history_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/list_unlocated_receipt.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/modify_info_receipt_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_main_screen.dart';
import 'package:mobile_cha_warehouse/presentation/screens/stockcard/stockcard_screen.dart';

import '../screens/issue/issue_screen.dart';
import '../screens/receipt/update_info_receipt_screen.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '//':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<LoginBloc>(create: (context) => injector()),
                ], child: LoginScreen()));
      case '///':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<EditPerBasketBloc>(
                      create: (context) => injector()),
                  BlocProvider<LoginBloc>(create: (context) => injector()),
                  BlocProvider<ReceiptBloc>(create: (context) => injector()),
                  BlocProvider<IssueBloc>(create: (context) => injector()),
                  BlocProvider<StockCardViewBloc>(
                      create: (context) => injector()),
                ], child: const MainScreen()));
      //issue
      case '/issue_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<IssueBloc>(create: (context) => injector()),
                ], child: const IssueScreen()));
      case '/list_issue_screen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider<IssueBloc>(
                create: (context) => injector(),
                child: const ListIssueScreen()));
      case '/list_container_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<IssueBloc>(create: (context) => injector()),
                  BlocProvider<CheckInfoBloc>(create: (context) => injector()),
                ], child: ListContainerScreen()));

      case '/qr_scanner_issue_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<IssueBloc>(create: (context) => injector()),
                  BlocProvider<CheckInfoBloc>(create: (context) => injector()),
                ], child: QRScannerIssueScreen()));
      case '/confirm_container_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<IssueBloc>(create: (context) => injector()),
                  BlocProvider<CheckInfoBloc>(create: (context) => injector()),
                ], child: ConfirmContainerScreen()));
      case '/check_lot_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<IssueBloc>(create: (context) => injector()),
                  BlocProvider<CheckInfoBloc>(create: (context) => injector()),
                ], child: CheckLotScreen()));
      //receipt
      case '/receipt_screen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider<ReceiptBloc>(
                create: (context) => injector(), child: const ReceiptScreen()));
      case '/receipt_main_screen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider<ReceiptBloc>(
                create: (context) => injector(),
                child: const ReceiptMainScreen()));
      // case '/confirm_location_screen':
      //   return MaterialPageRoute(builder: (context) {
         
      //     return BlocProvider<ReceiptBloc>(
      //         create: (context) => injector(),
      //         child: ConfirmLocationScreen());
      //   });
      case '/list_unlocated_screen':
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<ReceiptBloc>(
              create: (context) => injector(),
              child: const ListUnlocatedScreen());
        });
      case '/history_screen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider<ReceiptBloc>(
                create: (context) => injector(), child: ImportHistoryScreen()));
      case '/modify_info_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<ReceiptBloc>(create: (context) => injector()),
                  BlocProvider<CheckInfoBloc>(create: (context) => injector()),
                  BlocProvider<StockCardViewBloc>(
                      create: (context) => injector()),
                ], child: ModifyInfoScreen()));
      // case '/update_info_screen':
      //   return MaterialPageRoute(
      //       builder: (context) => MultiBlocProvider(providers: [
      //             BlocProvider<ReceiptBloc>(create: (context) => injector()),

      //           ], child: UpdateInfoScreen()));
      // case '/scan_container_screen':
      //   return MaterialPageRoute(
      //       builder: (context) => MultiBlocProvider(providers: [
      //             BlocProvider<ReceiptBloc>(create: (context) => injector()),
      //           ], child: ScanContainerScreen()));
      // case '/qr_location_screen':
      //   return MaterialPageRoute(
      //       builder: (context) => BlocProvider<ReceiptBloc>(
      //           create: (context) => injector(),
      //           child: const QRScannerLocationScreen()));

      //
      case '/stockcard_screen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider<StockCardViewBloc>(
                create: (context) => injector(), child: StockCardScreen()));
      // iventory
      case '/choose_lot_screen':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<EditPerBasketBloc>(
                      create: (context) => injector()),
                ], child: ChooseLotScreen()));
      case '/qr_inventory_screen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider<EditPerBasketBloc>(
                create: (context) => injector(), child: const QRScreen()));
      case '/inventory_screen':
        // return MaterialPageRoute(
        //     builder: (context) => BlocProvider<CheckInfoBloc>(
        //         create: (context) => injector(), child: InventoryScreen()));
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(providers: [
                  BlocProvider<EditPerBasketBloc>(
                      create: (context) => injector()),
                ], child: InventoryScreen()));
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}

class ScreenArguments {
  final UnlocatedLotReceipt receipt;
  ScreenArguments(this.receipt);
}
