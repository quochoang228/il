import 'package:il/integration_layer.dart';
import 'package:test/test.dart';

void main() {
  late EventBus bus;

  setUp(() {
    bus = EventBus();
  });

  test('EventBus should be singleton', () {
    final bus1 = EventBus();
    final bus2 = EventBus();
    expect(identical(bus1, bus2), true);
  });

  test('should emit event to single listener', () {
    String? receivedMessage;
    bus.on<String>((message) => receivedMessage = message);

    bus.emit('Hello');
    expect(receivedMessage, equals('Hello'));
  });

  test('should handle multiple listeners with priorities', () {
    final List<int> executionOrder = [];

    bus.on<String>((message) => executionOrder.add(1), priority: 1);
    bus.on<String>((message) => executionOrder.add(2), priority: 2);
    bus.on<String>((message) => executionOrder.add(3), priority: 3);

    bus.emit('test');
    expect(executionOrder, equals([3, 2, 1]));
  });

  test('should handle errors with error handler', () {
    Object? caughtError;
    StackTrace? caughtStack;

    bus.setErrorHandler((error, stack) {
      caughtError = error;
      caughtStack = stack;
    });

    bus.on<String>((message) => throw Exception('test error'));

    bus.emit('test');
    expect(caughtError, isA<Exception>());
    expect((caughtError as Exception).toString(), contains('test error'));
    expect(caughtStack, isNotNull);
  });

  test('should maintain type safety', () {
    int callCount = 0;
    bus.on<String>((String message) => callCount++);

    bus.emit('test'); // Should trigger
    bus.emit(42); // Should not trigger

    expect(callCount, equals(1));
  });

  test('should not fail when emitting event with no listeners', () {
    expect(() => bus.emit('test'), returnsNormally);
  });

  test('should handle multiple events of different types', () {
    int stringCount = 0;
    int intCount = 0;

    bus.on<String>((message) => stringCount++);
    bus.on<int>((number) => intCount++);

    bus.emit('test');
    bus.emit(42);

    expect(stringCount, equals(1));
    expect(intCount, equals(1));
  });
}
