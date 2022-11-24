import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:programesi/model/user.model.dart';
import 'package:programesi/styles/pgs_colors.dart';
import 'package:programesi/utils/routing/routes.dart';
import 'package:programesi/view_model/user.view_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late ValueNotifier<bool> newLoading = ValueNotifier<bool>(false);
  final UserViewModel userViewModel = Modular.get<UserViewModel>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6.5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [PgsColors.mainColor, Color(0xFFf5851f)],
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 32, right: 32),
                      child: Text(
                        'Criar conta',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    padding: const EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        hintText: 'E-mail',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    margin: const EdgeInsets.only(top: 32),
                    padding: const EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.vpn_key,
                          color: Colors.grey,
                        ),
                        hintText: 'Senha',
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, right: 32),
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 13),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [PgsColors.mainColor, Color(0xFFf5851f)],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: TextButton(
                        child: AnimatedBuilder(
                            animation: newLoading,
                            builder: (context, _) {
                              return newLoading.value
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    );
                            }),
                        onPressed: () {
                          newLoading.value = !newLoading.value;
                          _loginUser(
                              emailController.text, passwordController.text);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [PgsColors.mainColor, Color(0xFFf5851f)],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: TextButton(
                        child: AnimatedBuilder(
                            animation: newLoading,
                            builder: (context, _) {
                              return newLoading.value
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Criar conta',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    );
                            }),
                        onPressed: () {
                          newLoading.value = !newLoading.value;
                          _loginUser(
                              emailController.text, passwordController.text);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Exibe a SnackBar com uma mensagem [message] de erro.
  void _showError(BuildContext context, {String? message}) {
    final snackBar = SnackBar(
      backgroundColor: PgsColors.mainColor,
      content: Text(
        message!,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _loginUser(String email, String password) async {
    if (email == "") {
      _showError(context, message: "E-mail não pode estar vazio");
      setState(() => newLoading = ValueNotifier<bool>(false));
      return;
    }
    if (password == "") {
      _showError(context, message: "Senha não pode estar vazia");
      setState(() => newLoading = ValueNotifier<bool>(false));
      return;
    }
    try {
      UserModel user = await userViewModel.loginUser(
          emailController.text, passwordController.text);

      if (user.firstName != null) {
        Modular.to.pushNamed(calendarRoute);
      }
    } on DioError catch (error, stack) {
      String? response;

      try {
        response = error.response?.data['errors'].join(" ");
      } catch (e) {
        response =
            'Ocorreu um erro. Por favor, verifique seus dados e tente novamente.';
      }

      await Sentry.captureException(error, stackTrace: stack);
      _showError(context, message: response);
    } catch (error, stack) {
      String? response =
          'Ocorreu um erro. Por favor, verifique seus dados e tente novamente.';
      _showError(context, message: response);
      await Sentry.captureException(error, stackTrace: stack);
    } finally {
      setState(() => newLoading = ValueNotifier<bool>(false));
    }
  }
}
