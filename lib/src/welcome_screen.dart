import 'package:flutter/material.dart';
import 'package:jb_notify/src/enums/user_type.dart';

class WelcomeScreen extends StatelessWidget {
   WelcomeScreen({Key? key}) : super(key: key);
var authenticationFlow = UserType.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/jbiet_logo.png',
                height: 100,
                width: 180,
              ),
              const SizedBox(
                width: 10.0,
              ),
              CircleAvatar(
                child: Image.asset('lib/assets/images/launcher.png'),
                backgroundColor: Colors.transparent,
                radius: 40.0,
              ),
            ],
          ),
          Image.asset('lib/assets/images/welcome_illustration.png'),
          const SizedBox(height: 15.0),
          const Text(
            'Welcome to JB-Notify',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 25.0,
            ),
          ),
          const Text('Please select an option'),
          const SizedBox(height: 5.0),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/navigation');
                },
                child: const Text(
                  'Students/Parents',
                  style: TextStyle(letterSpacing: 1.5),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              const SizedBox(height: 5.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login_screen');
                },
                child: const Text(
                  'Faculty',
                  style: TextStyle(letterSpacing: 1.5),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
