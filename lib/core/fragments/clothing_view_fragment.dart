import 'package:beat_ecoprove/core/fragment_view.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:flutter/material.dart';

class ClothingViewFragment extends FragmentView {
  static const String title = "Vestuário";

  const ClothingViewFragment({
    super.key,
    required super.view,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: const StandardHeader(
        title: title,
        sustainablePoints: 100,
      ),
      body: view,
    );
  }
}
