import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/overlay_widget_with_button.dart';
import 'package:flutter/material.dart';

class LevelUpProvider extends ViewModel {
  late BuildContext context;
  late Modal _overlay;

  void initState() {
    _overlay = Modal(
      top: 198,
      bottom: 198,
      left: 36,
      right: 36,
      action: () {},
      titleModal: "Parabéns! Subiu de nível!",
      buttonText: "Confirmar",
      hasCancelButton: false,
    );
  }

  setContext(BuildContext context) {
    this.context = context;
    initState();
    notifyListeners();
  }

  void showLevelUpNotification() {
    _overlay.create(
      context,
      _content(),
    );
  }

  Widget _content() {
    return Container(
      height: 200,
      color: Colors.black,
    );
  }
}
