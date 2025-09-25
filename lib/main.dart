import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => MoodModel(), child: MyApp()),
  );
}

// Mood Model - The "Brain" of our app
class MoodModel with ChangeNotifier {
  String _currentMood = '🤨';
  String get currentMood => _currentMood;
  Color _backgroundColor = Colors.green;
  final Map<String, int> _moodCounter = {"happy": 0, "sad": 0, "excited": 0};
  void setHappy() {
    _currentMood = '🙂';
    _backgroundColor = Colors.yellow;
    _moodCounter["happy"] = (_moodCounter["happy"] ?? 0) + 1;
    notifyListeners();
  }

  void setSad() {
    _currentMood = '😕';
    _backgroundColor = Colors.blue;
    _moodCounter["sad"] = (_moodCounter["sad"] ?? 0) + 1;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = '🥳';
    _backgroundColor = Colors.orange;
    _moodCounter["excited"] = (_moodCounter["excited"] ?? 0) + 1;
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
