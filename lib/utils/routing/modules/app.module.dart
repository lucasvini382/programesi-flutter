import 'package:flutter_modular/flutter_modular.dart';
import 'package:programesi/utils/routing/routes.dart';
import 'package:programesi/view/login_page.dart';
import 'package:programesi/view_model/user.view_model.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => UserViewModel()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(loginRoute, child: (context, args) => const LoginPage()),
      ];
}
