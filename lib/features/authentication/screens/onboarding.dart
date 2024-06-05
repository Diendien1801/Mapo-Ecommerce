import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store/features/authentication/screens/login.dart';
import 'package:store/utils/constants/image_string.dart';
import 'package:store/utils/constants/text_string.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _pageController = PageController();
  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
              bottom: 70,
              left: 80,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.black,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              children: [
                OnboardingPage(
                    image: ImageString.onBoardingImage1,
                    title: TextString.onBoardingTitle1,
                    description: TextString.onBoardingDescription1),
                OnboardingPage(
                    image: ImageString.onBoardingImage2,
                    title: TextString.onBoardingTitle2,
                    description: TextString.onBoardingDescription2),
                OnboardingPage(
                    image: ImageString.onBoardingImage3,
                    title: TextString.onBoardingTitle3,
                    description: TextString.onBoardingDescription3),
              ],
            ),
            Positioned(
              bottom: 50,
              right: 40,
              child: ElevatedButton(
                onPressed: () {
                  if (currentPage == 2) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  }
                  setState(() {
                    currentPage = _pageController.page!.toInt() + 1;
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                  });
                  
                },
                style: Theme.of(context).elevatedButtonTheme.style!,
                child: currentPage == 2 ?  const Text('Get Started') :  const Text("Next"),
              ),
            ),
            Positioned(
              top: 30,
              right: 30,
              child: InkWell(
                onTap: () {
                  setState(() {
                    currentPage = 2;
                    _pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  });
                  
                },
                child: Text(
                  'Skip',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class OnboardingPage extends StatelessWidget {
  String image;
  String title;
  String description;

  OnboardingPage(
      {super.key,
      required this.image,
      required this.title,
      required this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          Image.asset(
            image,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
