import 'package:meetingweb/utils/viewport_size.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


class ArrowButton extends StatelessWidget {
  const ArrowButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ViewportSize.width - ViewportSize.width * 0.15,
      margin: EdgeInsets.only(
        top: ViewportSize.height * 0.02,
      ),
      alignment: Alignment.centerRight,
      child: Container(
        width: ViewportSize.width * 0.155,
        height: ViewportSize.width * 0.155,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: const Color(0xFFFFFFFF),
          shadows: [
            BoxShadow(
              color: const Color(0x55000000),
              blurRadius: ViewportSize.width * 0.02,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Icon(Icons.arrow_right_alt, size: 30, color: Color(0xff3e3a63),),
      ),
    );
  }
}
