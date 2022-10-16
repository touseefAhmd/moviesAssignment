import 'package:flutter/material.dart';
import '../colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback callBack;
  final Color color;
  const RoundButton(
      {required this.title,
      required this.callBack,

      Key? key, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s =  MediaQuery.of(context).size;
    return InkWell(
        onTap: callBack,
        child: Container(
          height: s.height*0.08,
          width: s.width*0.45,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(color: color)),
          child: Center(child: Text(title,style: TextStyle(color: color),)),
        ));
  }
}
