import 'package:flutter/material.dart';
import 'dart:async';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    _offsetAnimation = _controller
        .drive(CurveTween(curve: Curves.easeInOut))
        .drive(Tween<Offset>(
            begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        _controller.forward();
      },
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                _controller.reverse();
                Future.delayed(const Duration(milliseconds: 400), () {
                  Navigator.pop(context);
                });
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Center(
            child: Text(
              'Page 2'.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.teal,
        ),
        backgroundColor: Colors.blueGrey,
        body: SlideTransition(
          position: _offsetAnimation,
          child: Center(
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(150, 0, 0, 0),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: null,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .8,
                            height: MediaQuery.of(context).size.height * .8,
                            child: ColoredBox(color: Colors.grey),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
