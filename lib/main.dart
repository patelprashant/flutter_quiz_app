import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(QuizzlerApp());

class QuizzlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int queNumber = 0;
  int correctAns = 0;
  int wrongAns = 0;
  List<Icon> scoreKeeper = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQueText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }

  void checkAnswer(bool userAnswer) {
    setState(() {
      if (quizBrain.isFinished()) {
        Alert(
          context: context,
          title: "End of Quiz",
          content: Column(
            children: <Widget>[
              Icon(
                Icons.done_all,
                size: 64.0,
                color: Colors.green,
              ),
              Text(
                'Here is your reslut:',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Text(
                'Correct Answers:$correctAns',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.green,
                ),
              ),
              Text(
                'Wrong Answers:$wrongAns',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          buttons: [
            DialogButton(
              child: Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ).show();
        quizBrain.resetQue();
        scoreKeeper = [];
        correctAns = 0;
        wrongAns = 0;
      } else {
        if (userAnswer == quizBrain.getQueAns()) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          correctAns++;
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
          wrongAns++;
        }
      }
    });
    quizBrain.nextQue();
  }
}
