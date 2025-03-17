import 'package:flutter/material.dart';
import 'dart:async';

import 'package:sliding_pages/page2.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with SingleTickerProviderStateMixin {
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
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => Page2())).then((_) {
                    Future.delayed(
                      const Duration(milliseconds: 400),
                      () {
                        _controller.forward();
                      },
                    );
                  });
                });
              },
              icon: Icon(Icons.arrow_back, color: Colors.white,)),
          title: Center(
            child: Text(
              'Page 1'.toUpperCase(),
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
                            child: ColoredBox(
                                color: Colors.grey),
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
