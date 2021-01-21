import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sharesales/salesregistrationpage.dart';
import 'accountpage.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.red, Colors.purple, Colors.blue],
  ).createShader(new Rect.fromLTWH(100.0, 300.0, 300.0, 0.0));

  PageController _pageController = PageController(
    initialPage: 0,
  );
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Share Sales",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              fontStyle: FontStyle.italic,
              foreground: Paint()..shader = linearGradient),
        ),
        iconTheme: IconThemeData(color: Colors.pinkAccent),
        centerTitle: true,
      ),
      bottomNavigationBar: _bottomForm(),
      body: _pageForm(),
    );
  }

  Widget _pageForm() {
    return PageView(
      controller: _pageController,
      onPageChanged: (page) {
        setState(() {
          currentIndex = page;
        });
      },
      children: <Widget>[
        FirstPage(),
        b(),
        SalesRegistrationPage(),
        d(),
        accountPage(),
      ],
    );
  }

  Widget _bottomForm() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 25,
      selectedIconTheme: IconThemeData(size: 30),
      backgroundColor: Colors.white,
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.purple[900],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      // selectedFontSize: 20,
      // unselectedFontSize: 20,
      currentIndex: currentIndex,
      onTap: (value) {
        currentIndex = value;
        _pageController.animateToPage(value,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
        setState(() {});
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("")),
        BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined), title: Text("")),
        BottomNavigationBarItem(icon: Icon(Icons.add), title: Text("")),
        BottomNavigationBarItem(
            icon: Icon(Icons.zoom_out_map), title: Text("")),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), title: Text("")),
      ],
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
            "First",
            style: TextStyle(
                color: Colors.purple, fontSize: 200, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          )),
      color: Colors.pinkAccent,
    );
  }
}

class b extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("2"),
    );
  }
}

class d extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
