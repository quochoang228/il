typedef EventCallback<T> = void Function(T event);
typedef ErrorHandler = void Function(Object error, StackTrace stackTrace);

class EventBus {
  static final EventBus _instance = EventBus._internal();
  factory EventBus() => _instance;
  EventBus._internal();

  final Map<Type, List<_EventListener>> _listeners = {};
  ErrorHandler? _errorHandler;

  void setErrorHandler(ErrorHandler handler) {
    _errorHandler = handler;
  }

  void emit<T>(T event) {
    if (_listeners.containsKey(T)) {
      final sortedListeners = List<_EventListener>.from(_listeners[T]!);
      sortedListeners.sort((a, b) => b.priority.compareTo(a.priority));

      for (var listener in sortedListeners) {
        try {
          listener.callback(event);
        } catch (e, stackTrace) {
          _errorHandler?.call(e, stackTrace);
        }
      }
    }
  }

  void on<T>(EventCallback<T> callback, {int priority = 0}) {
    _listeners.putIfAbsent(T, () => []).add(_EventListener(callback, priority));
  }
}

class _EventListener {
  final Function callback;
  final int priority;
  _EventListener(this.callback, this.priority);
}

final EventBus eventBus = EventBus();
