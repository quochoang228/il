import 'dart:async';

import 'event_bus.dart';

class ThrottleDebounceHandler {
  final Map<Type, Timer> _debounceTimers = {};
  final Map<Type, DateTime> _lastEmitTimes = {};

  bool shouldEmit<T>(T event, {Duration? throttle, Duration? debounce}) {
    final now = DateTime.now();

    if (throttle != null) {
      final lastEmit = _lastEmitTimes[T] ?? DateTime(2000);
      if (now.difference(lastEmit) < throttle) return false;
      _lastEmitTimes[T] = now;
    }

    if (debounce != null) {
      _debounceTimers[T]?.cancel();
      _debounceTimers[T] = Timer(debounce, () {
        eventBus.emit(event);
      });
      return false;
    }

    return true;
  }
}

final ThrottleDebounceHandler throttleDebounceHandler = ThrottleDebounceHandler();
