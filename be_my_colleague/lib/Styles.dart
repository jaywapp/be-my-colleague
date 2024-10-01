import 'package:flutter/material.dart';

class Styles {
  static TextStyle HeaderStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
  );

  static TextStyle ContentStyle = TextStyle(
      fontSize: 16,
  );

  static TextStyle DescriptionStyle = TextStyle(
      fontSize: 13,
      decorationColor: Colors.grey,
  );

  
  static Padding CreateHeader(IconData iconData, String text) {

    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 0, 10.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
            child: Icon(iconData),
          ),
          Text(text, style: Styles.HeaderStyle)
        ],
      ),
    );
  }

  static Padding CreateContent(String text) {

    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 0, 10.0),
      child: Row(
        children: [Text(text, style: Styles.ContentStyle)],
      ),
    );
  }

  static Padding CreateDescription(String text) { 
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 0.0, 0, 10.0),
      child: Row(
        children: [Text(text, style: Styles.DescriptionStyle)],
      ),
    );
  }
}