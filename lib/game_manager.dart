import 'dart:math';

class GameManager
{
  bool _isGameStarting = false;

  final List<String> _scaleList = [
    'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B'
  ];
  final List<String> _notesMap = [];
  List<int> _answerIndexes = [];
  List<int> _tempAnswerIndexes = [];

  void start()
  {
    if (isGameStarting()) {
      return;
    }
    _makeNotesMap();
    _answerIndexes.clear();
    _tempAnswerIndexes.clear();
    _isGameStarting = true;
  }

  void stop()
  {
    if (!isGameStarting()) {
      return;
    }
    _notesMap.clear();
    _answerIndexes.clear();
    _tempAnswerIndexes.clear();
    _isGameStarting = false;
  }

  bool isGameStarting()
  {
    return _isGameStarting;
  }

  int ansewersCount()
  {
    return _answerIndexes.length;
  }

  int correctCount()
  {
    return _tempAnswerIndexes.length;
  }

  // 問題作成
  String makeQuestion(String? prev)
  {
    // 音名が一致するインデックスを回答とする
    _answerIndexes.clear();
    String note = _scaleList[Random().nextInt(_scaleList.length - 1)];
    if (prev != null) {
      while (note == prev) {
        note = _scaleList[Random().nextInt(_scaleList.length - 1)];
      }
    }
    for (int i = 0; i < _notesMap.length; i++)
    {
      if (_notesMap[i] == note)
      {
        _answerIndexes.add(i);
      }
    }
    _tempAnswerIndexes.clear();
    return note;
  }

  // 回答する
  bool answer(int index)
  {
    if (_answerIndexes.contains(index))
    {
      if (!_tempAnswerIndexes.contains(index))
      {
        _tempAnswerIndexes.add(index);
      }
      return true;
    }
    return false;
  }

  // すべて正解か
  bool isAllCorrect()
  {
    for (var answer in _tempAnswerIndexes)
    {
      if (!_answerIndexes.contains(answer))
      {
        return false;
      }
    }
    return true;
  }

  // 1弦から6弦までの0～12フレットの音階を配列に格納する
  void _makeNotesMap()
  {
    // 1弦から6弦までの開放弦の音
    var openStringNotes = ['E', 'B', 'G', 'D', 'A', 'E'];
    for (int i = 0; i < openStringNotes.length; i++)
    {
      // 開放弦の音を基準として順番に音階を配列に格納する
      String startNote = openStringNotes[i];
      int index = _scaleList.indexOf(startNote);
      for (int fret = 0; fret < _scaleList.length; fret++)
      {
        if(index >= _scaleList.length)
        {
          index = 0;
        }
        _notesMap.add(_scaleList[index++]);
      }
    }
  }
}