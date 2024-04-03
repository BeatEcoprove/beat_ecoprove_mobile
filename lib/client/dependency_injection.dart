import 'package:beat_ecoprove/application_router.dart';
import 'package:beat_ecoprove/client/clothing/dependency_injection.dart';
import 'package:beat_ecoprove/client/profile/dependency_injection.dart';
import 'package:beat_ecoprove/client/register_cloth/dependency_injection.dart';
import 'package:beat_ecoprove/client/routes.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

extension ClientDepedencyInjection on DependencyInjection {
  void addClient(ApplicationRouter applicationRouter) {
    addProfile();
    addCloset();
    addRegisterCloth();

    applicationRouter.addRoute(clientRoutes);
  }
}
