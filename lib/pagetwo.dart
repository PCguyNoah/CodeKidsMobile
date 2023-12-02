import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
                                return const ModuleTwoLearn();
                              })
                      );
                    },
                    child: Text('Learn',
                      style: TextStyle(fontSize: 20.0),)),
                SizedBox(height: 20), SizedBox(height: 20),
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
                SizedBox(height: 20), SizedBox(height: 20),
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

class Question {
  final String questionText;
  final String correctAnswer;
  final List<String> options;
  final String module;
  final int position;
  final String hint;
  String userAnswer = '';
  Question({
    required this.questionText,
    required this.correctAnswer,
    required this.options,
    required this.module,
    required this.position,
    required this.hint,
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
      hint: json['hint'] ?? 'This is a dummy hint.', // Dummy hint for testing
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
        List<Question> fetchedQuestions = jsonResponse.map((q) => Question.fromJson(q)).toList();

        if (!widget.isPractice) { // Only shuffle for tests, not for practice
          fetchedQuestions.shuffle();
          print("Questions shuffled"); // Debugging line
        }

        setState(() {
          questions = fetchedQuestions;
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


  int correctAnswers = 0;
  int incorrectAnswers = 0;

  void resetTest() {
    setState(() {
      currentQuestion = 1; // Reset to the first question
      // Optionally re-fetch questions if you want to shuffle them again
      _fetchQuestions();
    });
  }
  void _updateAnswerCount(bool isCorrect) {
    if (isCorrect) {
      correctAnswers++;
    } else {
      incorrectAnswers++;
    }
  }
  void _calculateResults() {
    int correctCount = 0;
    int incorrectCount = 0;

    for (var question in questions) {
      if (question.userAnswer == question.correctAnswer) {
        correctCount++;
      } else {
        incorrectCount++;
      }
    }

    // Show results in a dialog or another widget
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Test Results'),
          content: Text('Correct Answers: $correctCount\nIncorrect Answers: $incorrectCount'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
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
          QuestionCard(
            question: questions[currentQuestion - 1],
            onAnswerSelected: _updateAnswerCount,
            isPractice: widget.isPractice,
            isLastQuestion: currentQuestion == questions.length,
            questions: questions,  // Pass the list of questions here
          ),
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

class QuestionCard extends StatefulWidget {
  final Question question;
  final Function(bool) onAnswerSelected;
  final bool isPractice;
  final bool isLastQuestion;  // Add this line
  final List<Question> questions;
  QuestionCard({
    required this.question,
    required this.onAnswerSelected,
    required this.isPractice,
    this.isLastQuestion = false,
    required this.questions, // Add this line
  });

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? selectedOption;


  void _updateSelectedOption(String option) {
    setState(() {
      widget.question.userAnswer = option; // Update user answer in the question object
    });
  }

  void _submitAnswer() {
    bool isCorrect = widget.question.userAnswer == widget.question.correctAnswer;
    widget.onAnswerSelected(isCorrect);

    // Show a message after submission
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(isCorrect ? "Correct!" : "Wrong answer"),
    ));

    if (!widget.isPractice && widget.isLastQuestion) {
      _calculateResults(); // Call this method when the last question is submitted
    }
  }


  void _calculateResults() {
    int correctCount = 0;
    int incorrectCount = 0;

    for (var question in widget.questions) {
      if (question.userAnswer == question.correctAnswer) {
        correctCount++;
      } else {
        incorrectCount++;
      }
    }

    // Show results in a dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Test Results'),
          content: Text('Correct Answers: $correctCount\nIncorrect Answers: $incorrectCount'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartTest(); // Call to restart the test
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _restartTest() {
    // Reset user answers
    for (var question in widget.questions) {
      question.userAnswer = '';
    }

    // Reset current question index
    if (context.findAncestorStateOfType<_QuestionListState>() != null) {
      context.findAncestorStateOfType<_QuestionListState>()!.resetTest();
    }
  }

  void _showHint() {
    if (widget.isPractice) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hint'),
            content: Text(widget.question.hint),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

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
              'Question: ${widget.question.questionText}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...widget.question.options.map((option) => AnswerOption(
              option: option,
              selectedOption: widget.question.userAnswer, // Use userAnswer from the question object
              onSelection: _updateSelectedOption,
            )).toList(),
            SizedBox(height: 20),
            if (widget.isPractice || (!widget.isPractice && widget.isLastQuestion))
              ElevatedButton(
                onPressed: _submitAnswer,
                child: Text("Submit Answer"),
              ),
            SizedBox(height: 8),
            if (widget.isPractice)
              ElevatedButton(
                onPressed: _showHint,
                child: Text("Hint"),
              ),
          ],
        ),
      ),
    );
  }
}


class AnswerOption extends StatelessWidget {
  final String option;
  final String? selectedOption;
  final Function(String) onSelection;

  const AnswerOption({
    Key? key,
    required this.option,
    this.selectedOption,
    required this.onSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(option),
      leading: Radio<String>(
        value: option,
        groupValue: selectedOption,
        onChanged: (String? value) {
          onSelection(value!);
        },
      ),
    );
  }
}

