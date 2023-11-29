import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
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

class ModuleOneLearn extends StatefulWidget {
  const ModuleOneLearn({Key? key}) : super(key: key);

  @override
  State<ModuleOneLearn> createState() => _ModuleOneLearnState();
}

class _ModuleOneLearnState extends State<ModuleOneLearn> {

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'https://www.youtube.com/watch?v=OSyjOvFbAGI',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 1: Learn'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            onReady: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
            },
            onEnded: (data) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
            },
          ),
          builder: (context, player) {
            return Align(
              alignment: Alignment.center,
              child: Container(
                child: player,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller.dispose();
    super.dispose();
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
  final String correctAnswer;
  final List<String> options;
  final String module;
  final int position;
  final String hint;

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
  int correctAnswers = 0;
  int incorrectAnswers = 0;

  void _updateAnswerCount(bool isCorrect) {
    if (isCorrect) {
      correctAnswers++;
    } else {
      incorrectAnswers++;
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
          QuestionCard(
            question: questions[currentQuestion - 1],
            onAnswerSelected: _updateAnswerCount,
            isPractice: widget.isPractice, // Pass isPractice here
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

  QuestionCard({
    required this.question,
    required this.onAnswerSelected,
    required this.isPractice,
  });

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? selectedOption;

  void _updateSelectedOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  void _submitAnswer() {
    bool isCorrect = selectedOption == widget.question.correctAnswer;
    widget.onAnswerSelected(isCorrect);

    // You can navigate to the next question or show a message here
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(isCorrect ? "Correct!" : "Wrong answer"),
    ));
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
    // No action is taken for test sessions
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
              selectedOption: selectedOption,
              onSelection: _updateSelectedOption,
            )).toList(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAnswer,
              child: Text("Submit Answer"),
            ),
            SizedBox(height: 8),
            if (widget.isPractice)  // Conditionally show the "Hint" button for practice sessions
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


