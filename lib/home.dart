import 'package:flutter/material.dart';

import 'package:flutter_app/app/components/iconTab.dart';

import 'package:flutter_app/app/view/index.dart';
import 'package:flutter_app/app/view/my.dart';
import 'package:flutter_app/app/view/message.dart';
import 'package:flutter_app/app/view/topic.dart';

const TAB_INDEX = {
  'home': 0,
  'topic': 1,
  'message': 2,
  'my': 3,
};

class FunApp extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<FunApp> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _controller;
  VoidCallback onChanged;

  @override
  void initState() {
    super.initState();

    _controller =
        TabController(initialIndex: _currentIndex, length: 4, vsync: this);
    onChanged = () {
      setState(() {
        _currentIndex = this._controller.index;
      });
    };

    _controller.addListener(onChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(onChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Scaffold(
        bottomNavigationBar: TabBar(
          controller: _controller,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: TextStyle(fontSize: 12.0),
          tabs: <IconTab>[
            IconTab(
                icon: _currentIndex == TAB_INDEX['home']
                    ? 'assets/tab/home_on.png'
                    : 'assets/tab/home.png',
                text: "首页",
                color: Colors.grey[900]),
            IconTab(
                icon: _currentIndex == TAB_INDEX['topic']
                    ? 'assets/tab/topic_on.png'
                    : 'assets/tab/topic.png',
                text: "发现",
                color: Colors.grey[900]),
            IconTab(
                icon: _currentIndex == TAB_INDEX['message']
                    ? 'assets/tab/message_on.png'
                    : 'assets/tab/message.png',
                text: "消息",
                color: Colors.grey[900]),
            IconTab(
                icon: _currentIndex == TAB_INDEX['my']
                    ? 'assets/tab/my_on.png'
                    : 'assets/tab/my.png',
                text: "我的",
                color: Colors.grey[900]),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            IndexPage(),
            TopicPage(),
            MessagePage(),
            MyPage(),
          ],
          controller: _controller,
        ));
    return SafeArea(
      bottom: true,
      child: SizedBox.expand(
        child: body,
      ),
    );
  }
}
