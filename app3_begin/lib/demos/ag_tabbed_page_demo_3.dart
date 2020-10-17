//This app demonstrates the TabPageSelector widget,
//in conjuntion with the TabController and TabBarView.
//No TabBar on this app.

import 'package:flutter/material.dart';

class MyThirdTabbedPage extends StatefulWidget {
  MyThirdTabbedPage({this.title, this.color});

  String title;
  Color color;
  @override
  _MyThirdTabbedPageState createState() => _MyThirdTabbedPageState();
}

class _MyThirdTabbedPageState extends State<MyThirdTabbedPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    //Instatiate a TabController.
    _tabController = TabController(vsync: this, length: choices.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;

    //if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Bottom Widget'),
        leading: IconButton(
          tooltip: 'Previous choice',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _nextPage(-1);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Next choice',
            onPressed: () {
              _nextPage(1);
            },
          ),
        ],
        //the bottom property only accepts PreferredSizeWidget types.
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Theme(
            data: Theme.of(context).copyWith(
              accentColor: Colors.white,
            ),
            child: Container(
              height: 48.0,
              alignment: Alignment.center,
              child: TabPageSelector(
                controller: _tabController,
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: choices.map((e) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ChoiceCard(
              choice: e,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({this.choice});

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              choice.icon,
              size: 128.0,
              color: textStyle.color,
            ),
            Text(
              choice.title,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
