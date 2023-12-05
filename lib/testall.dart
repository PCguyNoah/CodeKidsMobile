import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class TestAll extends StatefulWidget {
  const TestAll({Key? key}) : super(key: key);

  @override
  State<TestAll> createState() => _TestAllState();
}

class _TestAllState extends State<TestAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test All Modules'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: QuestionList(moduleName: '1', isPractice: false), //Dummy Code
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
    try {
      final int limit = 25;
      List<Question> fetchedQuestions = [];
      Set<String> uniqueCombinations = Set();

      while (fetchedQuestions.length < limit) {
        final int randomModuleID = Random().nextInt(5) + 1;
        final int randomPosition = Random().nextInt(10) + 1;
        final String combination = '$randomModuleID/$randomPosition';

        if (!uniqueCombinations.contains(combination)) {
          final response = await http.get(
            Uri.parse('https://codekidz-5a5dbee745fa.herokuapp.com/api/question/get/$combination'),
          );

          if (response.statusCode == 200) {
            var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
            fetchedQuestions.add(Question.fromJson(jsonResponse));
            uniqueCombinations.add(combination);
          } else {
            throw Exception('Failed to load questions. Status code: ${response.statusCode}');
          }
        }
      }

      setState(() {
        questions = fetchedQuestions;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }



  int correctAnswers = 0;
  int incorrectAnswers = 0;

  void resetTest() {
    setState(() {
      currentQuestion = 1;
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
            questions: questions,
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
  final bool isLastQuestion;
  final List<Question> questions;

  QuestionCard({
    required this.question,
    required this.onAnswerSelected,
    required this.isPractice,
    this.isLastQuestion = false,
    required this.questions,
  });

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? selectedOption;

  void _updateSelectedOption(String option) {
    setState(() {
      widget.question.userAnswer = option;
    });
  }

  void _submitAnswer() {
    bool isCorrect = widget.question.userAnswer == widget.question.correctAnswer;
    widget.onAnswerSelected(isCorrect);

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
                _restartTest();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _restartTest() {
    for (var question in widget.questions) {
      question.userAnswer = '';
    }

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
              selectedOption: widget.question.userAnswer,
              onSelection: _updateSelectedOption,
            )).toList(),
            SizedBox(height: 20),
            if (widget.isPractice || (!widget.isPractice && widget.isLastQuestion))
              ElevatedButton(
                onPressed: _submitAnswer,
                child: Text("Submit Test"),
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
