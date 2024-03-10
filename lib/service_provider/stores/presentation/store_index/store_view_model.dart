import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StoreViewModel extends FormViewModel {
  final AuthenticationProvider _authProvider;
  final GoRouter _navigationRouter;
  late final User _user;

  final List<Widget> _stores = [];

  StoreViewModel(
    this._authProvider,
    this._navigationRouter,
  ) {
    initializeFields([
      FormFieldValues.search,
    ]);

    _user = _authProvider.appUser;
  }

  User get user => _user;

  void setSearch(String search) {
    try {
      setValue<String>(FormFieldValues.search, search);
    } on DomainException catch (e) {
      setError(FormFieldValues.search, e.message);
    }
  }

  List<Widget> get stores => _stores;

  Future<void> getStores() async {
    return;
  }

  Future createStore() async {
    await _navigationRouter.push('/createStore');
    notifyListeners();
  }
}
