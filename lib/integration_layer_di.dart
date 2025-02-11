import 'package:get_it/get_it.dart';
import 'package:il/integration_layer.dart';

class IntegrationLayerDi {
  // Khởi tạo GetIt
  final getIt = GetIt.instance;

  void setup() {
    getIt.registerLazySingleton<EventBus>(() => EventBus());
    getIt.registerLazySingleton<IntegrationLayer>(() => IntegrationLayer());
  }
}
