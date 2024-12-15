import 'package:flutter/material.dart';

import '../../model/debug_model.dart';

class DebugViewModel with ChangeNotifier {
  final Debug _debug = Debug();
  final List<DebugInfo> _debugList = [];

  List<DebugInfo> get debugList => _debugList;

  Debug get debug => _debug;

  Future<void> init() async {
    await _debug.load();
    _debugList.addAll(_debug.debugList);
  }

  void cleanDebugList() {
    _debugList.clear();
    _debug.debugList.clear();
    _debug.debugList.clear();
    _debug.save();
    notifyListeners();
  }

  void addItem(DebugInfo debugInfo) {
    _debugList.add(debugInfo);
    _debug.debugList.add(debugInfo);
    _debug.save();
    notifyListeners();
  }
}
