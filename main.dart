import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'dart:io';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
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
            const SizedBox(height: 80), // Add some spacing between the image and buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to the LoginScreen when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20), // Add some spacing between the buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to the SignupScreen when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Login Screen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png', // Path to your image in the assets folder
                height: 250, // Adjust the height as needed
              ),
              const SizedBox(height: 80),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                // Navigate to the HomePage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String?> selectedCollege = ValueNotifier<String?>(null);
    final picker.ImagePicker imagePicker = picker.ImagePicker(); // Use picker.ImagePicker
    File? image;

    final List<String> colleges = [
      'Georgia Tech',
      'University of Georgia',
      'Georgia State',
      'Other'
    ];

    Future<void> getImage() async {
      final pickedFile = await imagePicker.pickImage(source: picker.ImageSource.gallery); // Use picker.ImageSource
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
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
                  getImage();
                },
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey[200],
                  child: image != null
                      ? Image.file(image!, fit: BoxFit.cover)
                      : const Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'University Email',
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<String?>(
                valueListenable: selectedCollege,
                builder: (context, value, child) {
                  return DropdownButtonFormField<String>(
                    value: value,
                    hint: const Text('Select your college'),
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
                    decoration: const InputDecoration(
                      labelText: 'College',
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to MatchPreferencesScreen when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MatchPreferencesScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
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
              const SizedBox(
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
              const SizedBox(
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
              const SizedBox(
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
              const SizedBox(
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
              const SizedBox(
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
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Add your save profile logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Create Your Profile',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
  const MatchPreferencesScreen({super.key});

  @override
  MatchPreferencesScreenState createState() => MatchPreferencesScreenState();
}

class MatchPreferencesScreenState extends State<MatchPreferencesScreen> {
  bool openToRomance = false;
  bool openToFriendship = false;
  bool openToMeetingNewPeople = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
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
                const Text(
                  'Set Your Preferences',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Discover Radius',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Preferred Age Range',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Preferred Gender',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Divider(
                  color: Colors.grey,
                  height: 40,
                  thickness: 1,
                ),
                const Text(
                  'Terms of Engagement',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CheckboxListTile(
                  title: const Text('Open to Romance'),
                  value: openToRomance,
                  onChanged: (bool? value) {
                    setState(() {
                      openToRomance = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Open to Friendship'),
                  value: openToFriendship,
                  onChanged: (bool? value) {
                    setState(() {
                      openToFriendship = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Open to Meeting New People'),
                  value: openToMeetingNewPeople,
                  onChanged: (bool? value) {
                    setState(() {
                      openToMeetingNewPeople = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Add your save preferences logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Find Matches',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected index
  String _selectedNumber = ''; // Track the selected number

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          
          Positioned(
            top: 16,
            right: 16,
            child: Row(
              children: [
                _buildNumber('0.25 mi'),
                const SizedBox(width: 6),
                _buildNumber('0.5 mi'),
                const SizedBox(width: 6),
                _buildNumber('0.75 mi'),
                const SizedBox(width: 6),
                _buildNumber('1 mi'),
              ],
            ),
          ),
          const Positioned.fill(
            child: FullMap(), // Embed FullMap widget here
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search), // Change icon to search
            label: 'Search', // Change label to Search
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event), // Change icon to party_mode
            label: 'Parties', // Change label to Parties
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), // Change icon to settings
            label: 'Settings', // Change label to Settings
          ),
        ],
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex, // Set the current index
        onTap: (int index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });

          // Handle navigation or any other action based on the index
          switch (index) {
            case 0:
              // Handle Search navigation
              break;
            case 1:
              // Handle Parties navigation
              break;
            case 2:
              // Handle Settings navigation
              break;
          }
        },
        selectedFontSize: 16.0, // Font size for selected item's label
        unselectedFontSize: 12.0, // Font size for unselected items' labels
        selectedIconTheme: const IconThemeData(size: 32.0), // Icon size for selected item
        unselectedIconTheme: const IconThemeData(size: 24.0), // Icon size for unselected items
      ),
    );
  }

  Widget _buildNumber(String number) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNumber = number;
        });
      },
      child: Text(
        number,
        style: TextStyle(
          fontSize: _selectedNumber == number ? 16 : 13, // Adjust the font size here
          color: _selectedNumber == number ? Colors.black : Colors.blueGrey,
        ),
      ),
    );
  }
}

class FullMap extends StatefulWidget {
  const FullMap({super.key});

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapboxMap? mapboxMap;

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
  }
  @override
  Widget build(BuildContext context) {
    return MapWidget(
      key: const ValueKey("mapWidget"),
      onMapCreated: _onMapCreated,

      styleUri: 'mapbox://styles/mapbox/streets-v11',
      cameraOptions: CameraOptions(
        center: Point(
          coordinates: Position(
            37.7749,
            122.4194,
            100.0
          ),
        ),
        zoom: 12.0,
      ),
    );
  } 
}
