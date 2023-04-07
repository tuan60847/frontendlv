import 'package:flutter/material.dart';
import 'package:frontendlv/values/app_color.dart';

class commentPage extends StatefulWidget {
  const commentPage({Key? key}) : super(key: key);

  @override
  State<commentPage> createState() => _commentPageState();
}

class _commentPageState extends State<commentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appbarColor,
        toolbarHeight: 100,
        title: Text('My App'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(32.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Text("Comment Page"),
      ),
    );
  }
}
