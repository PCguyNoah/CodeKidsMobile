import 'package:flutter/material.dart';

class ModuleFourPage extends StatefulWidget {
  const ModuleFourPage({Key? key}) : super(key: key);

  @override
  State<ModuleFourPage> createState() => _ModuleFourPageState();
}

class _ModuleFourPageState extends State<ModuleFourPage> {
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
                SizedBox(height: 30),
                Text('printf("Functions & Procedures");',
                  style: TextStyle(fontSize: 35), textAlign: TextAlign.center,),
                SizedBox(height: 46),

                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 70),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context){
                                return const ModuleFourLearn();
                              })
                      );
                    },
                    child: Text('Learn',
                      style: TextStyle(fontSize: 25.0),)),
                SizedBox(height: 20),

                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 70),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context){
                                return const ModuleFourPractice();
                              })
                      );
                    },
                    child: Text('Practice',
                      style: TextStyle(fontSize: 25.0),)),
                SizedBox(height: 20),

                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 70),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context){
                                return const ModuleFourTest();
                              })
                      );
                    },
                    child: Text('Test',
                      style: TextStyle(fontSize: 25.0),)),
              ]
          ),
        ),
      ),
    );
  }
}

class ModuleFourLearn extends StatefulWidget{
  const ModuleFourLearn({Key? key}) : super(key: key);

  @override
  State<ModuleFourLearn> createState() => _ModuleFourLearnState();
}

class _ModuleFourLearnState extends State<ModuleFourLearn> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 4: Learn'),
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

// Module Four - Practice
class ModuleFourPractice extends StatefulWidget {
  const ModuleFourPractice({Key? key}) : super(key: key);

  @override
  State<ModuleFourPractice> createState() => _ModuleFourPracticeState();
}

class _ModuleFourPracticeState extends State<ModuleFourPractice> {
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

// Module Four - Test
class ModuleFourTest extends StatefulWidget {
  const ModuleFourTest({Key? key}) : super(key: key);

  @override
  State<ModuleFourTest> createState() => _ModuleFourTestState();
}

class _ModuleFourTestState extends State<ModuleFourTest> {
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


