import 'package:app/translations/app_translation.dart';
import 'package:app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(){
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeView(),
    theme: ThemeData.light(),
    translations: AppTranslation(),
    locale: Locale('en_US'),
  ));
}