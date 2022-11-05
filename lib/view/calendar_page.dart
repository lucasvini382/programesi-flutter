import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:programesi/styles/pgs_colors.dart';
import 'package:programesi/utils/routing/routes.dart';
import 'package:programesi/view_model/user.view_model.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final userViewModel = Modular.get<UserViewModel>();
  AudioPlayer? player;

  _runAudio(String path) async {
    try {
      await player?.play(AssetSource(path));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    player = AudioPlayer();
    print(userViewModel.firstName);
    super.initState();
  }

  bool loading = false;

  @override
  void dispose() {
    player?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PgsColors.mainColor,
      ),
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: PgsColors.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50), // <-- Radius
            ),
          ),
          onPressed: () {
            Modular.to.pushNamed(registerRoute);
          },
          child: const Text('Adicionar horário')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Material(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              itemCount: userViewModel.timeworks!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(userViewModel.timeworks![0].description!),
                    SizedBox(
                        height: 2 * MediaQuery.of(context).devicePixelRatio),
                    Text(userViewModel.timeworks![0].calendars![0].date!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userViewModel.timeworks![0].entryHour!),
                        SizedBox(
                            width: 2 * MediaQuery.of(context).devicePixelRatio),
                        Text(userViewModel.timeworks![0].exitHour!),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
