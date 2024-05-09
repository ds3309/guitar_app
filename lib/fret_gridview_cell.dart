import 'package:flutter/material.dart';

class FretGridViewCell extends StatefulWidget
{
  bool visible;
  Color textColor;
  final String note;
  final String imagePath;

  FretGridViewCell({
    required this.visible,
    required this.textColor,
    required this.note,
    required this.imagePath,
  });
  
  @override
  State<FretGridViewCell> createState() => _FretGridViewCellState();
}

class _FretGridViewCellState extends State<FretGridViewCell>
{
  void setVisible(bool visible)
  {
    setState(() {
      widget.visible = visible;
    });
  }
  void setTextColor(Color color)
  {
    setState(() {
      widget.textColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(widget.imagePath, fit:BoxFit.cover),
        Visibility(
          visible: widget.visible,
          child: 
            Text(
              widget.note,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
        )
      ],
    );
  }
}