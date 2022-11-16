import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'newhomepage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentindex=0;

  final List<Widget> _widgetOptions = <Widget>[
    NewHomePage(),
    ProfilePage() ,
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
           label: 'Home',
            backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.green
          ),
        ],
        onTap: (index){
          setState(() {
            currentindex=index;
          });

        },
      ),
    );
  }
}
