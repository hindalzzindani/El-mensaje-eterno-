import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hiwayda_oracion_islamica/core/constants/app_enums.dart';
import 'package:hiwayda_oracion_islamica/core/services/easy_loader_service.dart';
import 'package:hiwayda_oracion_islamica/features/faith/model/faithModel.dart';
import 'package:logger/logger.dart';

class FaithController extends GetxController with GetSingleTickerProviderStateMixin{

  RxBool isLoading = true.obs;

  late TabController tabController;

  late List<Tab> tabs;
  StateType getLessonsState = StateType.init;
  @override
  void onInit() async {
    Get.find<Logger>().i("Start onInit FaithController");
    super.onInit();
    await loadJsonFile();
    tabs = [
      Tab(text: faithModel.courses![0].title!,),
      Tab(text: faithModel.courses![1].title!),
    ];
    tabController = TabController(length: 2, vsync: this);
    Get.find<Logger>().w("End onInit FaithController");
    getLessonsState = StateType.success;

  }
  late FaithModel faithModel;
  Future<void> loadJsonFile()async{
    String data = await  rootBundle.loadString('assets/json/Sp-faith.json');
    faithModel = FaithModel.fromJson(await json.decode(data));
    isLoading.value = false;
  }
}