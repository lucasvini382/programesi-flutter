import 'package:flutter_modular/flutter_modular.dart';
import 'package:programesi/utils/routing/routes.dart';
import 'package:programesi/view/calendar_page.dart';
import 'package:programesi/view/login_page.dart';
import 'package:programesi/view/onboarding_page.dart';
import 'package:programesi/view/register_page.dart';
import 'package:programesi/view_model/user.view_model.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => UserViewModel()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(loginRoute,
            transition: TransitionType.rightToLeft,
            child: (context, args) => const LoginPage()),
        ChildRoute(onboardingRoute,
            transition: TransitionType.rightToLeft,
            child: (context, args) => const OnboardingPage()),
        ChildRoute(calendarRoute,
            transition: TransitionType.rightToLeft,
            child: (context, args) => const CalendarPage()),
        ChildRoute(registerRoute,
            transition: TransitionType.rightToLeft,
            child: (context, args) => const RegisterPage()),
      ];
}
