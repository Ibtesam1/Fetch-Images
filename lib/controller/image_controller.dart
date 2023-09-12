import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_beelogix/model/image_model.dart';

class ImageController extends GetxController {
  final Dio _dio = Dio();
  var photos = <ImageModel>[].obs; // observable list for photos
  var isLoading = true.obs;  // observable boolean to track loading state


  @override
  void onInit() {   //onInit means work start when application runs
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/photos');
      final List<dynamic> data = response.data;
      photos.assignAll(data.map((json) => ImageModel.fromJson(json)).toList());
    } catch (e) {
      Get.defaultDialog( // error dialog when there is an exception or network error.
        title: "Error",
        content: Text("Failed to fetch data. Please check your network connection."),
        barrierDismissible: false, // prevents dismissing the dialog by tapping outside.
        textCancel: "OK",
        onCancel: () {
          Get.back(); // close the dialog.
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
