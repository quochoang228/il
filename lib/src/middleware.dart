import 'package:logs/logs.dart';

class Middleware {
  dynamic call(dynamic event) => event;
}

class LogMiddleware extends Middleware {
  @override
  dynamic call(dynamic event) {
    LogUtils.i("📢 Event emitted: $event", tag: 'LogMiddleware');
    return event;
  }
}

class AuthMiddleware extends Middleware {
  final bool Function(dynamic event) _authCheck;
  AuthMiddleware(this._authCheck);

  @override
  dynamic call(dynamic event) {
    if (!_authCheck(event)) {
      LogUtils.e("🚫 Unauthorized event blocked: $event", tag: 'LogMiddleware');
      return null;
    }
    return event;
  }
}
