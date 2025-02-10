import 'package:il/integration_layer.dart';
import 'package:pub/pub.dart';

class IntegrationLayerDi {
  // Khởi tạo GetIt
  final getIt = GetIt.instance;

  void setup() {
    getIt.registerLazySingleton<EventBus>(() => EventBus());
    getIt.registerLazySingleton<IntegrationLayer>(() => IntegrationLayer());
  }
}
