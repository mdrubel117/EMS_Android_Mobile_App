import 'package:ems_pro_max/constants/colors.dart';
import 'package:flutter/cupertino.dart';
class CustomHeadText extends StatefulWidget {
  final String text;
  const CustomHeadText({super.key,required this.text});

  @override
  State<CustomHeadText> createState() => _CustomHeadTextState();
}

class _CustomHeadTextState extends State<CustomHeadText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Text( widget.text,
                    style: TextStyle(
                        color: kLightGreen,
                        fontSize: 32,
                        fontWeight: FontWeight.w600),       
               );
        }
}