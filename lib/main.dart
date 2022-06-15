import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jb_notify/src/config/routes.dart';
import 'package:jb_notify/src/welcome_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JB-Notify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
      routes: routes,
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late StreamSubscription<ConnectivityResult> connectivityResult;
  ConnectivityResult connectionResult = ConnectivityResult.wifi;

  @override
  void initState() {
    super.initState();
    connectivityResult = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      connectionResult = result;
      if (connectionResult == ConnectivityResult.none) {
        showTopSnackBar(
            context,
            const CustomSnackBar.error(
                message: 'Please check your Internet connection'));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }

  @override
  dispose() {
    super.dispose();
    connectivityResult.cancel();
  }
}
