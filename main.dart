import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


void main() {
  print('Starting the Flutter app...');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Human Interaction',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
 
            Image.asset(
              'images/logo.png', // Path to your image in the assets folder
              height: 250, // Adjust the height as needed
            ),
            SizedBox(height: 80), // Add some spacing between the image and buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to the LoginScreen when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20), // Add some spacing between the buttons
            ElevatedButton(
              onPressed: () {
                // Add your button's onPressed logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Login Screen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Corrected padding syntax
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png', // Path to your image in the assets folder
                height: 250, // Adjust the height as needed
            ),
            SizedBox(height: 80),
              TextField(
                decoration: InputDecoration(

                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                obscureText: true,
                decoration: InputDecoration(

                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Add your login logic here
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String?> selectedCollege = ValueNotifier<String?>(null);
    final ImagePicker _picker = ImagePicker();
    File? _image;

    final List<String> colleges = [
      'Georgia Tech',
      'University of Georgia',
      'Georgia State',
      'Other'
    ];

    Future<void> _getImage() async {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Sign Up Screen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _getImage();
                },
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey[200],
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.cover)
                      : Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'University Email',
                ),
              ),
              SizedBox(height: 20),
              ValueListenableBuilder<String?>(
                valueListenable: selectedCollege,
                builder: (context, value, child) {
                  return DropdownButtonFormField<String>(
                    value: value,
                    hint: Text('Select your college'),
                    dropdownColor: Colors.white,
                    onChanged: (String? newValue) {
                      selectedCollege.value = newValue;
                    },
                    items: colleges.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'College',
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Add your sign-up logic here
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}