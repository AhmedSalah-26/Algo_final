import 'package:flutter/material.dart';
import 'componet/button.dart';
import 'componet/searchField.dart';
import 'package:algo/componet/data.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> customersData = data.customersData;
  Map<String, dynamic>? customerData; // Nullable type
  TextEditingController textController = TextEditingController();
  Duration? searchTime;

  @override
  void initState() {
    super.initState();
    // Sort the customersData list by customer ID using quick sort
    quickSort(0, customersData.length - 1);
  }

  void quickSort(int left, int right) {
    if (left < right) {
      int partitionIndex = partition(left, right);
      quickSort(left, partitionIndex - 1);
      quickSort(partitionIndex + 1, right);
    }
  }

  int partition(int left, int right) {
    int pivot = customersData[right]["رقمالحساب"];
    int i = left - 1;
    for (int j = left; j < right; j++) {
      if (customersData[j]["رقمالحساب"] <= pivot) {
        i++;
        // Swap customersData[i] and customersData[j]
        Map<String, dynamic> temp = customersData[i];
        customersData[i] = customersData[j];
        customersData[j] = temp;
      }
    }
    // Swap customersData[i+1] and customersData[right] (or pivot)
    Map<String, dynamic> temp = customersData[i + 1];
    customersData[i + 1] = customersData[right];
    customersData[right] = temp;
    return i + 1;
  }

  void searchCustomer() {
    int? id = int.tryParse(textController.text);
    if (id != null) {
      final stopwatch = Stopwatch()..start();
      setState(() {
        customerData = binarySearchFunction(id);
        searchTime = stopwatch.elapsed;
      });
    }
  }

  Map<String, dynamic>? binarySearchFunction(int id) {
    int left = 0;
    int right = customersData.length - 1;
    while (left <= right) {
      int mid = left + ((right - left) ~/ 2);
      if (customersData[mid]["رقمالحساب"] == id) {
        return customersData[mid];
      } else if (customersData[mid]["رقمالحساب"] < id) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }
    return null; // If not found
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF11998E),
                Color(0xFF38EF7D),
                Color(0xFF11998E),
                Color(0xFF11998E),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "invoice App",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "enter your id ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: SearchInput(
                            hintText: "enter your id",
                            textController: textController,
                          ),
                        ),
                        BouncingButton(
                          onTap: searchCustomer,
                          myText: "search",
                        ),
                        SizedBox(height: 20),
                        searchTime != null
                            ? Text(
                          "Search time: ${searchTime!.inMicroseconds} microseconds",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        )
                            : SizedBox(),
                        SizedBox(height: 20),
                        customerData != null
                            ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          width: 400,
                          height: 420,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "اسم العميل: ${customerData!["اسمالعميل"]}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "رقم الحساب: ${customerData!["رقمالحساب"]}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "رقم الشقة: ${customerData!["رقمالشقة"]}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "استهلاك الكهرباء: ${customerData!["استهلاكالكهرباء"]}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "قيمة الفاتورة: ${customerData!["قيمةالفاتورة"]}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "تاريخ الاستحقاق: ${customerData!["تاريخالاستحقاق"]}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "حالة الدفع: ${customerData!["حالةالدفع"]}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                            : SizedBox(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
