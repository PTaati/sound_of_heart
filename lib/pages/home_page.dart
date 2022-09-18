import 'package:flutter/material.dart';
import 'package:sound_of_heart/constants/route.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sound of heart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: Routes.routes,
      home: Builder(builder: (context) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () async {
                    Navigator.pushNamed(context, RouteNames.manualPlayPage);
                  },
                  child: Image.asset(
                    'assets/images/heart_wing.png',
                    height: 200,
                  ),
                ),
              ),
              Text(
                'Sound of heart',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.pinkAccent,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
