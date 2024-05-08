import 'package:flutter/material.dart';
import 'package:guitar_app/note_definition.dart';

class FretCellData
{
  final bool visible;
  final String text;
  final Color textColor;

  const FretCellData({
    required this.visible,
    required this.text,
    required this.textColor
  });
}

class FretGridView extends StatefulWidget
{
  final Function tapHandler;
  const FretGridView({
    super.key, 
    required this.tapHandler
  });

  @override
  State<FretGridView> createState() => _FretGridViewState();
}
class _FretGridViewState extends State<FretGridView>
{
  final int _fretCount = 12;
  final int _stringsCount = 6;
  final List<FretCellData> fretCellList = []; 

  @override
  void initState()
  {
    super.initState();
    // todo fretCellListの初期化
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 1.0, 
      childAspectRatio: 2.5, 
      shrinkWrap: true, 
      crossAxisCount: _fretCount,
      children: 
        List.generate(_fretCount * _stringsCount, (index) {
          return GestureDetector(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(_getImagePath(index), fit:BoxFit.cover),
                Visibility(
                  visible: true,
                  child: 
                    Text(
                      _getFretNote(index),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                )
              ],
            ),
            onTap:() {
              widget.tapHandler(index);
            },
          );
        }),
    );
  }

  String _getImagePath(int index)
  {
    int stringNo = (index ~/ _fretCount) + 1;
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