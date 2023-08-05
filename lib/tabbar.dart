import 'dart:developer';

import 'package:chatapp/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Home extends StatefulWidget {
  final String myEmail;
  const Home({super.key, required this.myEmail});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    log('my email is ${widget.myEmail}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.photo_camera),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ],
            backgroundColor: Colors.teal,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Text(
                  '𝐂𝐡𝐚𝐭𝐬',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      letterSpacing: 1),
                ),
                Text(
                  '𝐒𝐭𝐚𝐭𝐮𝐬',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      letterSpacing: 1),
                ),
                Text(
                  '𝐂𝐚𝐥𝐥𝐬',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      letterSpacing: 1),
                ),
              ],
            ),
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'ᴜ&ɪ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  TextSpan(
                    text: '𝕔𝕙𝕒𝕥𝕤',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(children: [
            ChatPage(
              myEmail: widget.myEmail,
            ),
            Container(),
            Container(),
          ]),
        ),
      ),
    );
  }
}
