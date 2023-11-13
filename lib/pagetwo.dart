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
        title: const Text('Module 2'),
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
                Text('printf("Welcome to Module 2");',
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
                                return const ModuleTwoLearn();
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
                                return const ModuleTwoPractice();
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

class ModuleTwoPractice extends StatefulWidget{
  const ModuleTwoPractice({Key? key}) : super(key: key);

  @override
  State<ModuleTwoPractice> createState() => _ModuleTwoPracticeState();
}

class _ModuleTwoPracticeState extends State<ModuleTwoPractice> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 2: Practice'),
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

class ModuleTwoTest extends StatefulWidget{
  const ModuleTwoTest({Key? key}) : super(key: key);

  @override
  State<ModuleTwoTest> createState() => _ModuleTwoTestState();
}

class _ModuleTwoTestState extends State<ModuleTwoTest> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 2: Test'),
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