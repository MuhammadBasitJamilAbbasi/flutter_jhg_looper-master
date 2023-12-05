import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

const Color kScaffoldBackgroundColor = Color(0xFF1F1F1F);
const Color kContrastColor = Color(0xFFFE5D43);
const Color kTernaryColor = Color(0xFF6BCB75);

const String kFontFamily = 'Plus Jakarta Sans';

const Color kSelectedCardColor = Color(0xFF8E8E8E);
const Color kUnSelectedCardColor = Color(0xFF434343);

const Color kTextColor1 = Color(0xFFDFDFDF);
const Color kTextColor2 = Color(0xFFC4C4C4);
const Color kTextColor3 = Color(0xFFF1F1F1);
const Color kDialogTextColor = Color(0xFFC0C0C4);

const TextStyle kDialogTitleTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.w900,
  color: kDialogTextColor,
  fontFamily: kFontFamily,
);

const TextStyle kDialogDescriptionTextStyle = TextStyle(
  fontSize: 14.0,
  color: kDialogTextColor,
  fontFamily: kFontFamily,
);

const BoxDecoration kIncrementDecrementButtonDecoration = BoxDecoration(
  color: kSelectedCardColor,
  borderRadius: BorderRadius.all(
    Radius.circular(5.0),
  ),
);

const TextStyle kIncrementedDecrementedTextTextStyle = TextStyle(
  color: kTextColor3,
  fontFamily: kFontFamily,
  fontSize: 40.0,
  fontWeight: FontWeight.w700,
);

const double kSettingsButtonHeight = 65.0;
const double kSettingsButtonWidth = 60.0;

const DropdownStyleData kDropdownStyleData = DropdownStyleData(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
);
