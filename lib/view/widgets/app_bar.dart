import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App_Bar extends StatelessWidget {
  const App_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Notes",style: TextStyle(fontSize: 30.sp),),
            IconButton(onPressed: (){}, icon: Icon(Icons.settings,size: 30.sp,))
          ],
        ),
        Container(
          margin:  EdgeInsets.symmetric(horizontal: 40.w,vertical: 10.h),
          child: TextFormField(
            decoration: InputDecoration(suffixIcon: IconButton(onPressed: (){} ,icon: Icon(Icons.search,size: 25.sp)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),
              hintText: "Search...",
              hintStyle: TextStyle(fontSize: 15.sp)
            ),
          ),
        ),
      ],
    );
  }
}