import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:flutter/material.dart';

class SignInController extends ViewModel {
  static const _animationDuration = Duration(milliseconds: 300);

  final List<Widget> _sections;
  final SignInViewModel _signInViewModel;
  final SignUserType _choosenType;
  final PageController _controller = PageController(initialPage: 0);
  late int _currentPage = 0;

  SignInController(this._sections, this._signInViewModel, this._choosenType);

  PageController get controller => _controller;
  int get currentPage => _currentPage;

  Future _animateToPage(int page) {
    return _controller.animateToPage(page,
        duration: _animationDuration, curve: Curves.ease);
  }

  void nextPage(Map<FormFieldValues, FormFieldModel> data) async {
    _signInViewModel.handleNext(data);

    if (_currentPage < _sections.length - 1) {
      _currentPage++;
      await _animateToPage(_currentPage);
    } else {
      _signInViewModel.handleSignIn(_choosenType);
    }

    notifyListeners();
  }

  void previousPage() async {
    if (_currentPage > 0) {
      _currentPage--;
      await _animateToPage(_currentPage);
    }

    notifyListeners();
  }

  bool defualtBehavior() {
    if (_currentPage > 0) {
      previousPage();
      return true;
    }

    return false;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
