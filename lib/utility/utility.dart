class Utility {
  /// 合計金額取得
  int total = 0;
  int temochi = 0;
  int undercoin = 0;

  void makeTotal(String data, String flag) {
    var exData = (data).split('|');

    var plusNum = (flag == 'all') ? 2 : 0;

    List<List<int>> totalValue = [];
    totalValue.add([10000, int.parse(exData[0 + plusNum])]);
    totalValue.add([5000, int.parse(exData[1 + plusNum])]);
    totalValue.add([2000, int.parse(exData[2 + plusNum])]);
    totalValue.add([1000, int.parse(exData[3 + plusNum])]);
    totalValue.add([500, int.parse(exData[4 + plusNum])]);
    totalValue.add([100, int.parse(exData[5 + plusNum])]);
    totalValue.add([50, int.parse(exData[6 + plusNum])]);
    totalValue.add([10, int.parse(exData[7 + plusNum])]);
    totalValue.add([5, int.parse(exData[8 + plusNum])]);
    totalValue.add([1, int.parse(exData[9 + plusNum])]);

    temochi = 0;
    for (int i = 0; i < totalValue.length; i++) {
      temochi += (totalValue[i][0] * totalValue[i][1]);
    }

    totalValue.add([1, int.parse(exData[10 + plusNum])]);
    totalValue.add([1, int.parse(exData[11 + plusNum])]);
    totalValue.add([1, int.parse(exData[12 + plusNum])]);
    totalValue.add([1, int.parse(exData[13 + plusNum])]);
    totalValue.add([1, int.parse(exData[14 + plusNum])]);

    totalValue.add([1, int.parse(exData[15 + plusNum])]);
    totalValue.add([1, int.parse(exData[16 + plusNum])]);
    totalValue.add([1, int.parse(exData[17 + plusNum])]);
    totalValue.add([1, int.parse(exData[18 + plusNum])]);
    totalValue.add([1, int.parse(exData[19 + plusNum])]);

    total = 0;
    for (int i = 0; i < totalValue.length; i++) {
      total += (totalValue[i][0] * totalValue[i][1]);
    }
    undercoin = 0;
    List<List<int>> uc = [];
    uc.add([10, int.parse(exData[7 + plusNum])]);
    uc.add([5, int.parse(exData[8 + plusNum])]);
    uc.add([1, int.parse(exData[9 + plusNum])]);
    for (int i = 0; i < uc.length; i++) {
      undercoin += (uc[i][0] * uc[i][1]);
    }
  }
}
