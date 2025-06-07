import 'package:evently/base.dart';

abstract class LoginConnector extends BaseConnector {
  void goToHome();
  Future<void> updateUserProvider(); // إضافة method جديدة

  @override
  dynamic showLoading({String? message});

  @override
  dynamic showError({String? message});
}