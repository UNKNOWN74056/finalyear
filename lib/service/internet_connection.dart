import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//connectivity function to check internet connection
Connectivity _connectivity = Connectivity();

void checkconnectivity() async {
  var connectionresult = await _connectivity.checkConnectivity();

  if (connectionresult == ConnectivityResult.mobile) {
    return null;
  } else if (connectionresult == ConnectivityResult.wifi) {
    return null;
  } else {
    Get.rawSnackbar(
      messageText: const Text(
        "No internet Connection please to internet connection",
        style: TextStyle(color: Color.fromARGB(255, 20, 3, 2)),
      ),
      isDismissible: true,
      backgroundColor: Color.fromARGB(255, 240, 29, 14),
      icon: const Icon(
        Icons.wifi,
        color: Colors.white,
      ),
    );
  }
}
