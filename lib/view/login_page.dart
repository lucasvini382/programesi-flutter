import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:programesi/model/user.model.dart';
import 'package:programesi/view_model/user.view_model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  onSubmitted: (value) => TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 10 * MediaQuery.of(context).devicePixelRatio),
              TextField(
                  onSubmitted: (value) => TextInputAction.done,
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 10 * MediaQuery.of(context).devicePixelRatio),
              ElevatedButton(
                  onPressed: () {
                    _loginUser(emailController.text, passwordController.text);
                  },
                  child: const Text('Entrar'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginUser(String email, String password) async {
    try {
      User user = await userViewModel.loginUser(
          emailController.text, passwordController.text);

      print(user);
      // Modular.to.navigate(rootRoute, arguments: userState);
    } on DioError catch (error, stack) {
      String? response;

      try {
        response = error.response?.data['errors'].join(" ");
      } catch (e) {
        response =
            'Ocorreu um erro. Por favor, verifique seus dados e tente novamente.';
      }

      await Sentry.captureException(error, stackTrace: stack);
    } catch (error, stack) {
      String? response =
          'Ocorreu um erro. Por favor, verifique seus dados e tente novamente.';
      await Sentry.captureException(error, stackTrace: stack);
    } finally {
      setState(() => loading = false);
    }
  }
}
