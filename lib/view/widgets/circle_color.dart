import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleColor extends StatefulWidget {
  const CircleColor({
    super.key, required this.color , required this.index, this.isSelected
  });
  final int color;
  final int? isSelected;
  final int index;
   
  @override
  State<CircleColor> createState() => _CircleColorState();
}

class _CircleColorState extends State<CircleColor> {
  @override
  Widget build(BuildContext context) {
    return widget.isSelected == widget.index ? CircleAvatar(
      backgroundColor: Color(widget.color),
      radius: 33,
      child: Icon(Icons.check,color: Colors.white,size: 40.r,),
    ):CircleAvatar(
      backgroundColor: Color(widget.color),
      radius: 28,);
  }
}