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

  void _transitionRegister() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Register(),
    ));
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
              style: TextStyle(fontSize: 18),
            ),
            Container(
              width: 300, // Set the desired width
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.all(10), // Padding inside the box
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple), // Border color when focused
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

            ),
            const SizedBox(height: 16),
            const Text(
              'Password:',
              style: TextStyle(fontSize: 18),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  filled: true,            // Set to true to fill the background with a color
                  fillColor: Colors.grey,  // Background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.all(10), // Padding inside the box
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple), // Border color when focused
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: Text('Access Your Account'),
            ),
            Text(
              "Don't have an account?",
              style: TextStyle(
                color: Colors.black, // Customize the text color
              ),
            ),
            GestureDetector(
              onTap: _transitionRegister,
              child: Text(
                'Sign Up Here',
                style: TextStyle(
                  color: Colors.blue, // Customize the text color
                  decoration: TextDecoration.underline, // Add underline effect
                ),
              ),
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

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String registerStatus = '';

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
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
      setState(() {
        registerStatus = 'Registration successful';
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyApp(),
        ));
      });
    } else {
      setState(() {
        registerStatus = 'Registration failed';
      });
    }
  }
  void _transitionLogin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MyApp(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                'Username:',
                style: TextStyle(fontSize: 18),
            ),
            Container(
              width: 300, // Set the desired width
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.all(10), // Padding inside the box
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple), // Border color when focused
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

            ),
            const SizedBox(height: 16),
            const Text(
                'Password:',
                style: TextStyle(fontSize: 18),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  filled: true,            // Set to true to fill the background with a color
                  fillColor: Colors.grey,  // Background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: EdgeInsets.all(10), // Padding inside the box
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple), // Border color when focused
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _register,
              child: Text('Create Account'),
            ),
            Text(
              "Already have an account?",
              style: TextStyle(
                color: Colors.black, // Customize the text color
              ),
            ),
            GestureDetector(
              onTap: _transitionLogin,
              child: Text(
                'Login Here',
                style: TextStyle(
                  color: Colors.blue, // Customize the text color
                  decoration: TextDecoration.underline, // Add underline effect
                ),
              ),
            ),
            Text(
              registerStatus,
              style: TextStyle(
                color: registerStatus == 'Registration successful' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
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





