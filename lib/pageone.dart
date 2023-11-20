import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
          Text('printf("Variables and Data Types");',
          style: TextStyle(fontSize: 35), textAlign: TextAlign.center,),
            SizedBox(height: 46),
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
                        return const ModuleOnePractice();
                      })
              );
            },
            child: Text('Practice',
              style: TextStyle(fontSize: 20.0),)),
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
  List<dynamic> questions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  _fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse('https://codekidz-5a5dbee745fa.herokuapp.com/api/question/get')); // Corrected endpoint

      if (response.statusCode == 200) {
        setState(() {
          questions = json.decode(response.body).where((q) => q['module'] == widget.moduleName).toList();
          isLoading = false;
        });
      } else {
        print('Failed to load questions. Status code: ${response.statusCode}');
        // Handle error
      }
    } catch (e) {
      print('Error fetching questions: $e');
      // Handle exception
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          if (questions.isNotEmpty)
            QuestionCard(question: questions[currentQuestion - 1]),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: currentQuestion > 1 ? () => setState(() => currentQuestion--) : null,
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: currentQuestion < questions.length ? () => setState(() => currentQuestion++) : null,
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
  final dynamic question;

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
            Text('Question: ${question['question']}'),
            ...(question['options'] as List).map((option) => AnswerOption(option: option)).toList(),
            // Add logic for handling practice and submitting answers if required
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