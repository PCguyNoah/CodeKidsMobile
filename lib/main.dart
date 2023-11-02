import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'CodeKids'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String loginStatus = '';

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final String apiUrl = 'https://codekidz-5a5dbee745fa.herokuapp.com/api/user/login';

    final String email = usernameController.text;
    final String password = passwordController.text;

    final Map<String, String> data = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      // Successfully logged in, display a success message.
      setState(() {
        loginStatus = response.body;
      });

      // You may want to navigate to the dashboard page here.
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DashBoard(),
      ));
    } else {
      // Login failed, display an error message.
      setState(() {
        loginStatus = response.body;
      });
    }
  }

  void _register() async {
    final String apiUrl = 'https://codekidz-5a5dbee745fa.herokuapp.com/api/user/signup';

    final String email = usernameController.text;
    final String password = passwordController.text;

    final Map<String, String> data = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      // Successfully logged in, display a success message.
      setState(() {
        loginStatus = response.body;
      });

      // You may want to navigate to the dashboard page here.
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DashBoard(),
      ));
    } else {
      // Login failed, display an error message.
      setState(() {
        loginStatus = response.body;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Username:',
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Enter your username',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Password:',
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
            Text(
              loginStatus,
              style: TextStyle(
                color: loginStatus == 'Login successful' ? Colors.green : Colors.red,
              ),
            )
          ],
        ),
      )
    );
  }
}
class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Text('Welcome to CodeKids!'),
      ),
    );
  }
}


