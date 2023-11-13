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
        title: const Text('Module 5'),
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
                Text('printf("Welcome to Module 5");',
                  style: TextStyle(fontSize: 35), textAlign: TextAlign.center,),
                Text('Learn',
                  style: TextStyle(fontSize: 25),),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 80),
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
                      style: TextStyle(fontSize: 20.0),)),
                Text('Practice:',
                  style: TextStyle(fontSize: 25),),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 80),
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
                      style: TextStyle(fontSize: 20.0),)),
                Text('Test',
                  style: TextStyle(fontSize: 25),),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 80),
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

class ModuleFivePractice extends StatefulWidget{
  const ModuleFivePractice({Key? key}) : super(key: key);

  @override
  State<ModuleFivePractice> createState() => _ModuleFivePracticeState();
}

class _ModuleFivePracticeState extends State<ModuleFivePractice> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 5: Practice'),
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

class ModuleFiveTest extends StatefulWidget{
  const ModuleFiveTest({Key? key}) : super(key: key);

  @override
  State<ModuleFiveTest> createState() => _ModuleFiveTestState();
}

class _ModuleFiveTestState extends State<ModuleFiveTest> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 5: Test'),
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