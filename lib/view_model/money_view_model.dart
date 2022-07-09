import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../state/money_state.dart';
import '../utility/utility.dart';

//////////////////////////////////////////////////////////////////////
final allMoneyProvider =
    StateNotifierProvider.autoDispose<AllMoneyStateNotifier, List<MoneyState>>(
        (ref) {
  return AllMoneyStateNotifier([])..getAllMoneyData();
});

class AllMoneyStateNotifier extends StateNotifier<List<MoneyState>> {
  AllMoneyStateNotifier(List<MoneyState> state) : super(state);

  ///
  void getAllMoneyData() async {
    ///////////////////////////////////////////////
    Utility utility = Utility();
    ///////////////////////////////////////////////
    String url = "http://toyohide.work/BrainLog/api/getAllMoney";
    Map<String, String> headers = {'content-type': 'application/json'};
    Response response = await post(Uri.parse(url), headers: headers);

    var money = jsonDecode(response.body);

    List<MoneyState> list = [];
    for (var i = 0; i < money['data'].length; i++) {
      var exMoney = (money['data'][i]).split('|');

      ///////////////////////////////////////////////
      utility.makeTotal(money['data'][i], 'all');
      ///////////////////////////////////////////////
      list.add(
        MoneyState(
          date: exMoney[0],
          yen_10000: int.parse(exMoney[2]),
          yen_5000: int.parse(exMoney[3]),
          yen_2000: int.parse(exMoney[4]),
          yen_1000: int.parse(exMoney[5]),
          yen_500: int.parse(exMoney[6]),
          yen_100: int.parse(exMoney[7]),
          yen_50: int.parse(exMoney[8]),
          yen_10: int.parse(exMoney[9]),
          yen_5: int.parse(exMoney[10]),
          yen_1: int.parse(exMoney[11]),
          bankA: int.parse(exMoney[12]),
          bankB: int.parse(exMoney[13]),
          bankC: int.parse(exMoney[14]),
          bankD: int.parse(exMoney[15]),
          bankE: int.parse(exMoney[16]),
          peyA: int.parse(exMoney[17]),
          peyB: int.parse(exMoney[18]),
          peyC: int.parse(exMoney[19]),
          peyD: int.parse(exMoney[20]),
          peyE: int.parse(exMoney[21]),
          total: utility.total,
        ),
      );
    }

    state = list;
  }
}

//////////////////////////////////////////////////////////////////////
