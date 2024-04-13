import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/stage.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:flutter/material.dart';

class SignInController extends ViewModel {
  static const _animationDuration = Duration(milliseconds: 300);

  final List<Stage> sections = [];
  final SignInViewModel signInViewModel;
  final SignUseroptions _choosenType;
  final PageController _controller = PageController(initialPage: 0);
  late int _currentPage = 0;

  SignInController(this._choosenType, this.signInViewModel) {
    setStages();
  }

  void setStages() {
    sections.clear();
    sections.addAll(
      _choosenType.getStages(
        this,
        signInViewModel,
      ),
    );
  }

  PageController get controller => _controller;
  int get currentPage => _currentPage;

  Future _animateToPage(int page) {
    return _controller.animateToPage(
      page,
      duration: _animationDuration,
      curve: Curves.ease,
    );
  }

  Future nextPage(Map<FormFieldValues, FormFieldModel> data) async {
    signInViewModel.handleNext(data);

    if (_currentPage < sections.length - 1) {
      _currentPage++;
      await _animateToPage(_currentPage);
    } else {
      await signInViewModel.handleSignIn(_choosenType);
    }

    notifyListeners();
  }

  void previousPage({Map<FormFieldValues, FormFieldModel>? data}) async {
    if (data != null) {
      signInViewModel.persist(data);
    }

    if (_currentPage > 0) {
      _currentPage--;
      await _animateToPage(_currentPage);
    }

    notifyListeners();
  }

  bool defualtBehavior(Function goTo) {
    if (_currentPage > 0) {
      goTo();
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
