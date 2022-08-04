import 'package:flutter/material.dart';
import 'match_history.dart';
import '../../shared/constants.dart';
import 'scoreboard.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class TableTabs extends StatefulWidget {
  const TableTabs({Key? key}) : super(key: key);

  @override
  TableTabsState createState() => TableTabsState();
}

class TableTabsState extends State<TableTabs>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        indicatorColor: Constants.primaryColor,
        controller: _tabController,
        tabs: const [
          Tab(
            child: Text(
              'SCOREBOARD',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Tab(
            child: Text(
              'RECENT MATCHES',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Navigator(
        key: _navKey,
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => TabBarView(
            controller: _tabController,
            children: [
              Scoreboard(),
              MatchHistory(),
            ],
          ),
        ),
      ),
    );
  }
}
