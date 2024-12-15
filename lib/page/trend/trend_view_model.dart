import 'package:flutter/foundation.dart';

import '../../model/trend_model.dart';
import '../../model/user_model.dart';

class TrendViewModel with ChangeNotifier {
  List<Trend> get trends => _trends;
  final List<Trend> _trends = [];
  final user = User();

  void addTrend(Trend trend) {
    for (var item in _trends) {
      if (item.image == trend.image) {
        return;
      }
    }
    _trends.add(trend);
    notifyListeners();
    user.oldTrend.add(trend);
    user.saveTrend();
  }

  Future<void> init() async {
    await user.loadTrend();
    _trends.addAll(user.oldTrend);
  }
}
