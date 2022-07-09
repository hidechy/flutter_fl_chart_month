// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/money_state.dart';
import '../view_model/money_view_model.dart';

import 'monthly_graph_screen.dart';

class MonthlyListScreen extends ConsumerWidget {
  MonthlyListScreen({Key? key}) : super(key: key);

  List<Map<String, int>> graphData = [];

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;

    var now = DateTime.now();
    var date = now.toString().split(' ')[0];

    final allMoneyState = ref.watch(allMoneyProvider);
    final monthData = getMonthData(date: date, data: allMoneyState);

    makeGraphData(data: monthData);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => goMonthlyGraphScreen(),
            child: const Text('graph'),
          ),
        ],
      ),
    );
  }

  ///
  List<MoneyState> getMonthData(
      {required String date, required List<MoneyState> data}) {
    List<MoneyState> list = [];

    final exDate = date.split('-');

    for (var i = 0; i < data.length; i++) {
      var exOneData = data[i].date.split('-');

      if ('${exDate[0]}-${exDate[1]}' == '${exOneData[0]}-${exOneData[1]}') {
        list.add(data[i]);
      }
    }

    return list;
  }

  ///
  void makeGraphData({required List<MoneyState> data}) {
    for (var i = 0; i < data.length; i++) {
      var exDate = data[i].date.split('-');
      graphData.add({
        'day': int.parse(exDate[2]),
        'total': data[i].total,
      });
    }
  }

  ///
  void goMonthlyGraphScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => MonthlyGraphScreen(
          graphData: graphData,
        ),
      ),
    );
  }
}
