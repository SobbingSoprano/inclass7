import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => MoodModel(), child: MyApp()),
  );
}

class MoodModel with ChangeNotifier {
  String _currentMood = '🤨';
  String get currentMood => _currentMood;

  Color _backgroundColor = Colors.green;
  Color get backgroundColor => _backgroundColor;

  final Map<String, int> _moodCounter = {"happy": 0, "sad": 0, "excited": 0};
  Map<String,int> get moodCounter => _moodCounter;

  final List<String> _moodHistory = [];
  List<String> get moodHistory => List.unmodifiable(_moodHistory);

  void _addToHistory(String mood) {
    _moodHistory.add(mood);
    if (_moodHistory.length > 3) _moodHistory.removeAt(0);
  }

  void setHappy() {
    _currentMood = '🙂';
    _backgroundColor = Colors.yellow;
    _moodCounter["happy"] = (_moodCounter["happy"] ?? 0) + 1;
    _addToHistory('🙂');
    notifyListeners();
  }

  void setSad() {
    _currentMood = '😕';
    _backgroundColor = Colors.blue;
    _moodCounter["sad"] = (_moodCounter["sad"] ?? 0) + 1;
    _addToHistory('😕');
    notifyListeners();
  }

  void setExcited() {
    _currentMood = '🥳';
    _backgroundColor = Colors.orange;
    _moodCounter["excited"] = (_moodCounter["excited"] ?? 0) + 1;
    _addToHistory('🥳');
    notifyListeners();
  }
}


// Main App Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mood Toggle Challenge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('How are you feeling?', style: TextStyle(fontSize: 24)),
            SizedBox(height: 30),
            MoodDisplay(),
            SizedBox(height: 50),
            MoodButtons(),
            SizedBox(height: 20),
            MoodCounter(),
            SizedBox(height: 20),
            MoodHistory(),
          ],
        ),
      ),
    );
  }
}

// Widget that displays the current mood
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: moodModel._backgroundColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(moodModel.currentMood, style: TextStyle(fontSize: 80)),
        );
      },
    );
  }
}

// Widget with buttons to change the mood
class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setHappy();
          },
          child: Text('🙂'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setSad();
          },
          child: Text('😕'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setExcited();
          },
          child: Text('🥳'),
        ),
      ],
    );
  }
}

class MoodCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
         if (moodModel.moodHistory.isEmpty) {
          return Text('No Mood History Yet.');
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${moodModel._moodCounter["happy"]}"),
            Text("${moodModel._moodCounter["sad"]}"),
            Text("${moodModel._moodCounter["excited"]}"),
          ],
        );
      },
    );
  }
}
class MoodHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: moodModel.moodHistory
              .map((mood) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(mood, style: TextStyle(fontSize: 40)),
                  ))
              .toList(),
        );
      },
    );
  }
}
