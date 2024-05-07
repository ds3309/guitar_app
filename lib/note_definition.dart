class NoteDefinition
{
  late final List<String> scaleList;
  final List<String> notesMap = [];

  static final NoteDefinition _instance = NoteDefinition._internal();

  factory NoteDefinition() {
    return _instance;
  }

  NoteDefinition._internal() {
    scaleList = [
      'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'B'
    ];
    
    // 1弦から6弦までの開放弦の音
    var openStringNotes = ['E', 'B', 'G', 'D', 'A', 'E'];
    for (int i = 0; i < openStringNotes.length; i++)
    {
      // 開放弦の音を基準として順番に音階を配列に格納する
      String startNote = openStringNotes[i];
      int index = scaleList.indexOf(startNote);
      for (int fret = 0; fret < scaleList.length; fret++)
      {
        if(index >= scaleList.length)
        {
          index = 0;
        }
        notesMap.add(scaleList[index++]);
      }
    }
  }
}