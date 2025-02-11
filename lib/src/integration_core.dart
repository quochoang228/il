
import 'package:get_it/get_it.dart';

import 'event_bus.dart';
import 'middleware.dart';
import 'throttle_debounce.dart';

final GetIt getIt = GetIt.instance;

class IntegrationLayer {
  final EventBus _eventBus = EventBus();
  final List<Middleware> _middlewares = [];

  static final IntegrationLayer _instance = IntegrationLayer._internal();
  factory IntegrationLayer() => _instance;
  IntegrationLayer._internal();

  void registerService<T extends Object>(T instance) {
    getIt.registerSingleton<T>(instance);
  }

  T getService<T extends Object>() {
    return getIt<T>();
  }

  void addMiddleware(Middleware middleware) {
    _middlewares.add(middleware);
  }

  void emit<T>(T event, {Duration? throttle, Duration? debounce}) {
    if (!throttleDebounceHandler.shouldEmit(event,
        throttle: throttle, debounce: debounce)) return;

    dynamic processedEvent = event;
    for (var middleware in _middlewares) {
      processedEvent = middleware(processedEvent);
      if (processedEvent == null) return;
    }

    _eventBus.emit(processedEvent);
  }

  void on<T>(Function(T event) callback, {int priority = 0}) {
    _eventBus.on<T>(callback, priority: priority);
  }
}

final IntegrationLayer integrationLayer = IntegrationLayer();
