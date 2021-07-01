import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UtilsController extends GetxController {

  Rx<ConnectivityResult> connectivity = ConnectivityResult.mobile.obs;
  late StreamSubscription<ConnectivityResult> connectivityListener;


  UtilsController() {

    // if app is opened while there is no connectivity whatsoever the default listener won't work
    // when app is opened, we manually check if there is connection, if not snackbar is shown
    // then after that is finished connectivity listener is started

    Connectivity().checkConnectivity().then((ConnectivityResult initialConnectivity) {

      if( initialConnectivity == ConnectivityResult.none) {
        Get.snackbar(
            '',
            '',
            backgroundColor: Colors.black,
            padding: EdgeInsets.zero,
            colorText: Colors.white,
            margin: EdgeInsets.zero,
            snackPosition: SnackPosition.BOTTOM,
            borderRadius: 0,
            messageText: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No connection', style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
            duration: const Duration(days: 365),
            animationDuration: const Duration(milliseconds: 200)
        );
      }
      connectivity.value = initialConnectivity;

    }).then((value) {
      connectivityListener = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{

        print('Connectivity changed: ' + result.toString());

        if( result == ConnectivityResult.none) {

          print('About to show offline snackbar');

          Get.snackbar(
              '',
              '',
              backgroundColor: Colors.black,
              padding: EdgeInsets.zero,
              colorText: Colors.white,
              margin: EdgeInsets.zero,
              snackPosition: SnackPosition.BOTTOM,
              borderRadius: 0,
              messageText: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No connection', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
              duration: const Duration(days: 365),
              animationDuration: const Duration(milliseconds: 200)
          );
        }

        if( result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {

          if( connectivity.value == ConnectivityResult.none) {
            print('Last value was none, closing snackbar');
            Get.back();
            Future.delayed(const Duration(milliseconds: 400), () {
              print('showing back online snakcbar');
              Get.snackbar(
                  '',
                  '',
                  borderRadius: 0,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  maxWidth: double.infinity,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  animationDuration: const Duration(milliseconds: 200),
                  duration: const Duration(seconds: 2),
                  messageText: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Back online', style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  )
              );
            });

          }
        }

        connectivity.value = result;
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
    connectivityListener.cancel();
  }
}