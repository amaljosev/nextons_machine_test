import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextons/controller/api_controller.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final apiController = Get.put(ApiController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: apiController.isLoading.value
                ? const SizedBox(
                    child: Center(child: CircularProgressIndicator()))
                : DataTable(
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('UID')),
                      DataColumn(label: Text('Doc type')),
                      DataColumn(label: Text('Image')),
                    ],
                    rows: apiController.data.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item['_name'])),
                        DataCell(Text(item['_uid'])),
                        DataCell(Text(item['_uid'])),
                        DataCell(Text(item['_uid'])),
                      ]);
                    }).toList(),
                  ),
          ),
        ),
      ),
    );
  }
}
