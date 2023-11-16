import 'package:flutter/material.dart';

class ModuleFivePage extends StatefulWidget {
  const ModuleFivePage({Key? key}) : super(key: key);

  @override
  State<ModuleFivePage> createState() => _ModuleFivePageState();
}

class _ModuleFivePageState extends State<ModuleFivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeKids'),
        centerTitle: true,
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
                SizedBox(height: 26),
                Text('printf("Welcome");',
                  style: TextStyle(fontSize: 35), textAlign: TextAlign.center,),
                SizedBox(height: 26),
                Text('get();',
                  style: TextStyle(fontSize: 25),),
                SizedBox(height: 6),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 70),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context){
                                return const ModuleFiveLearn();
                              })
                      );
                    },

                    child: Text('Learn',
                      style: TextStyle(fontSize: 25.0),)),
                SizedBox(height: 16),
                Text('while(i <10);',
                  style: TextStyle(fontSize: 25),),
                SizedBox(height: 6),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 70),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context){
                                return const ModuleFivePractice();
                              })
                      );
                    },
                    child: Text('Practice',
                      style: TextStyle(fontSize: 25.0),)),
                SizedBox(height: 16),
                Text('run(10);',
                  style: TextStyle(fontSize: 25),),
                SizedBox(height: 6),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 70),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context){
                                return const ModuleFiveTest();
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

class ModuleFiveLearn extends StatefulWidget{
  const ModuleFiveLearn({Key? key}) : super(key: key);

  @override
  State<ModuleFiveLearn> createState() => _ModuleFiveLearnState();
}

class _ModuleFiveLearnState extends State<ModuleFiveLearn> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 5: Learn'),
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

// Module Five - Practice
class ModuleFivePractice extends StatefulWidget {
  const ModuleFivePractice({Key? key}) : super(key: key);

  @override
  State<ModuleFivePractice> createState() => _ModuleFivePracticeState();
}

class _ModuleFivePracticeState extends State<ModuleFivePractice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 2: Practice'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: QuestionList(moduleName: '2', isPractice: true), // Fetch questions for module 2
    );
  }
}

// Module Five - Test
class ModuleFiveTest extends StatefulWidget {
  const ModuleFiveTest({Key? key}) : super(key: key);

  @override
  State<ModuleFiveTest> createState() => _ModuleFiveTestState();
}

class _ModuleFiveTestState extends State<ModuleFiveTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 2: Test'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: QuestionList(moduleName: '2', isPractice: false), // Fetch questions for module 2
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


