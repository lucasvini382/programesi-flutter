import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:programesi/utils/routing/routes.dart';
import 'package:programesi/view_model/user.view_model.dart';
import 'package:programesi/widgets/datepicker.widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final UserViewModel userViewModel = Modular.get<UserViewModel>();
  final TextEditingController entryController = TextEditingController();
  final TextEditingController exitController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController initialsController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime expirationDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 15 * MediaQuery.of(context).devicePixelRatio),
              TextField(
                  onSubmitted: (value) => TextInputAction.next,
                  controller: entryController,
                  decoration: const InputDecoration(
                    labelText: 'Horário de entrada',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 10 * MediaQuery.of(context).devicePixelRatio),
              TextField(
                  onSubmitted: (value) => TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: exitController,
                  decoration: const InputDecoration(
                    labelText: 'Horário de saída',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 10 * MediaQuery.of(context).devicePixelRatio),
              TextField(
                  onSubmitted: (value) => TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 10 * MediaQuery.of(context).devicePixelRatio),
              TextField(
                  onSubmitted: (value) => TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: initialsController,
                  decoration: const InputDecoration(
                    labelText: 'Inicial',
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 10 * MediaQuery.of(context).devicePixelRatio),
              Expanded(
                child: JuiDatepicker(
                  icon: const Icon(
                    Icons.event_note,
                    color: Colors.blue,
                  ),
                  colorLabelText: Colors.black,
                  controller: TextEditingController(
                      text: DateFormat("dd/MM/yy").format(expirationDate)),
                  labelText: 'Data',
                  mode: JuiDatepickerMode.DAY,
                  initialDate: expirationDate,
                  initialValue: DateFormat("dd/MM/yy").format(expirationDate),
                  onChange: (value) => setState(() {
                    if (value != null) expirationDate = value;
                  }),
                  validator: (value) {
                    if (value?.isEmpty == true || value == null) {
                      return "Campo obrigatório";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10 * MediaQuery.of(context).devicePixelRatio),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: () {},
                  child: const Text('Enviar')),
              SizedBox(height: 10 * MediaQuery.of(context).devicePixelRatio),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Modular.to.pushNamed(calendarRoute);
                  },
                  child: const Text('Cancelar'))
            ],
          ),
        ),
      ),
    );
  }
}
