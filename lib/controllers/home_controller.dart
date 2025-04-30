import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  void showLanguagesChange() {

    Get.bottomSheet(
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Container(
            width: Get.width,
            height: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                color: Colors.white
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: (){
                        var locale = Locale('km', 'KH');
                        Get.updateLocale(locale);
                        Get.back();
                      },
                      child: Text("Khmer",style: TextStyle(color: Colors.black),)
                  ),
                  TextButton(
                      onPressed: (){
                        var locale = Locale('en', 'US');
                        Get.updateLocale(locale);
                        Get.back();
                      },
                      child: Text("English",style: TextStyle(color: Colors.black),)
                  ),
                  TextButton(
                      onPressed: (){
                        var locale = Locale('zh', 'CN');
                        Get.updateLocale(locale);
                        Get.back();
                      },
                      child: Text("Chinese",style: TextStyle(color: Colors.black),)
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}