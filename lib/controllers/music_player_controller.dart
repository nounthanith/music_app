import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicPlayerController extends GetxController {
  final audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;
  var songTitle = "".obs;
  var currentPath = "".obs;
  var imageUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    audioPlayer.positionStream.listen((p) {
      position.value = p;
    });
    audioPlayer.durationStream.listen((d) {
      if (d != null) {
        duration.value = d;
      }
    });
  }

  Future<bool> _requestPermission() async {
    if (GetPlatform.isAndroid) {
      PermissionStatus audioStatus = await Permission.audio.status;
      if (!audioStatus.isGranted) {
        audioStatus = await Permission.audio.request();
        if (audioStatus.isGranted) {
          return true;
        }
      } else {
        return true;
      }
      PermissionStatus storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        storageStatus = await Permission.storage.request();
        return storageStatus.isGranted;
      }
    }
    return false;
  }

  void pauseAndPlay() async {
    if (audioPlayer.playing) {
      audioPlayer.pause();
      isPlaying.value = false;
    } else {
      audioPlayer.play();
      isPlaying.value = true;
    }
  }

  void seekTo(Duration newPosition) {
    audioPlayer.seek(newPosition);
  }

  void pickFileAndPlaySong() async {
    final hasPermission = await _requestPermission();
    if (hasPermission) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowedExtensions: ['mp3'],
          type: FileType.custom,
        );
        if (result != null) {
          String path = result.files.single.path!;
          String fileName = result.files.single.name;
          // String image = result.files.single.
          songTitle(fileName);
          currentPath(path);
          // imageUrl.value = image ?? '';

          await audioPlayer.setFilePath(path);

          audioPlayer.play();
          isPlaying(true);
        }
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    } else {
      _showDialogRequestPermission();
    }
  }

  void _showDialogRequestPermission() async {
    Get.dialog(
      AlertDialog(
        title: Text("Permission Required"),
        content: Text("This app need to access storage to play music."),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
            },
            child: Text("Open App Setting"),
          ),
        ],
      ),
    );
  }
}
