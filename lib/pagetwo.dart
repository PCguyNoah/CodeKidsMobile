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
    );
  }
}