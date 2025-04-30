import 'package:app/controllers/home_controller.dart';
import 'package:app/controllers/music_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MusicPlayerController());
    final _controllerTranslate = Get.put(HomeController());

    String getFirst4Words(String text) {
      List<String> words = text.split(' ');
      if (words.length <= 4) {
        return text;
      }
      return words.sublist(0, 4).join(' ') + '...';
    }

    String _formatTime(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return "$minutes:$seconds";
    }

    bool isSwitched = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("home".tr, style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _controllerTranslate.showLanguagesChange();
                },
                icon: Icon(Icons.language),
              ),
              Switch(
                activeColor: Colors.blue,
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                    if (isSwitched) {
                      Get.changeTheme(ThemeData.light());
                    } else {
                      Get.changeTheme(ThemeData.dark());
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(38.0),
                child:
                    controller.isPlaying.value
                        ? Image.asset("assets/images/musicImage.png")
                        : Image.asset("assets/images/musicImage.png"),
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${"Title".tr}: ", // Use "Title" as the key, add ": " in the UI
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                    controller.songTitle.isNotEmpty
                        ? getFirst4Words(controller.songTitle.value)
                        : "No audio selected",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Slider(
                      activeColor: Colors.black,
                      inactiveColor: Colors.green,
                      min: 0,
                      max: controller.duration.value.inSeconds.toDouble(),
                      value: controller.position.value.inSeconds
                          .toDouble()
                          .clamp(
                            0,
                            controller.duration.value.inSeconds.toDouble(),
                          ),
                      onChanged: (value) {
                        controller.seekTo(Duration(seconds: value.toInt()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatTime(controller.position.value),
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          Text(
                            _formatTime(controller.duration.value),
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.skip_previous, size: 32),
                Obx(
                  () => IconButton(
                    onPressed: () {
                      controller.pauseAndPlay();
                    },
                    icon: Icon(
                      controller.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 45,
                    ),
                  ),
                ),
                Icon(Icons.skip_next, size: 32),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.pickFileAndPlaySong();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
