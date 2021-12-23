import 'dart:math';

import 'package:flutter/material.dart';
import 'package:santa/friend.dart';
import 'package:santa/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsPage extends StatefulWidget {
  static const routeName = '/friends';

  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  String? _teamName;
  final List<Friend> _friends = [];
  final List<Color> _colors = [Colors.red, Colors.green, Colors.black, Colors.yellow];


  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final teamName = prefs.getString(teamNameKey);
    setState(() {
      _teamName = teamName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_teamName ?? ''),
      ),
      body: Center(
        child: ListView.separated(
          itemBuilder: _itemBuilder,
          separatorBuilder: _separatorBuilder,
          itemCount: _friends.length,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'friends',
        child: const Icon(Icons.plus_one),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(10)
        ),
        height: 100,
        child: Row(
          children: [
            const SizedBox(width: 20),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: _friends[index].color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 20),
            Text(_friends[index].name,
                style: const TextStyle(color: Colors.white))
          ],
        ));
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const SizedBox(height: 10);
  }

  Future<void> _add() async {
    final friend = Friend(_friends.length, 'My Friend', _colors[Random().nextInt(_colors.length)],
    );
    setState(() {
      _friends.add(friend);
    });
  }
}
