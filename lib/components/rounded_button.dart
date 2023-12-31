import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {

  final Color? colour;
  final String? title;
  final Function onPressed;

  const RoundedButton({
    super.key, this.colour, this.title, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            //Go to login screen.
            onPressed.call();
          },
          minWidth: 200.0,
          height: 20.0,
          child: Text(
            title!,style: TextStyle(
            color: Colors.white,
          ),
          ),
        ),
      ),
    );
  }
}
