import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kwave/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: SvgPicture.asset(
                      'assets/undraw_home-cinema_jdm1.svg',
                      width: MediaQuery.of(context).size.height * 0.5,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'KWave',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineLarge?.fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Find your next K-Drama to watch!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity > 600 ? 600 : double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () {
                  startExploreSheet(context, name);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.lightBlue,
                ),
                child: Text('Start Exploring!',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
              ),
            )
          ],
        ),
      ),
    )));
  }

  Future<dynamic> startExploreSheet(BuildContext context, String name) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  top: 20,
                  right: 20,
                  left: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text("Welcome to KWave!",
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall?.fontSize,
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(height: 10),
                const Text("Please provide your name to get started!"),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) => name = value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(name: name)));
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.lightBlue,
                    ),
                    child: Text('Get Started',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge?.fontSize,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )),
                  ),
                ),
                const SizedBox(height: 20),
              ]));
        });
  }
}
