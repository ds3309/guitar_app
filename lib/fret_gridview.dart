import 'package:flutter/material.dart';

class FretGridView extends StatelessWidget
{
  final int _indexOffset = 12;

  final int fretNo;
  final Function tapHandler;
  const FretGridView({Key? key, required this.fretNo, required this.tapHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 1.0, childAspectRatio: 2.5, shrinkWrap: true, crossAxisCount: 12,
      children: 
        List.generate(12, (index) {
          return GestureDetector(
            child: Container(
              child: Image.asset(_getImagePath(index), fit:BoxFit.cover),
            ),
            onTap:() {
              tapHandler(_calcPositionIndex(index));
            },
          );
        }),
    );
  }

  String _getImagePath(int index)
  {
    switch(fretNo)
    {
      case 1: return index == 0 ? 'assets/image/open1st.png' : 'assets/image/1st.png';
      case 2: return index == 0 ? 'assets/image/open2nd.png' : 'assets/image/2nd.png';
      case 3:
        if(index == 3 || index == 5 || index == 7 || index == 9) {
          return 'assets/image/pos3rd.png';
        }
        else {
          return index == 0 ? 'assets/image/open3rd.png' : 'assets/image/3rd.png';
        }
      case 4:
        if(index == 3 || index == 5 || index == 7 || index == 9) {
          return 'assets/image/pos4th.png';
        }
        else {
          return index == 0 ? 'assets/image/open4th.png' : 'assets/image/4th.png';
        }
      case 5: return index == 0 ? 'assets/image/open5th.png' : 'assets/image/5th.png';
      case 6: return index == 0 ? 'assets/image/open6th.png' : 'assets/image/6th.png';
    }
    return '';
  }

  int _calcPositionIndex(int index)
  {
    return ((fretNo - 1) * _indexOffset) + index;
  }
}