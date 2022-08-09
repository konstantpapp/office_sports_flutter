import 'package:flutter/material.dart';
import 'package:office_sports_android/src/models/navigation_keys.dart';
import 'match_history.dart';
import '../../shared/constants.dart';
import 'scoreboard.dart';

class TableTabs extends StatefulWidget {
  const TableTabs({Key? key, required this.sport}) : super(key: key);
  final int sport;

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
        key: widget.sport == 0 ? NKeys.nKey1 : NKeys.nKey2,
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => TabBarView(
            controller: _tabController,
            children: [
              Scoreboard(sport: widget.sport),
              MatchHistory(sport: widget.sport),
            ],
          ),
        ),
      ),
    );
  }
}
