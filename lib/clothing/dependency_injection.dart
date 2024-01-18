import 'package:beat_ecoprove/clothing/presentation/closet/clothing_view_model.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/info_cloth/info_cloth_view_model.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/services/info_cloth_services_view_model.dart';
import 'package:beat_ecoprove/clothing/services/action_service.dart';
import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/clothing/services/outfit_service.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/delete_card_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/get_closet_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/mark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/register_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/unmark_cloth_as_daily_use_use_case.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:get_it/get_it.dart';

extension ClothingDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(() => ClosetService(httpClient));
    locator.registerFactory(() => OutfitService(httpClient));
    locator.registerFactory(() => ActionService(httpClient));
  }

  void _addUseCases(GetIt locator) {
    var clothingService = locator<ClosetService>();
    var outfitService = locator<OutfitService>();

    locator.registerSingleton(GetClosetUseCase(clothingService));
    locator.registerSingleton(MarkClothAsDailyUseUseCase(outfitService));
    locator.registerSingleton(UnMarkClothAsDailyUseUseCase(outfitService));
    locator.registerSingleton(DeleteCardUseCase(clothingService));
    locator.registerSingleton(RegisterBucketUseCase(clothingService));
  }

  void _addViewModels(GetIt locator) {
    var router = locator<AppRouter>();
    var authProvider = locator<AuthenticationProvider>();
    var getClosetUseCase = locator<GetClosetUseCase>();
    var markClothAsDailyUseUseCase = locator<MarkClothAsDailyUseUseCase>();
    var unMarkClothAsDailyUseUseCase = locator<UnMarkClothAsDailyUseUseCase>();
    var deleteCardUseCase = locator<DeleteCardUseCase>();
    var registerBucketUseCase = locator<RegisterBucketUseCase>();

    locator.registerFactory(() => ClothingViewModel(
          authProvider,
          getClosetUseCase,
          markClothAsDailyUseUseCase,
          deleteCardUseCase,
          registerBucketUseCase,
          router.appRouter,
        ));
    locator.registerFactory(
        () => InfoClothServiceViewModel(locator<ActionService>()));
    locator.registerFactory(() => InfoClothViewModel(
          markClothAsDailyUseUseCase,
          unMarkClothAsDailyUseUseCase,
        ));
  }

  void addCloset() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
