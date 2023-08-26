import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchApp extends StatelessWidget {
  const SearchApp({
    super.key,
    required this.controller,
    required this.onChange,
    required this.hintText,
    required this.onPressed,
    this.boolColor = false,
  });

  final TextEditingController controller;
  final String hintText;
  final Function() onPressed;
  final Function(String)? onChange;
  final bool boolColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Expanded(
          child: TextField(
            onChanged: onChange,
            textAlign: TextAlign.start,
            controller: controller,
            keyboardType: TextInputType.text,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xffC2C0C0),

            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: hintText,
              hintStyle: GoogleFonts.cairo(fontSize: 13.sp),
              hintMaxLines: 1,
              prefixIcon: const Icon(Icons.search_rounded),
              filled: true,
              fillColor: const Color(0xffF3F7FA),
              enabledBorder: buildOutlineInputBorder(),
              focusedBorder: buildOutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          margin: EdgeInsets.only(right: 20.w),
          width: 42.w,
          height: 38.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: boolColor ? Colors.yellow : Colors.blueAccent,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.tune),
            color: boolColor ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

OutlineInputBorder buildOutlineInputBorder({Color color = Colors.transparent}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(color: color),
  );
}
