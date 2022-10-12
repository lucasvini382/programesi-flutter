import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:programesi/utils/routing/modules/app.module.dart';
import 'package:programesi/utils/routing/routes.dart';
import 'package:programesi/view_model/user.view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const ProgrameSiApp()));
}

class ProgrameSiApp extends StatelessWidget {
  const ProgrameSiApp({Key? key, this.initialRoute = loginRoute})
      : super(key: key);

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(initialRoute);
    final MultiProvider app = MultiProvider(
      providers: [
        ChangeNotifierProvider<UserViewModel>.value(
            value: Modular.get<UserViewModel>()),
      ],
      child: MaterialApp.router(
          title: "ProgrameSi",
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate),
    );
    return app;
  }
}
