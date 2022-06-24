import 'dart:convert';

import 'package:android_dev_intern/sections/forum_section.dart';
import 'package:android_dev_intern/sections/poll_section.dart';
import 'package:android_dev_intern/widgets/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'helpers/shimmer_loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? data;

  Future<void> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/user_data.json');
    setState(() => data = json.decode(jsonText));
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      loadJsonData();
    });
    super.initState();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Logo",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoSearchTextField(
                      prefixIcon: const Icon(CupertinoIcons.search,color: Colors.black,),
                      borderRadius: BorderRadius.circular(30),
                      placeholder: '',
                    )),
              ),
            ],
          ),
          if (data == null)
            Expanded(
              child: ListView.separated(
                  itemBuilder: (ctx, i) => ShimmerLoading(),
                  separatorBuilder: (ctx, i) => const Divider(
                        thickness: 1.3,
                      ),
                  itemCount: 3),
            ),
          if (data != null)
            Expanded(
              child: ListView.builder(
                itemCount: data!.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      if (data![index]['type'] == 'Polls')
                        PollSection(data![index]),
                      if (data![index]['type'] == 'Forum')
                        ForumSection(data![index]),
                    ],
                  );
                },
              ),
            ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "Pebbles",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: "Create",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mark_chat_unread_rounded),
              label: "Notifications",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              label: "Profile",
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey[200],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.redAccent,
          iconSize: 25,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}
