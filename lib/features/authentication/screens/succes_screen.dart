import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  final String image, title, subTitle;
  final VoidCallback onPressed;
  SuccessScreen(
      {required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Lottie.asset(image, width: MediaQuery.of(context).size.width * 0.6),
            const SizedBox(
              height: 20,
            ),

            // Title and Subtitle
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              subTitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text('Continue'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
