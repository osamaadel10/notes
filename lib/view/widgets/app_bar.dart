import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/cuibt/setting_cubit/setting_cubit.dart';

import '../screens/searchpage.dart';

class App_Bar extends StatelessWidget {
  const App_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Notes",
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                BlocBuilder<SettingCubit, SettingState>(
                  builder: (context, state) {
                    bool isDarkMode =
                        context.read<SettingCubit>().them.brightness ==
                            Brightness.dark;
                    return GestureDetector(
                      onTap: () {
                        context.read<SettingCubit>().changeTheme();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDarkMode
                              ? Colors.grey.shade800
                              : const Color.fromARGB(255, 110, 109, 109),
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode
                                  ? Colors.black.withOpacity(0.3)
                                  : const Color.fromARGB(255, 44, 43, 43).withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          isDarkMode
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: Colors.yellow,
                          size: 30.sp,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Searchpage(),
              ),
            ),
            child: TextFormField(
              readOnly: true,
              
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Searchpage(),
                ),
              ),
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                suffixIcon: IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Searchpage(),
                    ),
                  ),
                  icon: Icon(Icons.search, size: 25.sp),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "Search...",
                hintStyle: TextStyle(fontSize: 15.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
