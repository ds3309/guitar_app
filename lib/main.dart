import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:guitar_app/fret_gridview.dart';
import 'package:guitar_app/game_manager.dart';
import 'package:flutter/rendering.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
   //DeviceOrientation.portraitUp,//上向きを許可 
   //DeviceOrientation.portraitDown,//下向きを許可
   DeviceOrientation.landscapeLeft,//左向きを許可
   DeviceOrientation.landscapeRight,//右向きを許可
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ギターの指板の音を覚える'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _question = '"   "';
  String _correctCount = "正答数：0 / 0";
  late GlobalObjectKey<FretGridViewState> _fretGridViewKey;

  final _player = AudioPlayer();
  final GameManager _manager =GameManager();

  Future<void> _buzzer(bool right) async
  {
    String audioPath = right ? "audio/buzzer_right.mp3" : "audio/buzzer_wrong.mp3";
    await _player.play(AssetSource(audioPath));
  }

  void _gameStart()
  {
    _manager.start();
    setState(() {
      _question = _manager.makeQuestion(null);
      _correctCount = '${_manager.correctCount()} / ${_manager.ansewersCount()}';
    });
  }

  void _gameStop()
  {
    _manager.stop();
    setState(() {
      _question = "";
    });
  }

  void _skip()
  {
    setState(() {
      _question = _manager.makeQuestion(_question);
      _correctCount = '${_manager.correctCount()} / ${_manager.ansewersCount()}';
    });
    _fretGridViewKey.currentState?.clearView();
  }

  bool _answer(int index)
  {
    bool ret = false;
    if (_manager.answer(index)) {
      _buzzer(true);
      ret = true;
    }
    else {
      _buzzer(false);
      ret = false;
    }
    return ret;
  }

  void _updateGameState()
  {
    if (_manager.ansewersCount() == _manager.correctCount()) {
      // すべて正解したら新しい問題を出題
      setState(() {
        _question = _manager.makeQuestion(_question);
        _correctCount = '${_manager.correctCount()} / ${_manager.ansewersCount()}';
      });
      _fretGridViewKey.currentState?.clearView();
    }
    else {
      setState(() {
        _correctCount = '${_manager.correctCount()} / ${_manager.ansewersCount()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _fretGridViewKey = GlobalObjectKey<FretGridViewState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row (
                  children: <Widget>[
                    Text(
                      '" $_question "',
                      style: const  TextStyle(
                        fontSize: 30.0
                      ),
                    ),
                    Text(_correctCount),
                  ]
                ),
              ],
            ),
            FretGridView(key:_fretGridViewKey ,tapHandler: _answer, callback: _updateGameState),
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _gameStart,
                  child: const Text('Start'),
                ),
                ElevatedButton( 
                  onPressed: _gameStop,
                  child: const Text('Stop'),
                ),
                ElevatedButton( 
                  onPressed: _skip,
                  child: const Text('Skip'),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
