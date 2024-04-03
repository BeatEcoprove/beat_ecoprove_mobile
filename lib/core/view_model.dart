import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class Clone<TClass> {
  TClass clone();
}

abstract class ViewModel<TViewArgument> with ChangeNotifier {
  late TViewArgument? arg;

  void setArgument(TViewArgument arg) {
    this.arg = arg;
    notifyListeners();
  }

  static T of<T extends ViewModel>(BuildContext context) {
    return Provider.of<T>(context);
  }

  void initSync() async {
    await initAsync();
  }

  Future initAsync() {
    return Future.value();
  }
}
