import 'package:flutter/material.dart';
import 'package:test_project/pages/quizpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> images = [
    "assets/images/py.png",
    "assets/images/java.png",
    "assets/images/js.png",
    "assets/images/cpp.png",
    "assets/images/linux.png",
  ];

  Widget customCard(String title, String images) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const GetJson(),
            ),
          );
        },
        child: Material(
          color: Colors.indigo,
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    height: 200,
                      width: 200,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage(images,),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: "Alike",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "$title is a high-level, interpreted, general-purpose programming language. Its design philosophy emphasizes code readability with the use of significant indentation.",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  maxLines: 5,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quizstar",
          style: TextStyle(
            fontFamily: "Quando",
          ),
        ),
      ),
      body: ListView(
        children: [
          customCard("Python", images[0]),
          customCard("Java", images[1]),
          customCard("JavaScript", images[2]),
          customCard("C++", images[3]),
          customCard("Linux", images[4]),
        ],
      ),
    );
  }
}
