import 'package:flutter/material.dart';

class IconBottomSheet extends StatelessWidget {

  final Function onPress;
  final String title;
  final String image;

  IconBottomSheet({@required this.onPress, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: InkWell(
        onTap: onPress,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image, height: 50, width: 50,),
              SizedBox(height: 10,),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
