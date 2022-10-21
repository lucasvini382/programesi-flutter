import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
    return Material(
      child: ListView.builder(
          itemCount: userViewModel.timeworks!.length,
          itemBuilder: (context, index) {
            String teste = userViewModel.timeworks![0].description!;
            return ListTile(
              title: Text('item $teste'),
            );
          }),
    );
  }
}
