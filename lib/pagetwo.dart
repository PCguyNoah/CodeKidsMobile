import 'package:flutter/material.dart';

class ModuleTwoPage extends StatefulWidget {
  const ModuleTwoPage({Key? key}) : super(key: key);

  @override
  State<ModuleTwoPage> createState() => _ModuleTwoPageState();
}

class _ModuleTwoPageState extends State<ModuleTwoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Codekids'),
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
                SizedBox(height: 30),
                Text('printf("Loops");',
                  style: TextStyle(fontSize: 35), textAlign: TextAlign.center,),
                SizedBox(height: 20),  SizedBox(height: 20),

                Text('1',
                  style: TextStyle(fontSize: 25),),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 70),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context){
                                return const ModuleTwoLearn();
                              })
                      );
                    },
                    child: Text('Learn',
                      style: TextStyle(fontSize: 20.0),)),
                SizedBox(height: 20),
                Text('2',
                  style: TextStyle(fontSize: 25),),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 70),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context){
                                return const ModuleTwoPractice();
                              })
                      );
                    },
                    child: Text('Practice',
                      style: TextStyle(fontSize: 20.0),)),
                SizedBox(height: 20),
                Text('3',
                  style: TextStyle(fontSize: 25),),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 70),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context){
                                return const ModuleTwoTest();
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

class ModuleTwoLearn extends StatefulWidget{
  const ModuleTwoLearn({Key? key}) : super(key: key);

  @override
  State<ModuleTwoLearn> createState() => _ModuleTwoLearnState();
}

class _ModuleTwoLearnState extends State<ModuleTwoLearn> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 2: Learn'),
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

// Module Two - Practice
class ModuleTwoPractice extends StatefulWidget {
  const ModuleTwoPractice({Key? key}) : super(key: key);

  @override
  State<ModuleTwoPractice> createState() => _ModuleTwoPracticeState();
}

class _ModuleTwoPracticeState extends State<ModuleTwoPractice> {
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

// Module Two - Test
class ModuleTwoTest extends StatefulWidget {
  const ModuleTwoTest({Key? key}) : super(key: key);

  @override
  State<ModuleTwoTest> createState() => _ModuleTwoTestState();
}

class _ModuleTwoTestState extends State<ModuleTwoTest> {
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


