import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
                SizedBox(height: 30),
                Text('printf("Input & Output");',
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
                                return const ModuleFiveLearn();
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
                                return const ModuleFivePractice();
                              })
                      );
                    },
                    child: Text('Practice',
                      style: TextStyle(fontSize: 25.0),)),
                SizedBox(height: 16),

                SizedBox(height: 20),
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
  final String correctAnswer;
  final List<String> options;
  final String module;
  final int position;

  Question({
    required this.questionText,
    required this.correctAnswer,
    required this.options,
    required this.module,
    required this.position,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    List<String> options = [
      json['answer'],
      json['answerChoice1'],
      json['answerChoice2'],
      json['answerChoice3']
    ]..shuffle(); // Shuffle the options

    return Question(
      questionText: json['question'],
      correctAnswer: json['answer'],
      options: options,
      module: json['module'].toString(),
      position: json['position'] as int,
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
  List<Question> questions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  _fetchQuestions() async {
    final String apiUrl = 'https://codekidz-5a5dbee745fa.herokuapp.com/api/question/get/module/${widget.moduleName}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List;
        setState(() {
          questions = jsonResponse.map((q) => Question.fromJson(q)).toList();
          isLoading = false;
        });
      } else {
        // Handle error
        print('Failed to load questions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Error fetching questions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (questions.isEmpty) {
      return Center(child: Text('No questions available.'));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          QuestionCard(question: questions[currentQuestion - 1]),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: currentQuestion > 1
                    ? () => setState(() => currentQuestion--)
                    : null,
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: currentQuestion < questions.length
                    ? () => setState(() => currentQuestion++)
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
  final Question question;

  QuestionCard({required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question: ${question.questionText}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...question.options.map((option) => AnswerOption(option: option, correctAnswer: question.correctAnswer)).toList(),
          ],
        ),
      ),
    );
  }
}

class AnswerOption extends StatefulWidget {
  final String option;
  final String correctAnswer;

  const AnswerOption({Key? key, required this.option, required this.correctAnswer}) : super(key: key);

  @override
  _AnswerOptionState createState() => _AnswerOptionState();
}

class _AnswerOptionState extends State<AnswerOption> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.option),
      leading: Radio<String>(
        value: widget.option,
        groupValue: selectedOption,
        onChanged: (String? value) {
          setState(() {
            selectedOption = value;
          });
        },
      ),
    );
  }
}




