import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

String filePath = '';
Future<String> getFilePath() async {
  PermissionStatus storagePermissionStatus = await Permission.storage.request();
  if (storagePermissionStatus.isGranted) {
    final Directory externalStorageDirectory =
        await getApplicationDocumentsDirectory();

    filePath = '${externalStorageDirectory.path}/audio_recorded.wav';

    return filePath;
  } else {
    return filePath;
  }
}

class OurSoundRecorder {
  FlutterSoundRecorder? flutterSoundRecorder;
  bool isFlutterSoundRecorderInitialized = false;

  Future init() async {
    flutterSoundRecorder = FlutterSoundRecorder();
    PermissionStatus permissionStatus = await Permission.microphone.request();
    if (permissionStatus == PermissionStatus.denied) {
      print('Microphone Permission Denied!');
    }

    flutterSoundRecorder!.openAudioSession();
    isFlutterSoundRecorderInitialized = true;
  }

  void dispose() {
    if (isFlutterSoundRecorderInitialized) {
      flutterSoundRecorder!.closeAudioSession();
      flutterSoundRecorder = null;
      isFlutterSoundRecorderInitialized = false;
    }
  }

  Future record() async {
    filePath = await getFilePath();
    if (isFlutterSoundRecorderInitialized) {
      await flutterSoundRecorder!.startRecorder(
        toFile: filePath,
        //codec: Codec.opusOGG,
      );
    }
    print('recording started!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
  }

  Future stop() async {
    if (isFlutterSoundRecorderInitialized) {
      await flutterSoundRecorder!.stopRecorder();
    }
    print('recording stopped!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
  }

  Future toggleRecording() async {
    if (flutterSoundRecorder!.isStopped) {
      await record();
    } else {
      await stop();
    }
  }
}
