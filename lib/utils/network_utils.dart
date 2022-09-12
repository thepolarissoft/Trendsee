import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/providers/connection/connection_provider.dart';

class NetworkUtils {
  BuildContext context;

  NetworkUtils({required this.context});

  // String connectionStatus = 'no';
  final Connectivity _connectivity = Connectivity();
  // ignore: cancel_subscriptions
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  Future<void> init() async {
    instance();
    connectivitySubscription = _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  Future<void> instance() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        Provider.of<ConnectionProvider>(context, listen: false).setConnectionValue(true);
        break;
      case ConnectivityResult.mobile:
        Provider.of<ConnectionProvider>(context, listen: false).setConnectionValue(true);
        break;
      case ConnectivityResult.none:
        Provider.of<ConnectionProvider>(context, listen: false).setConnectionValue(false);
        break;
      default:
        Provider.of<ConnectionProvider>(context, listen: false).setConnectionValue(true);
        break;
    }
  }
}

// class ConnactivityWidget extends StatefulWidget {
//   const ConnactivityWidget({Key key}) : super(key: key);

//   @override
//   _ConnactivityWidgetState createState() => _ConnactivityWidgetState();
// }

// class _ConnactivityWidgetState extends State<ConnactivityWidget> {
//   Future<void> updateConnectionStatus(ConnectivityResult result) async {
//     switch (result) {
//       case ConnectivityResult.wifi:
//         ConnectionUtils().connectionStatus = result.toString();
//         break;
//       case ConnectivityResult.mobile:
//         ConnectionUtils().connectionStatus = result.toString();
//         break;
//       case ConnectivityResult.none:
//         // connectionStatus = result.toString();
//         setState(() => ConnectionUtils().connectionStatus = result.toString());
//         break;
//       default:
//         setState(() =>
//             ConnectionUtils().connectionStatus = 'Failed to get connectivity.');
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
