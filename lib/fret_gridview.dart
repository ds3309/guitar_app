import 'package:flutter/material.dart';
import 'package:guitar_app/note_definition.dart';
import 'package:bordered_text/bordered_text.dart';

class CellData
{
  bool visible;
  Color textColor;
  final int index;
  final String note;
  final String imagePath;

  CellData({
    required this.visible,
    required this.textColor,
    required this.index,
    required this.note,
    required this.imagePath
  });
}

class FretGridView extends StatefulWidget
{
  final Function tapHandler;
  final Function callback;
  const FretGridView({
    super.key, 
    required this.tapHandler,
    required this.callback
  });

  @override
  State<FretGridView> createState() => FretGridViewState();
}

class FretGridViewState extends State<FretGridView>
{
  final int _fretCount = 12;
  final int _stringsCount = 6;

  final List<CellData> _cellList = <CellData>[];

  void clearView()
  {
    for (var item in _cellList) {
      item.visible = false;
    }
  }

  @override
  void initState()
  {
    super.initState();
    for(int i = 0; i < _fretCount * _stringsCount; i++) {
      _cellList.add(CellData(
        visible: false, 
        textColor: Colors.green, 
        index: i, 
        note: _getFretNote(i), 
        imagePath: _getImagePath(i))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 1.0, 
      childAspectRatio: 2.5, 
      shrinkWrap: true, 
      crossAxisCount: _fretCount,
      children: List.generate(_cellList.length, (index) {
        return GestureDetector(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(_cellList[index].imagePath, fit:BoxFit.cover),
              Visibility(
                visible: _cellList[index].visible,
                child: BorderedText(
                  strokeWidth: 3.0,
                  strokeColor: Colors.white,
                  child: Text(
                    _cellList[index].note,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: _cellList[index].textColor
                    ),
                  ),
                ),
              )
            ],
          ),
          onTap:() {
            if (widget.tapHandler(index)) {
              _cellList[index].visible = true;
              _cellList[index].textColor = Colors.green;
            }
            else {
              _cellList[index].visible = true;
              _cellList[index].textColor = Colors.red;
            }
            widget.callback();
          },
        );
      }),
    );
  }

  String _getImagePath(int index)
  {
    // 1弦～6弦までの弦No
    int stringNo = (index ~/ _fretCount) + 1;
    // 0(開放弦)～11フレットのNo
    int fretNo = index % _fretCount;
    switch(stringNo)
    {
      case 1: return fretNo == 0 ? 'assets/image/open1st.png' : 'assets/image/1st.png';
      case 2: return fretNo == 0 ? 'assets/image/open2nd.png' : 'assets/image/2nd.png';
      case 3:
        if(fretNo == 3 || fretNo == 5 || fretNo == 7 || fretNo == 9) {
          return 'assets/image/pos3rd.png';
        }
        else {
          return fretNo == 0 ? 'assets/image/open3rd.png' : 'assets/image/3rd.png';
        }
      case 4:
        if(fretNo == 3 || fretNo == 5 || fretNo == 7 || fretNo == 9) {
          return 'assets/image/pos4th.png';
        }
        else {
          return fretNo == 0 ? 'assets/image/open4th.png' : 'assets/image/4th.png';
        }
      case 5: return fretNo == 0 ? 'assets/image/open5th.png' : 'assets/image/5th.png';
      case 6: return fretNo == 0 ? 'assets/image/open6th.png' : 'assets/image/6th.png';
    }
    return '';
  }

  String _getFretNote(int index)
  {
    return NoteDefinition().notesMap[index];
  }
}