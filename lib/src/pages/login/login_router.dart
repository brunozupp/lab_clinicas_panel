import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../repositories/user/i_user_repository.dart';
import '../../repositories/user/user_repository.dart';
import '../../services/login/i_user_login_service.dart';
import '../../services/login/user_login_service.dart';
import 'login_controller.dart';
import 'login_page.dart';

class LoginRouter extends FlutterGetItPageRouter {
  
  const LoginRouter({super.key});

  @override
  String get routeName => "/login";

  @override
  List<Bind<Object>> get bindings => [
    Bind.lazySingleton<IUserRepository>((i) => UserRepository(
      restClient: i(),
    )),
    Bind.lazySingleton<IUserLoginService>((i) => UserLoginService(
      userRepository: i(),
    )),
    Bind.lazySingleton<LoginController>((i) => LoginController(
      userLoginService: i(),
    )),
    
  ];

  @override
  WidgetBuilder get view => (_) => const LoginPage();
}