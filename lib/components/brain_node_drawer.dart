import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrainNodeDrawer extends StatefulWidget {
  const BrainNodeDrawer({super.key});

  @override
  State<BrainNodeDrawer> createState() => _BrainNodeDrawerState();
}

class _BrainNodeDrawerState extends State<BrainNodeDrawer> {
  final TextEditingController _controller = TextEditingController();

  void _initOtherNode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? node = prefs.getString('OTHER_NODE');
    if (node != null) {
      _controller.text = node;
    }
  }

  void _saveOtherNode(
    String node,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('OTHER_NODE', node);
  }

  @override
  void initState() {
    super.initState();
    _initOtherNode();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 34),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.tealAccent,
            ),
            child: Text(
              'ノード設定',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ListTile(
            title: Text(
              dotenv.env['API_SERVER'] ?? 'http://10.0.2.2:8080',
              style: const TextStyle(color: Colors.tealAccent),
            ),
          ),
          ListTile(
            title: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.tealAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.tealAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                hintText: '他のノード',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 91, 121, 114),
                ),
              ),
              cursorColor: Colors.tealAccent,
              onFieldSubmitted: (value) {
                _saveOtherNode(value.trim());
              },
            ),
          )
        ],
      ),
    );
  }
}
