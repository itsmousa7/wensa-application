import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Add this package to pubspec.yaml
import 'signup.dart';
import 'main.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _pageController = PageController();
  int currentIndex = 0;

  // Navigate to home page
  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => Signup()), // Replace with your Home Page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipRRect(
            child: Image.asset('images/profile.jpeg'),
          ),
          // PageView for swiping between intro pages
          PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              // First Page with Image and Text
              IntroPage(
                color: Theme.of(context).colorScheme.background,
                title: "Welcome to Wensa",
                subtitle: "Discover the best places and events in Iraq.",
                imagePath: 'images/road.png', // Add your image path
              ),
              // Second Page with Image and Text
              IntroPage(
                color: Theme.of(context).colorScheme.background,
                title: "Explore what to eat",
                subtitle: "Find the latest and best restaurants in iraq",
                imagePath: 'images/eat.png', // Add your image path
              ),
              // Third Page with Image and Text
              IntroPage(
                color: Theme.of(context).colorScheme.background,
                title: "Stay Connected",
                subtitle: "Get the latest places and recommendations.",
                imagePath: 'images/suitcase.png', // Add your image path
              ),
            ],
          ),

          // Skip and Explore buttons with Dots in the bottom
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Skip Button (Visible on first two pages)
                currentIndex < 2
                    ? TextButton(
                        onPressed: navigateToHome,
                        child: Text(
                          "Skip",
                          style: AppTextStyles.satoshbig(button, 20),
                        ),
                      )
                    : SizedBox.shrink(), // Hide skip button on last page

                // Dots Indicator
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.orange,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),

                // Explore Button (Visible on the third page)
                currentIndex == 2
                    ? ElevatedButton(
                        onPressed: navigateToHome,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.orange, // Button color
                        ),
                        child: Text(
                          "Explore",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )
                    : SizedBox.shrink(), // Hide explore button until last page
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for each intro page
// Widget for each intro page
class IntroPage extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String imagePath; // Add imagePath parameter

  const IntroPage({
    Key? key,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.imagePath, // Image path
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color

      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content vertically
          children: [
             ClipRRect(
               borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                child: Image.asset(
                  imagePath, // Display image from the assets
                  fit:
                      BoxFit.contain,
                  height: 400,
                ),
              ),

            SizedBox(height: 50), // Space between image and text

            // Title Text below the image
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.pageTextStyle(button, 40)
            ),
            SizedBox(height: 10), // Space between title and subtitle

            // Subtitle Text below the image
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.satoshbig(Theme.of(context).colorScheme.secondary, 20)
            ),
          ],
        ),

    );
  }
}
