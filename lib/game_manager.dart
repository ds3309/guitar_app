import 'dart:math';

import 'package:guitar_app/note_definition.dart';

class GameManager
{
  bool _isGameStarting = false;

  List<int> _answerIndexes = [];
  List<int> _tempAnswerIndexes = [];

  void start()
  {
    if (isGameStarting()) {
      return;
    }
    _answerIndexes.clear();
    _tempAnswerIndexes.clear();
    _isGameStarting = true;
  }

  void stop()
  {
    if (!isGameStarting()) {
      return;
    }
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
    var scaleList = NoteDefinition().scaleList;
    _answerIndexes.clear();
    String note = scaleList[Random().nextInt(scaleList.length - 1)];
    if (prev != null) {
      while (note == prev) {
        note = scaleList[Random().nextInt(scaleList.length - 1)];
      }
    }
    var notesMap = NoteDefinition().notesMap;
    for (int i = 0; i < notesMap.length; i++)
    {
      if (notesMap[i] == note)
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
}