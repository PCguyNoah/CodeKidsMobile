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
        title: const Text('Module 4'),
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
                Text('printf("Welcome to Module 4");',
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
                                return const ModuleFourPage();
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
                                return const ModuleFourPage();
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
                                return const ModuleFourPage();
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