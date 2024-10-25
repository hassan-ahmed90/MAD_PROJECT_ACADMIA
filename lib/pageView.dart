import 'package:flutter/material.dart';
import 'package:mad_project/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageView Demo',
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                OnboardingPage(
                  imagePath: "assets/school.png",
                  color: Colors.yellowAccent,
                  text: 'Welcome to Acadmia App!',
                ),
                OnboardingPage(
                  imagePath: "assets/quiz.png",
                  color: Colors.orangeAccent,
                  text: 'Take Quiz',
                ),
                OnboardingPage(
                  imagePath: "assets/fee.png",
                  color: Colors.orange,
                  text: 'Generate recipt!',
                  showButton: true,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup01(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
          height: 10.0,
          width: _currentPage == index ? 24.0 : 12.0,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.orangeAccent : Colors.deepOrange,
            borderRadius: BorderRadius.circular(12.0),
          ),
        );
      }),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final Color color;
  final String text;
  final bool showButton;
  final VoidCallback? onPressed;
  final String imagePath;

  OnboardingPage({
    required this.color,
    required this.text,
    required this.imagePath,
    this.showButton = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath,
            fit: BoxFit.contain,
              height: 200,
              width: 200,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            if (showButton)
              ElevatedButton(
                onPressed: onPressed,
                child: Text('Sign Up'),
              ),
          ],
        ),
      ),
    );
  }
}

