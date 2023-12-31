import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

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
    ]..shuffle();

    return Question(
      questionText: json['question'],
      correctAnswer: json['answer'],
      options: options,
      module: json['module'].toString(),
      position: json['position'] as int,
      hint: json['hint'] ?? 'This is a dummy hint.',
    );
  }
}

class QuestionFetcher {
  Future<List<Question>> fetchRandomQuestions() async {
    final Random random = Random();
    int randomModuleID = random.nextInt(5) + 1; // Random module ID between 1 and 5
    int randomPosition = random.nextInt(10) + 1; // Random position between 1 and 10

    final String apiUrl =
        'https://codekidz-5a5dbee745fa.herokuapp.com/api/question/get/$randomModuleID/$randomPosition';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        try {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse is List) {
            // Check if the response is a List
            List<Question> fetchedQuestions = jsonResponse.map((q) => Question.fromJson(q)).toList();
            return fetchedQuestions;
          } else if (jsonResponse is Map<String, dynamic>) {
            // Check if the response is a Map (single question)
            List<Question> fetchedQuestions = [Question.fromJson(jsonResponse)];
            return fetchedQuestions;
          } else {
            throw Exception('Failed to parse questions. Unexpected response format.');
          }
        } catch (e) {
          throw Exception('Error parsing questions: $e');
        }
      } else {
        throw Exception('Failed to load questions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }
}

class PracticeAll extends StatefulWidget {
  const PracticeAll({Key? key}) : super(key: key);

  @override
  State<PracticeAll> createState() => _PracticeAllState();
}

class _PracticeAllState extends State<PracticeAll> {
  late List<Question> questions;
  bool isLoading = true;
  final QuestionFetcher questionFetcher = QuestionFetcher();

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  _fetchQuestions() async {
    try {
      List<Question> fetchedQuestions = await questionFetcher.fetchRandomQuestions();

      setState(() {
        questions = fetchedQuestions;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice: Random Module and Question'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : QuestionList(questions: questions, isPractice: true),
    );
  }
}

class QuestionList extends StatefulWidget {
  final List<Question> questions;
  final bool isPractice;

  QuestionList({required this.questions, required this.isPractice});

  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  int currentQuestion = 1;
  late List<Question> questions;
  bool isLoading = true;
  final QuestionFetcher questionFetcher = QuestionFetcher();

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  _fetchQuestions() async {
    try {
      List<Question> fetchedQuestions = await questionFetcher.fetchRandomQuestions();

      setState(() {
        questions = fetchedQuestions;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }

  void resetTest() {
    setState(() {
      currentQuestion = 1;
      _fetchQuestions(); // Fetch new questions when resetting the test
    });
  }

  void _fetchNextQuestion() {
    if (currentQuestion < (questions.length - 1)) {
      setState(() {
        currentQuestion++;
      });
    } else {
      // Handle end of questions, you may choose to reset the test or show a message
      resetTest();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (widget.isPractice) {
      return SingleChildScrollView(
        child: Column(
          children: [
            QuestionCard(
              question: questions[currentQuestion - 1],
              isPractice: widget.isPractice,
              isLastQuestion: currentQuestion == questions.length,
              questions: questions,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _fetchNextQuestion, // Fetch the next question
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      // Handle non-practice scenario
      return Center(child: Text('Handle non-practice scenario here'));
    }
  }
}



class QuestionCard extends StatefulWidget {
  final Question question;
  final bool isPractice;
  final bool isLastQuestion;
  final List<Question> questions;

  QuestionCard({
    required this.question,
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



