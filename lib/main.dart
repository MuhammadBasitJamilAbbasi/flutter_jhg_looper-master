import 'package:flutter/material.dart';
import 'package:jhg_looper/utils/app_constant.dart';
import 'package:jhg_looper/utils/app_subscription.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reg_page/reg_page.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  PackageInfo packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
    installerStore: '',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SplashScreen(
        yearlySubscriptionId: yearlySubscription(),
        monthlySubscriptionId: monthlySubscription(),
        appName: AppConstant.appName,
        appVersion: packageInfo.version,
        nextPage: () => const HomeScreen(),
      ),
    );
  }
}
