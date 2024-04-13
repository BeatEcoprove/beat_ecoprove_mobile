import 'package:flutter/material.dart';

abstract class FragmentView<TView> extends StatelessWidget {
  final TView view;

  const FragmentView({
    super.key,
    required this.view,
  });
}
