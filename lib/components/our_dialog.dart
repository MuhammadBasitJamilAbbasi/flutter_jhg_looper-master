import 'package:flutter/material.dart';
import 'package:jhg_looper/constants.dart';

class OurDialog extends StatefulWidget {
  final String dialogTitle;
  final String dialogDescription;
  final Widget dialogContentWidget;
  final bool isFromCountIn;
  final bool isFromMetronome;
  final bool isFromBars;
  final bool isFromBPM;

  const OurDialog({
    super.key,
    required this.dialogTitle,
    required this.dialogDescription,
    required this.dialogContentWidget,
    this.isFromCountIn = false,
    this.isFromMetronome = false,
    this.isFromBars = false,
    this.isFromBPM = false,
  });

  @override
  State<OurDialog> createState() => _OurDialogState();
}

class _OurDialogState extends State<OurDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Container(
        constraints: BoxConstraints.tightFor(
            height: (MediaQuery.of(context).size.height) /
                (widget.isFromCountIn ? 1.15 : 1.6)),
        decoration: const BoxDecoration(
          color: kUnSelectedCardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, top: 40.0, right: 20.0, bottom: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: widget.isFromCountIn ? 0 : 2,
                child: const SizedBox(),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  widget.dialogTitle,
                  style: kDialogTitleTextStyle,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Expanded(
                flex: widget.isFromCountIn ? 0 : 5,
                child: Text(
                  widget.dialogDescription,
                  style: kDialogDescriptionTextStyle,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Expanded(
                flex: widget.isFromCountIn
                    ? 50
                    : widget.isFromBars
                        ? 9
                        : widget.isFromBPM
                            ? 25
                            : 4,
                child: widget.dialogContentWidget,
              ),
              Expanded(
                flex: widget.isFromCountIn ? 1 : 4,
                child: const SizedBox(),
              ),
              Expanded(
                flex: widget.isFromCountIn
                    ? 7
                    : widget.isFromBPM
                        ? 6
                        : 4,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all(
                        const Size(double.infinity, 20.0)),
                    backgroundColor: MaterialStateProperty.all(
                      kContrastColor,
                    ),
                  ),
                  onPressed: () {
                    /// Todo: Get Dialog input...
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: widget.isFromCountIn ? 1 : 2,
                child: const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
