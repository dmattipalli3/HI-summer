import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as ip;
import 'dart:ui'; // For ImageFilter
import 'dart:io';

import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
//import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

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

        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/logo.png'),
                SizedBox(height: 50), // Add some spacing between the image and buttons
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
                    style: TextStyle(color: Colors.white, fontSize: 20 , fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[800],
                  ),
                ),
                SizedBox(height: 20), // Add some spacing between the buttons
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the SignupScreen when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[800],
                  ),
                ),
              ],
            ),
          ),
        )
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png'),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapScreen()),
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
    final ip.ImagePicker _picker = ip.ImagePicker();
    File? _image;

    final List<String> colleges = [
      'Georgia Tech',
      'University of Georgia',
      'Georgia State',
      'Other'
    ];

    Future<void> _getImage() async {
      final pickedFile = await _picker.pickImage(source: ip.ImageSource.gallery);
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
                  // Navigate to MatchPreferencesScreen when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MatchPreferencesScreen()),
                  );
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

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300.0,  // Set the desired width
                height: 100, // Set the desired height
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null, // Allow the TextField to expand vertically
                ),
              ),
              Container(
                width: 300.0,  // Set the desired width
                height: 100, // Set the desired height
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null, // Allow the TextField to expand vertically
                ),
              ),
              Container(
                width: 300.0,  // Set the desired width
                height: 100, // Set the desired height
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null, // Allow the TextField to expand vertically
                ),
              ),
              // Enlarged Bio TextField
              Container(
                width: 300.0,  // Set the desired width
                height: 100, // Set the desired height
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null, // Allow the TextField to expand vertically
                ),
              ),
              Container(
                width: 300.0,  // Set the desired width
                height: 100, // Set the desired height
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Hobbies/Interests',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null, // Allow the TextField to expand vertically
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Add your save profile logic here
                },
                child: Text(
                  'Create Your Profile',
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
class MatchPreferencesScreen extends StatefulWidget {
  const MatchPreferencesScreen({Key? key}) : super(key: key);

  @override
  _MatchPreferencesScreenState createState() => _MatchPreferencesScreenState();
}

class _MatchPreferencesScreenState extends State<MatchPreferencesScreen> {
  bool openToRomance = false;
  bool openToFriendship = false;
  bool openToMeetingNewPeople = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Match Preferences',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Set Your Preferences',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Discover Radius',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Preferred Age Range',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Preferred Gender',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                Divider(
                  color: Colors.grey,
                  height: 40,
                  thickness: 1,
                ),
                Text(
                  'Terms of Engagement',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CheckboxListTile(
                  title: Text('Open to Romance'),
                  value: openToRomance,
                  onChanged: (bool? value) {
                    setState(() {
                      openToRomance = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Open to Friendship'),
                  value: openToFriendship,
                  onChanged: (bool? value) {
                    setState(() {
                      openToFriendship = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Open to Meeting New People'),
                  value: openToMeetingNewPeople,
                  onChanged: (bool? value) {
                    setState(() {
                      openToMeetingNewPeople = value ?? false;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Add your save preferences logic here
                  },
                  child: Text(
                    'Find Matches',
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
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}




class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  bool _showProfileCircle = false;
  late AnimationController _slideController;
  late AnimationController _slideSettController;
  late AnimationController _slideFrenController;
  late AnimationController _fadeController;
  late Animation<Alignment> _offsetProfAnimation;
  late Animation<Alignment> _offsetSettAnimation;
  late Animation<Alignment> _offsetFrenAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300), // Duration for sliding in
      vsync: this,
    );
    _slideSettController = AnimationController(
      duration: const Duration(milliseconds: 350), // Duration for sliding in
      vsync: this,
    );
    _slideFrenController = AnimationController(
      duration: const Duration(milliseconds: 400), // Duration for sliding in
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 250), // Duration for fading
      vsync: this,
    );
    _offsetProfAnimation = Tween<Alignment>(
      begin: Alignment(-2.0, -0.4), // Start off-screen
      end: Alignment(-0.9, -0.4), // End at the final position
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.ease,// Elastic curve for bounce effect when coming in
    ));
    _offsetSettAnimation = Tween<Alignment>(
      begin: Alignment(-2.0, 0.0), // Start off-screen
      end: Alignment(-0.9, 0.0), // End at the final position
    ).animate(CurvedAnimation(
      parent: _slideSettController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.ease,// Elastic curve for bounce effect when coming in
    ));
    _offsetFrenAnimation = Tween<Alignment>(
      begin: Alignment(-2.0, 0.4), // Start off-screen
      end: Alignment(-0.9, 0.4), // End at the final position
    ).animate(CurvedAnimation(
      parent: _slideFrenController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.ease,// Elastic curve for bounce effect when coming in
    ));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
  }

  void _handleDoubleTap() {
    setState(() {
      if (_showProfileCircle) {
        _fadeController.reverse();
        _slideSettController.reverse();
        _slideFrenController.reverse();
        _slideController.reverse().then((_) {
          setState(() {
            _showProfileCircle = false;
          });
        });
      } else {
        _showProfileCircle = true;
        _fadeController.forward();
        _slideController.forward();
        _slideSettController.forward();
        _slideFrenController.forward();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     String token =
        "sk.eyJ1Ijoic2FjcmFqZWV2IiwiYSI6ImNsd2N3YXY2azB6eHcycXF0ZGNqY3ZjeXQifQ.6kvVjXFcAMSdulhvg8RDuw";
    MapboxOptions.setAccessToken(token);
    return Scaffold(
      body: Stack(
        children: [
         MapWidget(
            cameraOptions: CameraOptions(
              center: Point(coordinates: Position(-84.394838, 33.772356)),
              zoom: 18.0),
         ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                color: Colors.black.withOpacity(0.1), // Transparent container to apply the blur effect
              ),
            ),
          ),
          GestureDetector(
            onDoubleTap: _handleDoubleTap,
            child: Container(
              color: Colors.transparent,
            ),
          ),
          AlignTransition(
            alignment: _offsetProfAnimation,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/prof.png'), // Replace with your asset image path
              ),
            ),
          AlignTransition(
            alignment: _offsetSettAnimation,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/sett.png'), // Replace with your asset image path
            ),
          ),
          AlignTransition(
            alignment: _offsetFrenAnimation,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/fren.png'), // Replace with your asset image path
            ),
          ),
        ],
      ),
    );
  }
}