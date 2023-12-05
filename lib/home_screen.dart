import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:jhg_looper/helpers/our_sound_recorder.dart';
import 'constants.dart';
import 'package:jhg_looper/components/our_dialog.dart';
import 'package:just_audio/just_audio.dart';
import 'package:jhg_looper/helpers/drum_beats_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'dart:async';
import 'package:jhg_looper/helpers/audio_waveform_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool autoCompleteSwitchStatus = false;

  /// Different settings'/options' state variables.
  bool isMetronomeSelected = false;
  bool isDrumsSelected = false;
  bool isCountInSelected = false;
  bool isBPMSelected = true; // Bcz, BPM will always be selected.
  bool isBarsSelected = false;
  bool isTimingSelected = true; // Bcz, Timing will always be selected.
  bool isTimingFourByFour = true;

  bool stopMetronome = true;

  bool resetButtonDisplayFlag = false;

  String? metronomeBeatsFolderSelected = 'Reason';
  String? drumBeatsFolderSelected = 'Slow Dancing';
  String? countInBeatsFolderSelected = 'Reason';
  int numberOfBars = 4; // as Default.
  int countInDialogNumberOfBars = 2; // as Default.

  double bpmSliderValue = 90.0;

  AudioPlayer recordingPlayer = AudioPlayer();
  AudioPlayer drumsPlayer = AudioPlayer();
  AudioPlayer metronomePlayer = AudioPlayer();

  /// Recorder
  OurSoundRecorder ourSoundRecorder = OurSoundRecorder();
  bool isRecording = false;
  bool isPlaying = false;

  final List<String> metronomeOrCountInDropdownItems = [
    'Reason',
    'Maschine',
    'FL Studio',
    'MPC',
    'Sonar',
    'Pro-Tools Marimba',
    'Pro-Tools Default',
    'Logic',
    'Ableton',
    'Cubase',
  ];

  final List<String> drumsDropdownItems = [
    'Slow Dancing',
    'Gravity',
    'I shot the Sheriff',
    'Hey Joe',
    'Sultans of Swing',
    'Layla',
    'Ain,t no sunshine'
  ];

  Future<void> playMetronomeOrCountInBeats() async {
    AudioPlayer tempAudioPlayer = AudioPlayer();
    // await Future.delayed(
    //   Duration(
    //     milliseconds: ((60 / bpmSliderValue) * 1000).toInt(),
    //   ),
    // );
    await tempAudioPlayer.setAsset(
        'assets/metronome_and_count-in_sounds/${isCountInSelected ? countInBeatsFolderSelected : metronomeBeatsFolderSelected}/beat_1.mp3');
    await tempAudioPlayer.play();
    await Future.delayed(
      Duration(
        milliseconds: ((60 / bpmSliderValue) * 1000).toInt(),
      ),
    );

    tempAudioPlayer.stop();

    await tempAudioPlayer.setAsset(
        'assets/metronome_and_count-in_sounds/${isCountInSelected ? countInBeatsFolderSelected : metronomeBeatsFolderSelected}/beat_2.mp3');
    await tempAudioPlayer.play();
    await Future.delayed(
      Duration(
        milliseconds: ((60 / bpmSliderValue) * 1000).toInt(),
      ),
    );

    tempAudioPlayer.stop();

    await tempAudioPlayer.setAsset(
        'assets/metronome_and_count-in_sounds/${isCountInSelected ? countInBeatsFolderSelected : metronomeBeatsFolderSelected}/beat_2.mp3');
    await tempAudioPlayer.play();
    await Future.delayed(
      Duration(
        milliseconds: ((60 / bpmSliderValue) * 1000).toInt(),
      ),
    );

    tempAudioPlayer.stop();

    await tempAudioPlayer.setAsset(
        'assets/metronome_and_count-in_sounds/${isCountInSelected ? countInBeatsFolderSelected : metronomeBeatsFolderSelected}/beat_2.mp3');
    await tempAudioPlayer.play();
    await Future.delayed(
      Duration(
        milliseconds: ((60 / bpmSliderValue) * 1000).toInt(),
      ),
    );

    tempAudioPlayer.stop();
  }

  @override
  void initState() {
    super.initState();

    ourSoundRecorder.init();
  }

  @override
  void dispose() {
    super.dispose();

    ourSoundRecorder.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5.0),
          child: Column(
            children: [
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 6,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Metronome',
                              style: TextStyle(
                                fontFamily: kFontFamily,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () {
                                stopMetronome = false;
                                setState(() {
                                  isMetronomeSelected
                                      ? isMetronomeSelected = false
                                      : isMetronomeSelected = true;

                                  isMetronomeSelected
                                      ? {
                                          autoCompleteSwitchStatus = true,
                                          isBarsSelected = true
                                        }
                                      : null; // Bcz, Autocomplete & hence 'Bars'  should be auto turned-on when metronome/drums is selected.
                                });
                                if (isMetronomeSelected == true) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext buildContext) {
                                      return StatefulBuilder(
                                        builder: (context, state) => OurDialog(
                                          dialogTitle: 'Metronome',
                                          dialogDescription:
                                              'Choose the sound that you would like to use for the Metronome.',
                                          dialogContentWidget:
                                              DropdownButtonHideUnderline(
                                            child: DropdownButton2<String>(
                                              isExpanded: true,
                                              items:
                                                  metronomeOrCountInDropdownItems
                                                      .map((String item) =>
                                                          DropdownItem<String>(
                                                            value: item,
                                                            height: 20.0,
                                                            child: Text(
                                                              item,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14.0,
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                              value:
                                                  metronomeBeatsFolderSelected,
                                              onChanged: (String? value) {
                                                state(() {
                                                  metronomeBeatsFolderSelected =
                                                      value;
                                                });
                                                setState(() {
                                                  metronomeBeatsFolderSelected =
                                                      value;
                                                });
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                  border: Border.all(
                                                    color: kSelectedCardColor,
                                                  ),
                                                  color: kSelectedCardColor,
                                                ),
                                                elevation: 0,
                                              ),
                                              dropdownStyleData:
                                                  kDropdownStyleData,
                                              dropdownSeparator:
                                                  const DropdownSeparator(
                                                child: Divider(),
                                              ),
                                            ),
                                          ),
                                          isFromMetronome: true,
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: Container(
                                width: kSettingsButtonWidth,
                                height: kSettingsButtonHeight,
                                decoration: BoxDecoration(
                                  color: isMetronomeSelected
                                      ? kSelectedCardColor
                                      : kUnSelectedCardColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Image.asset(
                                  'images/metronome.png',
                                  width: 45.0,
                                  height: 45.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Drums',
                              style: TextStyle(
                                fontFamily: kFontFamily,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isDrumsSelected
                                      ? isDrumsSelected = false
                                      : isDrumsSelected = true;
                                  isDrumsSelected
                                      ? {
                                          autoCompleteSwitchStatus = true,
                                          isBarsSelected = true
                                        }
                                      : null;

                                  bpmSliderValue = drumBeatsFolderInfo[
                                          // TO HANDLE THE CASE: when user just taps on drum & don't open the dropdown. (Then Folder 1's median should be default Slider value BCZ in this case 'onSelected' call-back of 'DropDownMenu' won't be called)
                                          'Slow Dancing']!['Median']!
                                      .toDouble();
                                });
                                if (isDrumsSelected == true) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext buildContext) {
                                      return StatefulBuilder(
                                        builder: (context, state) => OurDialog(
                                          dialogTitle: 'Drums',
                                          dialogDescription:
                                              'Choose the drum track you would like to play along to your loop using the dropdown below',
                                          dialogContentWidget:
                                              DropdownButtonHideUnderline(
                                            child: DropdownButton2<String>(
                                              isExpanded: true,
                                              items: drumsDropdownItems
                                                  .map((String item) =>
                                                      DropdownItem<String>(
                                                        value: item,
                                                        height: 20.0,
                                                        child: Text(
                                                          item,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14.0,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: drumBeatsFolderSelected,
                                              onChanged: (String? value) {
                                                state(() {
                                                  drumBeatsFolderSelected =
                                                      value;
                                                });
                                                setState(() {
                                                  drumBeatsFolderSelected =
                                                      value;
                                                  bpmSliderValue = drumBeatsFolderInfo[
                                                              drumBeatsFolderSelected
                                                                  .toString()]![
                                                          'Median']!
                                                      .toDouble();
                                                });
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                  border: Border.all(
                                                    color: kSelectedCardColor,
                                                  ),
                                                  color: kSelectedCardColor,
                                                ),
                                                elevation: 0,
                                              ),
                                              dropdownStyleData:
                                                  kDropdownStyleData,
                                              dropdownSeparator:
                                                  const DropdownSeparator(
                                                child: Divider(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: Container(
                                width: kSettingsButtonWidth,
                                height: kSettingsButtonHeight,
                                decoration: BoxDecoration(
                                  color: isDrumsSelected
                                      ? kSelectedCardColor
                                      : kUnSelectedCardColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Image.asset(
                                  'images/drum_kit.png',
                                  width: 45.0,
                                  height: 45.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Count-in',
                              style: TextStyle(
                                fontFamily: kFontFamily,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isCountInSelected
                                      ? isCountInSelected = false
                                      : isCountInSelected = true;
                                });
                                if (isCountInSelected == true) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext buildContext) {
                                      return StatefulBuilder(
                                        builder: (context, state) => OurDialog(
                                          dialogTitle: 'Count-in',
                                          dialogDescription: '',
                                          dialogContentWidget: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'Sound',
                                                  style: kDialogTitleTextStyle,
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'Choose the sound and length you would like to use for the count-in.',
                                                  style:
                                                      kDialogDescriptionTextStyle,
                                                ),
                                              ),
                                              const Expanded(
                                                child: SizedBox(),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton2<String>(
                                                    isExpanded: true,
                                                    items:
                                                        metronomeOrCountInDropdownItems
                                                            .map((String
                                                                    item) =>
                                                                DropdownItem<
                                                                    String>(
                                                                  value: item,
                                                                  height: 20.0,
                                                                  child: Text(
                                                                    item,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          14.0,
                                                                    ),
                                                                  ),
                                                                ))
                                                            .toList(),
                                                    value:
                                                        countInBeatsFolderSelected,
                                                    onChanged: (String? value) {
                                                      state(() {
                                                        countInBeatsFolderSelected =
                                                            value;
                                                      });
                                                      setState(() {
                                                        countInBeatsFolderSelected =
                                                            value;
                                                      });
                                                    },
                                                    buttonStyleData:
                                                        ButtonStyleData(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    12)),
                                                        border: Border.all(
                                                          color:
                                                              kSelectedCardColor,
                                                        ),
                                                        color:
                                                            kSelectedCardColor,
                                                      ),
                                                      elevation: 0,
                                                    ),
                                                    dropdownStyleData:
                                                        kDropdownStyleData,
                                                    dropdownSeparator:
                                                        const DropdownSeparator(
                                                      child: Divider(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                child: SizedBox(),
                                              ),
                                              const Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'Bars',
                                                  style: kDialogTitleTextStyle,
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'How long would you like the count-in to be?',
                                                  style:
                                                      kDialogDescriptionTextStyle,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        state(() {
                                                          countInDialogNumberOfBars >
                                                                  0
                                                              ? countInDialogNumberOfBars--
                                                              : countInDialogNumberOfBars =
                                                                  0;
                                                        });
                                                        setState(() {
                                                          countInDialogNumberOfBars;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            kIncrementDecrementButtonDecoration,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: const Icon(
                                                          Icons.remove,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Text(
                                                        countInDialogNumberOfBars
                                                            .toInt()
                                                            .toString(),
                                                        style:
                                                            kIncrementedDecrementedTextTextStyle,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        state(() {
                                                          countInDialogNumberOfBars <
                                                                  50
                                                              ? countInDialogNumberOfBars++
                                                              : countInDialogNumberOfBars =
                                                                  50;
                                                        });
                                                        setState(() {
                                                          countInDialogNumberOfBars;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            kIncrementDecrementButtonDecoration,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: const Icon(
                                                          Icons.add,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Expanded(
                                                child: SizedBox(),
                                              ),
                                            ],
                                          ),
                                          isFromCountIn: true,
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: Container(
                                width: kSettingsButtonWidth,
                                height: kSettingsButtonHeight,
                                decoration: BoxDecoration(
                                  color: isCountInSelected
                                      ? kSelectedCardColor
                                      : kUnSelectedCardColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Image.asset(
                                  'images/count_in.png',
                                  width: 45.0,
                                  height: 45.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),



              Expanded(
                flex: 8,
                child: SizedBox(
                  width: 300.0,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            if (autoCompleteSwitchStatus) {
                              if (recordingPlayer.playing) {
                                setState(() {
                                  resetButtonDisplayFlag = true;
                                });
                                print(
                                    'CALLED !!!!!!!!!!!! ########################################');
                                recordingPlayer.stop();
                              } else {
                                /// If recorded file isn't available.
                                if (filePath.endsWith('audio_recorded.wav') ==
                                    false) {
                                  setState(() {
                                    resetButtonDisplayFlag = false;
                                  });
                                  if (isCountInSelected) {
                                    /// Count down before recording, if 'Count-in' is selected.
                                    for (int i = 0;
                                    i < countInDialogNumberOfBars;
                                    i++) {
                                      await playMetronomeOrCountInBeats();
                                    }
                                    await ourSoundRecorder.record();
                                  } else {
                                    // Simple recording scenario.
                                    await ourSoundRecorder.record();

                                    if (isMetronomeSelected) {
                                      for (int i = 0; i < numberOfBars; i++) {
                                        if (isDrumsSelected) {
                                          await drumsPlayer.setAsset(
                                              'assets/drum_beats/$drumBeatsFolderSelected/${bpmSliderValue.toInt()}BPM.mp3');
                                          //await drumsPlayer.setLoopMode(LoopMode.all);
                                          drumsPlayer.play();
                                        }
                                        await playMetronomeOrCountInBeats();
                                      }
                                    }

                                    /// Alternate solution for elseif(isDrumsSelected).
                                    if (isDrumsSelected) {
                                      final List<AudioPlayer>
                                      drumBeatsAudioPlayersList = [];

                                      for (int i = 0; i < numberOfBars; i++) {
                                        drumBeatsAudioPlayersList
                                            .add(AudioPlayer());
                                        await drumBeatsAudioPlayersList[i].setAsset(
                                            'assets/drum_beats/$drumBeatsFolderSelected/${bpmSliderValue.toInt()}BPM.mp3');
                                      }

                                      int n = 0;
                                      List<StreamSubscription>
                                      playerSubscriptions = [];
                                      int playersCompleted = 0;

                                      Future<void> playNextPlayer(
                                          int index) async {
                                        if (index < numberOfBars) {
                                          drumBeatsAudioPlayersList[index]
                                              .play();

                                          StreamSubscription
                                          positionSubscription;
                                          positionSubscription =
                                              drumBeatsAudioPlayersList[index]
                                                  .positionStream
                                                  .listen((position) async {
                                                final duration =
                                                    drumBeatsAudioPlayersList[index]
                                                        .duration;

                                                if (duration != null) {
                                                  final remaining =
                                                      duration - position;
                                                  const timeThreshold =
                                                  Duration(milliseconds: 110);

                                                  if (remaining <= timeThreshold) {
                                                    if (index + 1 < numberOfBars) {
                                                      drumBeatsAudioPlayersList[
                                                      index + 1]
                                                          .play();
                                                      await playNextPlayer(index +
                                                          1); // Call recursively for the next player
                                                    } else {
                                                      playersCompleted++;
                                                      if (playersCompleted ==
                                                          numberOfBars) {
                                                        // All players finished
                                                        for (var sub
                                                        in playerSubscriptions) {
                                                          sub.cancel(); // Cancel all subscriptions
                                                        }

                                                        /// Stop the recording(& music) and...
                                                        await ourSoundRecorder
                                                            .stop();

                                                        /// ...play the recording.
                                                        await recordingPlayer
                                                            .setFilePath(filePath);
                                                        await recordingPlayer
                                                            .setLoopMode(
                                                            LoopMode.all);
                                                        await recordingPlayer
                                                            .play();
                                                      }
                                                    }
                                                  }
                                                }
                                              });
                                          playerSubscriptions
                                              .add(positionSubscription);
                                        }
                                      }

                                      await playNextPlayer(
                                          n); // Start the sequence
                                    }

                                  }
                                } else {
                                  /// Case when recording file is available.
                                  setState(() {
                                    resetButtonDisplayFlag = true;
                                  });
                                  print(
                                      'CALLED2222222222 !!!!!!!!!!!!!!!!!!!!! ###############');
                                  recordingPlayer.play();
                                }
                              }
                            }

                            /// ### Manual-complete Scenario.
                            else {
                              if (recordingPlayer.playing) {
                                setState(() {
                                  resetButtonDisplayFlag = true;
                                });
                                print(
                                    'CALLED !!!!!!!!!!!! ########################################');
                                recordingPlayer.stop();
                              } else {
                                if (ourSoundRecorder
                                    .flutterSoundRecorder!.isRecording) {
                                  /// Stop the recording(& music) and...
                                  await ourSoundRecorder.stop();

                                  /// play the recording...
                                  await recordingPlayer.setFilePath(filePath);
                                  await recordingPlayer
                                      .setLoopMode(LoopMode.all);
                                  await recordingPlayer.play();
                                } else {
                                  /// If recorded file isn't available.
                                  if (filePath.endsWith('audio_recorded.wav') ==
                                      false) {
                                    setState(() {
                                      resetButtonDisplayFlag = false;
                                    });
                                    if (isCountInSelected) {
                                      /// Count down before recording, if 'Count-in' is selected.
                                      for (int i = 0;
                                      i < countInDialogNumberOfBars;
                                      i++) {
                                        await playMetronomeOrCountInBeats();
                                      }
                                      await ourSoundRecorder.record();
                                    } else {
                                      // Simple recording scenario.
                                      await ourSoundRecorder.record();
                                    }
                                  } else {
                                    setState(() {
                                      resetButtonDisplayFlag = true;
                                    });
                                    print(
                                        'CALLED2222222222 !!!!!!!!!!!!!!!!!!!!! ###############');
                                    recordingPlayer.play();
                                  }
                                }
                              }
                            }
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: kContrastColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: Image.asset('images/Rec.png')),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 250.0,
                        bottom: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/bg.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              filePath = '';
                              setState(() {
                                resetButtonDisplayFlag = false;
                              });
                            },
                            icon: Image.asset('images/delete.png',width: 23,height: 23,),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/bg.png',),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              //here write code for start pause
                              setState(() {
                                // Toggle between start and pause
                                if (isPlaying) {
                                  // Pause logic here
                                  isPlaying = false;
                                  recordingPlayer.pause(); // Replace with your actual pause logic
                                } else {
                                  // Start logic here
                                  isPlaying = true;
                                  recordingPlayer.play(); // Replace with your actual start logic
                                }
                              });

                            },
                            icon: Image.asset('images/startpause.png',width: 30,height: 30,),
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
              ),

              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 6,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () {
                                if (isBarsSelected) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext buildContext) {
                                      return StatefulBuilder(
                                        builder: (context, state) => OurDialog(
                                          dialogTitle: 'Bars',
                                          dialogDescription:
                                              'Adjust the number of bars that the looper should record for',
                                          dialogContentWidget: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  state(() {
                                                    numberOfBars > 0
                                                        ? numberOfBars--
                                                        : numberOfBars = 0;
                                                  });
                                                  setState(() {
                                                    numberOfBars;
                                                  });
                                                },
                                                child: Container(
                                                  decoration:
                                                      kIncrementDecrementButtonDecoration,
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: const Icon(
                                                    Icons.remove,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Text(
                                                  numberOfBars.toString(),
                                                  style: const TextStyle(
                                                    color: kTextColor3,
                                                    fontFamily: kFontFamily,
                                                    fontSize: 40.0,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  state(() {
                                                    numberOfBars < 50
                                                        ? numberOfBars++
                                                        : numberOfBars = 50;
                                                  });
                                                  setState(() {
                                                    numberOfBars;
                                                  });
                                                },
                                                child: Container(
                                                  decoration:
                                                      kIncrementDecrementButtonDecoration,
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: const Icon(
                                                    Icons.add,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          isFromBars: true,
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    buildSnackBar(
                                        message:
                                            'Bars works with Autocomplete.'),
                                  );
                                }
                              },
                              child: Container(
                                width: kSettingsButtonWidth,
                                height: kSettingsButtonHeight,
                                decoration: BoxDecoration(
                                  color: isBarsSelected
                                      ? kSelectedCardColor
                                      : kUnSelectedCardColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    numberOfBars.toString(),
                                    style: const TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: kFontFamily,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Bars',
                              style: TextStyle(
                                fontFamily: kFontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext buildContext) {
                                    return StatefulBuilder(
                                      builder: (context, state) => OurDialog(
                                        dialogTitle: 'BPM',
                                        dialogDescription:
                                            'Use the BPM slider below to set the BPM for your loops.',
                                        dialogContentWidget: Column(
                                          children: [
                                            Expanded(
                                              child: SliderTheme(
                                                data: const SliderThemeData(
                                                  inactiveTrackColor:
                                                      Colors.white,
                                                  activeTrackColor:
                                                      Colors.white,
                                                  thumbColor: Colors.white,
                                                  thumbShape:
                                                      RoundSliderThumbShape(
                                                    enabledThumbRadius: 15.0,
                                                  ),
                                                ),
                                                child: Slider(
                                                  min: isDrumsSelected
                                                      ? drumBeatsFolderInfo[
                                                                  drumBeatsFolderSelected
                                                                      .toString()]![
                                                              'Min BPM Sound']!
                                                          .toDouble()
                                                      : 0.0,
                                                  max: isDrumsSelected
                                                      ? drumBeatsFolderInfo[
                                                                  drumBeatsFolderSelected
                                                                      .toString()]![
                                                              'Max BPM Sound']!
                                                          .toDouble()
                                                      : 300.0,
                                                  divisions: isDrumsSelected
                                                      ? (drumBeatsFolderInfo[
                                                                  drumBeatsFolderSelected
                                                                      .toString()]![
                                                              'Total Beats']! -
                                                          1)
                                                      : null,
                                                  value: isDrumsSelected
                                                      ? bpmSliderValue <
                                                              drumBeatsFolderInfo[
                                                                          drumBeatsFolderSelected
                                                                              .toString()]![
                                                                      'Min BPM Sound']!
                                                                  .toDouble()
                                                          ? drumBeatsFolderInfo[
                                                                      drumBeatsFolderSelected
                                                                          .toString()]![
                                                                  'Min BPM Sound']!
                                                              .toDouble()
                                                          : bpmSliderValue >
                                                                  drumBeatsFolderInfo[
                                                                              drumBeatsFolderSelected.toString()]![
                                                                          'Max BPM Sound']!
                                                                      .toDouble()
                                                              ? drumBeatsFolderInfo[
                                                                          drumBeatsFolderSelected
                                                                              .toString()]![
                                                                      'Max BPM Sound']!
                                                                  .toDouble()
                                                              : bpmSliderValue
                                                      : bpmSliderValue < 0.0
                                                          ? 0.0
                                                          : bpmSliderValue >
                                                                  300.0
                                                              ? 300.0
                                                              : bpmSliderValue,
                                                  onChanged:
                                                      (bpmSliderValueChanged) {
                                                    state(() {
                                                      bpmSliderValue =
                                                          bpmSliderValueChanged;
                                                    });
                                                    setState(() {
                                                      bpmSliderValue =
                                                          bpmSliderValueChanged;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      state(() {
                                                        isDrumsSelected
                                                            ? bpmSliderValue >
                                                                    drumBeatsFolderInfo[drumBeatsFolderSelected.toString()]![
                                                                            'Min BPM Sound']!
                                                                        .toDouble()
                                                                ? bpmSliderValue -=
                                                                    drumBeatsFolderInfo[drumBeatsFolderSelected.toString()]![
                                                                            'Multiples of']!
                                                                        .toDouble()
                                                                : bpmSliderValue =
                                                                    bpmSliderValue
                                                            : bpmSliderValue >
                                                                    0.0
                                                                ? bpmSliderValue--
                                                                : bpmSliderValue =
                                                                    0.0;
                                                      });
                                                      setState(() {
                                                        bpmSliderValue;
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          kIncrementDecrementButtonDecoration,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: const Icon(
                                                        Icons.remove,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Text(
                                                      bpmSliderValue
                                                          .toInt()
                                                          .toString(),
                                                      style:
                                                          kIncrementedDecrementedTextTextStyle,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      state(() {
                                                        isDrumsSelected
                                                            ? bpmSliderValue <
                                                                    drumBeatsFolderInfo[drumBeatsFolderSelected.toString()]![
                                                                            'Max BPM Sound']!
                                                                        .toDouble()
                                                                ? bpmSliderValue +=
                                                                    drumBeatsFolderInfo[drumBeatsFolderSelected.toString()]![
                                                                            'Multiples of']!
                                                                        .toDouble()
                                                                : bpmSliderValue =
                                                                    bpmSliderValue
                                                            : bpmSliderValue <
                                                                    300.0
                                                                ? bpmSliderValue++
                                                                : bpmSliderValue =
                                                                    300.0;
                                                      });
                                                      setState(() {
                                                        bpmSliderValue;
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          kIncrementDecrementButtonDecoration,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: const Icon(
                                                        Icons.add,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        isFromBPM: true,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: kSettingsButtonWidth,
                                height: kSettingsButtonHeight,
                                decoration: BoxDecoration(
                                  color: isBPMSelected
                                      ? kSelectedCardColor
                                      : kUnSelectedCardColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Center(
                                  widthFactor: 0.9,
                                  heightFactor: 0.9,
                                  child: Text(
                                    bpmSliderValue.toInt().toString(),
                                    style: const TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: kFontFamily,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'BPM',
                              style: TextStyle(
                                fontFamily: kFontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isTimingFourByFour
                                      ? isTimingFourByFour = false
                                      : isTimingFourByFour = true;
                                });
                              },
                              child: Container(
                                width: kSettingsButtonWidth,
                                height: kSettingsButtonHeight,
                                decoration: BoxDecoration(
                                  color: isTimingSelected
                                      ? kSelectedCardColor
                                      : kUnSelectedCardColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Center(
                                  widthFactor: 0.9,
                                  heightFactor: 0.9,
                                  child: Text(
                                    isTimingFourByFour ? '4/4' : '3/4',
                                    style: const TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: kFontFamily,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Timing',
                              style: TextStyle(
                                fontFamily: kFontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          'Autocomplete',
                          style: TextStyle(
                            color: kTextColor2,
                            fontFamily: kFontFamily,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CupertinoSwitch(
                          thumbColor: Colors.black,
                          activeColor: kTernaryColor,
                          value: autoCompleteSwitchStatus,
                          onChanged: (changedFlag) {
                            setState(() {
                              autoCompleteSwitchStatus = changedFlag;
                              isBarsSelected = changedFlag;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: kUnSelectedCardColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const AudioWaveformWidget(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

SnackBar buildSnackBar({String message = 'Something went wrong'}) {
  return SnackBar(
    duration: const Duration(seconds: 3),
    showCloseIcon: true,
    closeIconColor: kContrastColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    backgroundColor: Colors.white.withOpacity(0.7),
    content: Center(
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}
