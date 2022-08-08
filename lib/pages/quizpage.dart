import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_project/pages/result_page.dart';

class GetJson extends StatelessWidget {
  const GetJson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("assets/links/python.json"),
      builder: (context, snapshot) {
        List myData = jsonDecode(snapshot.data.toString());
        if(myData.isEmpty){
          return const Scaffold(
            body: Center(
              child: Text("Loading"),
            ),
          );
        }else {
          return QuizPage(myData: myData);
        }
      },
    );
  }
}



class QuizPage extends StatefulWidget {
  final myData;
  const QuizPage({Key? key, this.myData}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState(myData: myData);
}

class _QuizPageState extends State<QuizPage> {
  final myData;
  _QuizPageState({this.myData});


  Future<bool> onTapped(bool tapped) async {
    if(tapped == true) {
      // showDialog shows a box that displays on the screen
      showDialog(
        context: context,
        // the alertDialog can't work without showDialog
        builder: (context) => AlertDialog(
          title: const Text("QuizStar"),
          content: const Text("You can't go back at this stage"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Ok"),),
          ],
        ),
      );
      return true;
    }else {
      return false;
    }
  }

  Color colorsToShow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int value = 1;
  Map<String, Color> btnColor ={
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent,
  };

  String time = "30";
  int timer = 30;
  bool cancelTimer = false;

  void startTimer() async {
    Duration oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (t) {
      setState(() {
        if(timer < 1) {
          t.cancel();
          nextQuestion();
        } else if(cancelTimer == true){
          t.cancel();
        } else {
          timer = timer - 1;
        }
        time = timer.toString();
      });
    });
  }

  void nextQuestion() {
    cancelTimer = false;
    timer = 30;
    // String key = "a";
    Color colorsToShow = Colors.indigoAccent;
    setState(() {
      if(value < 5) {
        value++;
      }else {
        cancelTimer = true;
        Navigator.pushReplacement(context,
          MaterialPageRoute(
            builder: (context) => ResultPage(),
        ),);
      }
      btnColor.updateAll((key, value) => colorsToShow);
    });
    startTimer();
  }

  void checkAnswer(String key) {
    if(myData[2][value.toString()] == myData[1][value.toString()][key]) {
      colorsToShow = right;
    }else {
      colorsToShow = wrong;
    }
    setState(() {
      btnColor[key] = colorsToShow;
      cancelTimer = true;
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Widget choiceButton(String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: MaterialButton(
        onPressed: () {
          checkAnswer(key);
          Timer(const Duration(seconds: 2), () { nextQuestion();});
        },
        color: btnColor[key],
        // this is the color that is displayed after the button has been clicked
        highlightColor: Colors.indigo,
        // this is the color thats spreads round the button after it has been clicked
        splashColor: Colors.indigo,
        minWidth: 200,
        height: 45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Text(
          myData[1][value.toString()][key],
          style: const TextStyle(
            fontSize: 16,
            fontFamily: "Alike",
            color: Colors.white,
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onTapped(true);
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(15),
                child: Text(
                  myData[0][value.toString()],
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Quando"
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                // color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    choiceButton("a"),
                    choiceButton("b"),
                    choiceButton("c"),
                    choiceButton("d"),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  // color: Colors.red,
                  alignment: Alignment.topCenter,
                  child: Text(
                    time,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Times New Roman"
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
