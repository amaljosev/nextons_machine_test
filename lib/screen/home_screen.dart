// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextons/controller/api_controller.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final apiController = Get.put(ApiController());
    return Scaffold(
        body: Obx(
      () => apiController.isLoading.value
          ? const SizedBox(child: Center(child: CircularProgressIndicator()))
          : SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: DataTable(
                    dataRowHeight: 100,
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('UID')),
                      DataColumn(label: Text('Doc type')),
                      DataColumn(label: Text('Image')),
                    ],
                    columnSpacing: 50,
                    rows: apiController.data.map((item) {
                      String type = '';
                      if (item['_docType'] == 0) {
                        type = 'Image';
                      } else if (item['_docType'] == 1) {
                        type = 'Video';
                      } else if (item['_docType'] == 2) {
                        type = 'Pdf';
                      } else if (item['_docType'] == 3) {
                        type = 'Audio';
                      } else {
                        type = 'Document';
                      }
                      String img = item['_url'];

                      return DataRow(cells: [
                        DataCell(Text(item['_name'] ?? '')),
                        DataCell(Text(item['_uid'].toString())),
                        DataCell(Text(type)),
                        DataCell(Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 400,
                            width: 50,
                            child: Image.network(
                              img,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
    ));
  }
}
