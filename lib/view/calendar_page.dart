import 'package:audioplayers/audioplayers.dart';
import 'package:date_format/date_format.dart';
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
    } catch (e) {}
  }

  @override
  void initState() {
    player = AudioPlayer();
    print(formatDate(DateTime(1989, 02, 21), [yyyy, '-', mm, '-', dd]));
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
                return Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  userViewModel.timeworks![index].calendars![index].date ??
                                      '',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                  userViewModel.timeworks![index].description ??
                                      '',
                                  style: TextStyle(color: Colors.grey[600])),
                            ])
                      ]),
                      Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffeeeeee)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: MaterialButton(
                            elevation: 0,
                            color: const Color(0x00ffffff),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text('Follow',
                                style: TextStyle(color: Colors.black)),
                          ))
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
