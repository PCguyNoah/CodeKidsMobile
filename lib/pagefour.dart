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
    );
  }
}