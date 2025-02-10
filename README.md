# Integration Layer
Package giúp giao tiếp giữa các micro frontends với Event Bus, Middleware và
GetIt.

1️⃣ Yêu cầu chính của Integration Layer

    ✅ Cho phép các micro frontends giao tiếp mà không phụ thuộc chặt chẽ vào nhau (loose coupling).
    ✅ Hỗ trợ event-driven communication hoặc message passing.
    ✅ Có thể gửi yêu cầu API đến backend thông qua API Gateway.
    ✅ Dễ mở rộng khi thêm micro frontends mới.




## Cách sử dụng
```dart
final integrationLayer = IntegrationLayer();

// Đăng ký dịch vụ
integrationLayer.registerService<AuthService>(AuthService());

// Thêm Middleware
integrationLayer.addMiddleware(LogMiddleware());
integrationLayer.addMiddleware(AuthMiddleware((event) => UserSession.isLoggedIn));

// Phát sự kiện với Throttling (chống spam)
integrationLayer.emit(UserActivityEvent(), throttle: Duration(seconds: 1));

// Phát sự kiện với Debouncing (chỉ phát nếu không có sự kiện mới trong 500ms)
integrationLayer.emit(SearchEvent(query: "Flutter"), debounce: Duration(milliseconds: 500));
