import 'package:flutter/material.dart';

class ModuleThreePage extends StatefulWidget {
  const ModuleThreePage({Key? key}) : super(key: key);

  @override
  State<ModuleThreePage> createState() => _ModuleThreePageState();
}

class _ModuleThreePageState extends State<ModuleThreePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 3'),
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
                Text('printf("Welcome to Module 3");',
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
                                return const ModuleThreeLearn();
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
                                return const ModuleThreePractice();
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
                                return const ModuleThreeTest();
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

class ModuleThreeLearn extends StatefulWidget{
  const ModuleThreeLearn({Key? key}) : super(key: key);

  @override
  State<ModuleThreeLearn> createState() => _ModuleThreeLearnState();
}

class _ModuleThreeLearnState extends State<ModuleThreeLearn> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 3: Learn'),
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
// Module Three - Practice
class ModuleThreePractice extends StatefulWidget {
  const ModuleThreePractice({Key? key}) : super(key: key);

  @override
  State<ModuleThreePractice> createState() => _ModuleThreePracticeState();
}

class _ModuleThreePracticeState extends State<ModuleThreePractice> {
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

// Module Three - Test
class ModuleThreeTest extends StatefulWidget {
  const ModuleThreeTest({Key? key}) : super(key: key);

  @override
  State<ModuleThreeTest> createState() => _ModuleThreeTestState();
}

class _ModuleThreeTestState extends State<ModuleThreeTest> {
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


