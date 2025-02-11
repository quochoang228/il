// import 'package:il/integration_layer.dart';
// import 'package:test/test.dart';
// import 'package:pub/pub.dart';
//
//
// class MockEventBus extends Mock implements EventBus {}
//
// class MockThrottleDebounceHandler extends Mock
//     implements ThrottleDebounceHandler {}
//
// class MockMiddleware extends Mock implements Middleware {}
//
// class TestService {
//   final String id;
//   TestService(this.id);
// }
//
// void main() {
//   late IntegrationLayer layer;
//   late MockEventBus mockEventBus;
//   late MockThrottleDebounceHandler mockThrottleDebounce;
//
//   setUp(() {
//     GetIt.instance.reset();
//     mockEventBus = MockEventBus();
//     mockThrottleDebounce = MockThrottleDebounceHandler();
//     layer = IntegrationLayer();
//   });
//
//   group('Singleton Pattern', () {
//     test('should maintain single instance', () {
//       final instance1 = IntegrationLayer();
//       final instance2 = IntegrationLayer();
//       expect(identical(instance1, instance2), true);
//     });
//   });
//
//   group('Service Management', () {
//     test('should register and retrieve service', () {
//       final service = TestService('test');
//       layer.registerService<TestService>(service);
//       expect(layer.getService<TestService>(), equals(service));
//     });
//
//     test('should throw when getting unregistered service', () {
//       expect(() => layer.getService<TestService>(), throwsA(isA<Exception>()));
//     });
//
//     test('should override existing service registration', () {
//       final service1 = TestService('1');
//       final service2 = TestService('2');
//
//       layer.registerService<TestService>(service1);
//       layer.registerService<TestService>(service2);
//
//       expect(layer.getService<TestService>(), equals(service2));
//     });
//   });
//
//   group('Middleware', () {
//     test('should process events through middleware chain', () {
//       final middleware1 = MockMiddleware();
//       final middleware2 = MockMiddleware();
//
//       when(middleware1.call(any)).thenReturn('modified1');
//       when(middleware2.call('modified1')).thenReturn('modified2');
//
//       layer.addMiddleware(middleware1);
//       layer.addMiddleware(middleware2);
//
//       layer.emit('original');
//
//       verify(middleware1.call('original')).called(1);
//       verify(middleware2.call('modified1')).called(1);
//     });
//
//     test('should stop event propagation when middleware returns null', () {
//       final middleware = MockMiddleware();
//       when(middleware.call(any)).thenReturn(null);
//
//       layer.addMiddleware(middleware);
//       layer.emit('test');
//
//       verifyNever(mockEventBus.emit(any));
//     });
//   });
//
//   group('Event Emission', () {
//     test('should respect throttle', () {
//       when(mockThrottleDebounce.shouldEmit(any, throttle: anyNamed('throttle')))
//           .thenReturn(false);
//
//       layer.emit('test', throttle: Duration(milliseconds: 100));
//
//       verifyNever(mockEventBus.emit(any));
//     });
//
//     test('should respect debounce', () {
//       when(mockThrottleDebounce.shouldEmit(any, debounce: anyNamed('debounce')))
//           .thenReturn(false);
//
//       layer.emit('test', debounce: Duration(milliseconds: 100));
//
//       verifyNever(mockEventBus.emit(any));
//     });
//
//     test('should emit transformed event', () {
//       final middleware = MockMiddleware();
//       when(middleware.call('test')).thenReturn('transformed');
//
//       layer.addMiddleware(middleware);
//       layer.emit('test');
//
//       verify(mockEventBus.emit('transformed')).called(1);
//     });
//   });
//
//   group('Event Subscription', () {
//     test('should register event listener with priority', () {
//       void callback(String event) {}
//       layer.on<String>(callback, priority: 1);
//
//       verify(mockEventBus.on<String>(callback, priority: 1)).called(1);
//     });
//
//     test('should maintain type safety in subscriptions', () {
//       void stringCallback(String event) {}
//       void intCallback(int event) {}
//
//       layer.on<String>(stringCallback);
//       layer.on<int>(intCallback);
//
//       verify(mockEventBus.on<String>(stringCallback, priority: 0)).called(1);
//       verify(mockEventBus.on<int>(intCallback, priority: 0)).called(1);
//     });
//   });
// }
