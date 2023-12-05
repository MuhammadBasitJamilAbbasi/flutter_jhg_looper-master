import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';

class AudioWaveformWidget extends StatelessWidget {
  const AudioWaveformWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: // For a regular waveform
          // If you want active track for playing audio, pass [maxDuration] and [elapsedDuration]
          RectangleWaveform(
        samples: const [2.0, 10.0],
        height: 20.0,
        width: 80.0,
        maxDuration: const Duration(seconds: 10),
        elapsedDuration: const Duration(seconds: 2),
      ),
    );
  }
}
