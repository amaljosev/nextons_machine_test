import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiController extends GetxController {
  List<dynamic> data = [];
  final kHeight = const SizedBox(
    height: 20,
  );
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getDataFromAPI();
  }

  Future<void> getDataFromAPI() async {
    isLoading.value = true;
    final Map<String, dynamic> requestBody = {
      "statusArray": [1],
      "screenType": [],
      "responseFormat": [],
      "globalGalleryIds": [],
      "categoryIds": [],
      "docTypes": [],
      "types": [],
      "limit": 10,
      "skip": 0,
      "searchingText": ""
    };
    final dio = Dio();
    try {
      final response = await dio.post(
        'https://ajcjewel.com:4000/api/global-gallery/list',
        data: requestBody,
        options: Options(
          headers: {
            'Authorization':
                '''eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfdXNlcklkXyI6IjYzMDI2ZjIxNWE5ZDVjNDY1NzQ3MTMxYSIsIl9lbXBsb3llZUlkXyI6IjYzMDI2ZjIxYTI1MTZhMTU0YTUxY2YxOSIsIl91c2VyUm9sZV8iOiJzdXBlcl9hZG1pbiIsImlhdCI6MTcxMTQ0NTY1OSwiZXhwIjoxNzQyOTgxNjU5fQ.lE1Gbdm8YZ6Fany4184Pb7kSUg-z6Rk8Ag1irB3fstc''',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = response.data;
        data = responseData['data']['list'];
        isLoading.value = false;
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      log('Error: $e');

      throw Exception('Failed to connect to API');
    }
  }
}
