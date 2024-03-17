import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ViewModel with ChangeNotifier {
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
