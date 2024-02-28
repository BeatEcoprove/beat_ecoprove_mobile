import 'package:beat_ecoprove/core/view_model.dart';

abstract class IBucketInfoManager<T> implements ViewModel {
  addAllClothes(List<T> clothes);

  addCloth(T cloth);

  void removeClothes();

  void removeCloth(T cloth);

  List<T> getAllClothes();

  Map<T, List<T>> getAllClothesMap();
}

class BucketInfoManager extends ViewModel
    implements IBucketInfoManager<String> {
  final List<String> _clothes = [];
  final Map<String, List<String>> _clothesMap = {};

  @override
  addAllClothes(List<String> clothes) {
    for (var cloth in clothes) {
      if (!clothes.contains(cloth)) {
        clothes.add(cloth);
      }
    }
    notifyListeners();
  }

  @override
  addCloth(String cloth) {
    if (!_clothes.contains(cloth)) {
      _clothes.add(cloth);
    }
    notifyListeners();
  }

  @override
  void removeClothes() {
    _clothes.clear();
    _clothesMap.clear();
    notifyListeners();
  }

  @override
  void removeCloth(String cloth) {
    _clothes.remove(cloth);
    _clothesMap.remove(cloth);
    notifyListeners();
  }

  @override
  List<String> getAllClothes() {
    return _clothes;
  }

  @override
  Map<String, List<String>> getAllClothesMap() {
    for (String cloth in _clothes) {
      _clothesMap.addAll({cloth: []});
    }

    return _clothesMap;
  }
}
