import 'package:big_ideal_app/components/brain_node_drawer.dart';
import 'package:big_ideal_app/components/ideal_create_dialog.dart';
import 'package:big_ideal_app/components/ideal_list.dart';
import 'package:flutter/material.dart';

class IdealListPage extends StatefulWidget {
  const IdealListPage({Key? key}) : super(key: key);

  @override
  State<IdealListPage> createState() => _IdealListPageState();
}

class _IdealListPageState extends State<IdealListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          '> 君は何色?',
          style: TextStyle(color: Colors.tealAccent),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.heat_pump_outlined,
              color: Colors.tealAccent,
            ),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          )
        ],
      ),
      endDrawer: const BrainNodeDrawer(),
      body: const SafeArea(
        child: IdealList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const IdealCreateDialog();
            },
          );
        },
        backgroundColor: Colors.grey.withOpacity(0.01),
        child: const Icon(
          Icons.favorite_outline,
          color: Colors.tealAccent,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
