import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      color: Colors.white,
      child: Column(
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "Oops. I am broken...",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
              "... but I was not supposed to break here. Could you please contact my developer and say how it has happened. It would be great if you send some screenshots."),
        ],
      ),
    );
  }
}
