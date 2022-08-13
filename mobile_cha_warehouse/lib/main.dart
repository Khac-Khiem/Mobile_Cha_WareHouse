import 'package:flutter/material.dart';
import 'package:mobile_cha_warehouse/injector.dart';
import 'package:mobile_cha_warehouse/presentation/router/app_router.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  // runApp(DevicePreview(
  //   builder: (context) => MyApp(),
  //   enabled: true,
  // ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: AppRoute.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      title: "Storage Management",
    );
  }
}
