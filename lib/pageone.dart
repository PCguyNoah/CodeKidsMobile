import 'package:flutter/material.dart';

class ModuleOnePage extends StatefulWidget {
  const ModuleOnePage({Key? key}) : super(key: key);

  @override
  State<ModuleOnePage> createState() => _ModuleOnePageState();
}

class _ModuleOnePageState extends State<ModuleOnePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 1'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
    body:SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
          Text('printf("Welcome to Module 1");',
          style: TextStyle(fontSize: 35), textAlign: TextAlign.center,),
        Text('Learn',
          style: TextStyle(fontSize: 25),),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(350, 70),
            ),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context){
                        return const ModuleOneLearn();
                      })
              );
            },
            child: Text('Learn',
              style: TextStyle(fontSize: 20.0),)),
        Text('Practice:',
          style: TextStyle(fontSize: 25),),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(350, 70),
            ),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context){
                        return const ModuleOnePractice();
                      })
              );
            },
            child: Text('Practice',
              style: TextStyle(fontSize: 20.0),)),
        Text('Test',
          style: TextStyle(fontSize: 25),),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(350, 70),
            ),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context){
                        return const ModuleOneTest();
                      })
              );
            },
            child: Text('Test',
              style: TextStyle(fontSize: 20.0),)),
        ]
          ),
        ),
      ),
    );
  }
}

class ModuleOneLearn extends StatefulWidget{
  const ModuleOneLearn({Key? key}) : super(key: key);

  @override
  State<ModuleOneLearn> createState() => _ModuleOneLearnState();
}

class _ModuleOneLearnState extends State<ModuleOneLearn> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 1: Learn'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }
}

class ModuleOnePractice extends StatefulWidget {
  const ModuleOnePractice({Key? key}) : super(key: key);

  @override
  State<ModuleOnePractice> createState() => _ModuleOnePracticeState();
}

class _ModuleOnePracticeState extends State<ModuleOnePractice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 1: Practice'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: QuestionList(moduleName: '1', isPractice: true), // Fetch questions for module 1
    );
  }
}

class ModuleOneTest extends StatefulWidget {
  const ModuleOneTest({Key? key}) : super(key: key);

  @override
  State<ModuleOneTest> createState() => _ModuleOneTestState();
}

class _ModuleOneTestState extends State<ModuleOneTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 1: Test'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: QuestionList(moduleName: '1', isPractice: false), // Fetch questions for module 1
    );
  }
}
class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question({required this.questionText, required this.options, required this.correctAnswer});
}

class QuestionList extends StatefulWidget {
  final String moduleName;
  final bool isPractice;

  QuestionList({required this.moduleName, required this.isPractice});

  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  int currentQuestion = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          QuestionCard(
            moduleName: widget.moduleName,
            questionNumber: currentQuestion,
            isPractice: widget.isPractice,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: currentQuestion > 1
                    ? () {
                  setState(() {
                    currentQuestion--;
                  });
                }
                    : null,
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: currentQuestion < 10
                    ? () {
                  setState(() {
                    currentQuestion++;
                  });
                }
                    : null,
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final String moduleName;
  final int questionNumber;
  final bool isPractice;

  QuestionCard({
    required this.moduleName,
    required this.questionNumber,
    required this.isPractice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question $questionNumber:'),
            Text('What is the correct answer?'),
            SizedBox(height: 8),
            AnswerOption(option: 'Option A'),
            AnswerOption(option: 'Option B'),
            AnswerOption(option: 'Option C'),
            AnswerOption(option: 'Option D'),
            SizedBox(height: 8),
            isPractice
                ? ElevatedButton(
              onPressed: () {
                // Handle the answer for practice
              },
              child: Text('Submit Answer'),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class AnswerOption extends StatelessWidget {
  final String option;

  AnswerOption({required this.option});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: option, groupValue: null, onChanged: null),
        Text(option),
      ],
    );
  }
}


