import 'dart:io';

import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/brand_item.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/domain/models/color_item.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/presentation/read_qr_code/read_qr_code_params.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/client/register_cloth/contracts/register_cloth_request.dart';
import 'package:beat_ecoprove/client/register_cloth/domain/use-cases/register_cloth_use_case.dart';
import 'package:beat_ecoprove/client/register_cloth/domain/value_objects/cloth_name.dart';
import 'package:beat_ecoprove/client/register_cloth/domain/value_objects/cloth_size.dart';
import 'package:beat_ecoprove/client/register_cloth/domain/value_objects/cloth_type.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/home/presentation/main_skeleton/main_skeleton_view_model.dart';
import 'package:beat_ecoprove/home/routes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterClothViewModel extends FormViewModel {
  static const defaultImage = "assets/default_avatar.png";
  final RegisterClothUseCase _registerClothUseCase;
  final StaticValuesProvider _staticValuesProvider;

  late final User? _user;
  final AuthenticationProvider _authProvider;
  final INotificationProvider _notificationProvider;
  final INavigationManager _navigationRouter;

  late Map<String, dynamic> _selectedFilter = {};

  RegisterClothViewModel(
    this._notificationProvider,
    this._authProvider,
    this._registerClothUseCase,
    this._navigationRouter,
    this._staticValuesProvider,
  ) {
    _user = _authProvider.appUser;

    initializeFields([
      FormFieldValues.clothName,
      FormFieldValues.clothType,
      FormFieldValues.clothSize,
      FormFieldValues.clothBrand,
      FormFieldValues.clothColor,
      FormFieldValues.clothImage,
    ]);
    setValue(FormFieldValues.clothType,
        ClothType.getAllTypes().firstOrNull?.displayValue);
    setValue(FormFieldValues.clothSize, ClothSize.getAllTypes().firstOrNull);
    setValue(FormFieldValues.clothBrand, getAllBrands().firstOrNull);
    setValue(FormFieldValues.clothColor,
        _selectedFilter.keys.firstOrNull ?? "FF000000");
    setValue(FormFieldValues.clothImage, XFile(defaultImage));
  }

  User? get user => _user;

  void setClothName(String clothName) {
    try {
      setValue<String>(
          FormFieldValues.clothName, ClothName.create(clothName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.clothName, e.message);
    }
  }

  void getImageFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setValue<XFile>(FormFieldValues.clothImage, pickedFile);
    }
  }

  ImageProvider getClothImage() {
    if (getValue<XFile>(FormFieldValues.clothImage).value!.path ==
        defaultImage) {
      return const AssetImage(defaultImage);
    }

    var clothImage = getValue<XFile>(FormFieldValues.clothImage).value as XFile;

    return FileImage(File(clothImage.path));
  }

  List<String> getAllBrands() {
    List<BrandItem> brandResult = [];
    List<String> brands = [];

    try {
      brandResult = _staticValuesProvider.brands;
    } catch (e) {
      print(e.toString());
    }

    for (var brand in brandResult) {
      brands.add(brand.name);
    }

    return brands;
  }

  List<FilterRow> getAllColors() {
    List<ColorItem> colors = [];
    List<FilterButtonItem> colorItems = [];

    try {
      colors = _staticValuesProvider.colors;
    } catch (e) {
      print(e.toString());
    }

    for (var color in colors) {
      colorItems.add(FilterButtonItem(
        text: color.name,
        value: color.hex,
        backgroundColor: Color(
          int.parse(
            color.hex,
            radix: 16,
          ),
        ),
        dimension: 50,
        tag: "color",
      ));
    }

    return [FilterRow(options: colorItems, isCircular: true)];
  }

  bool haveThisFilter(String filter) => _selectedFilter.containsKey(filter);

  Map<String, dynamic> get allSelectedFilters => _selectedFilter;

  void changeFilterSelection(Map<String, dynamic> filters) {
    Map<String, String> colors = {};

    for (var (value as Map<String, String>) in filters.values) {
      colors.addAll(value);
    }

    _selectedFilter = colors;
    setValue(FormFieldValues.clothColor, _selectedFilter.keys.firstOrNull);

    notifyListeners();
  }

  Future registerCloth() async {
    var mainSkeleton = DependencyInjection.locator<MainSkeletonViewModel>();

    try {
      await _registerClothUseCase.handle(RegisterClothRequest(
        getValue(FormFieldValues.clothName).value ?? "",
        ClothType.getOf(getValue(FormFieldValues.clothType).value).value,
        getValue(FormFieldValues.clothSize).value ?? "",
        getValue(FormFieldValues.clothBrand).value ?? "",
        getValue(FormFieldValues.clothColor).value ?? "FF000000",
        getValue(FormFieldValues.clothImage).value ?? "",
      ));

      mainSkeleton.setIndex(1);
      _navigationRouter.push(HomeRoutes.home);

      _notificationProvider.showNotification(
        LocaleContext.get().client_register_cloth_created,
        type: NotificationTypes.success,
      );
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    // _navigationRouter.pop();
    notifyListeners();
  }

  CardItem<String> toCardItem(ClothResult clothResult) {
    return CardItem(
      id: clothResult.id,
      clothState: clothResult.clothState,
      title: clothResult.name,
      brand: clothResult.brand,
      color: Color(
        int.parse(
          clothResult.color,
          radix: 16,
        ),
      ),
      ecoScore: clothResult.ecoScore,
      size: clothResult.size.toUpperCase(),
      child: clothResult.clothAvatar,
      hasProfile: clothResult.otherProfileAvatar != null
          ? ServerImage(clothResult.otherProfileAvatar!)
          : null,
    );
  }

  void goToReadQRCode() {
    _navigationRouter.push(CoreRoutes.readQRCode, extras: ReadQRCodeParams());
  }
}
