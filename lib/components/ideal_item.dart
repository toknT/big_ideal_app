import 'package:big_ideal_app/components/friend_color.dart';
import 'package:big_ideal_app/models/ideal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdealItem extends StatefulWidget {
  final Ideal ideal;
  const IdealItem({super.key, required this.ideal});

  @override
  State<IdealItem> createState() => _IdealItem();
}

class Free {
  final String color;
  final int crime;
  const Free({required this.color, required this.crime});
}

class _IdealItem extends State<IdealItem> {
  List<Free> _frees = [];
  void _checkColors() async {
    if (_isCheckingEmail) {
      print('_isCheckingEmail');
      return;
    }
    if (_frees.isNotEmpty) {
      setState(() {
        _frees = [];
      });
      return;
    }
    setState(() {
      _isCheckingEmail = true;
    });
    final dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 7)));
    List<String> apis = [];
    apis.add(dotenv.env['API_SERVER'] ?? 'http://10.0.2.2:8080');
    // add other node
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? node = prefs.getString('OTHER_NODE');
    if (node != null && node.trim() != '') {
      apis.add(node);
    }
    // check color
    List<Free> items = [];
    for (String api in apis) {
      String url = '$api/${widget.ideal.md5}';
      try {
        Response response = await dio.post(
          url,
          data: {
            'color': widget.ideal.color,
            'crime': widget.ideal.crime,
          },
          options: Options(
            sendTimeout: const Duration(
              seconds: 3,
            ),
          ),
        );
        for (var row in response.data) {
          if (items.any((element) => element.color == row['color'])) {
            continue;
          }
          items.add(Free(color: row['color'], crime: row['crime']));
        }
      } catch (e) {
        print('_checkColors error');
        print(e);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('エラー: $api '),
          backgroundColor: Colors.tealAccent,
        ));
      }
    }
    // set frees
    setState(() {
      _frees = items;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isCheckingEmail = false;
      });
    });
  }

  bool _isCheckingEmail = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          GestureDetector(
            onTap: _checkColors,
            child: Container(
              color: _isCheckingEmail
                  ? const Color.fromARGB(255, 91, 121, 114)
                  : Colors.transparent,
              padding: const EdgeInsets.all(6),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('>> ${widget.ideal.body}'),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.ideal.md5,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text('提供者: ${widget.ideal.color}')
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '犯罪係数[${widget.ideal.crime}]',
                        ),
                        Text(
                          '${widget.ideal.createdAt.year}.${widget.ideal.createdAt.month}.${widget.ideal.createdAt.day}',
                          style: const TextStyle(
                            color: Colors.tealAccent,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          _isCheckingEmail
              ? const LinearProgressIndicator(
                  color: Colors.tealAccent,
                  // value: 100,
                )
              : const SizedBox.shrink(),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _frees.length,
            itemBuilder: (context, index) {
              String color = _frees[index].color;
              if (color == widget.ideal.color) {
                return const SizedBox.shrink();
              }
              return FriendColor(
                color: color,
                crime: _frees[index].crime,
              );
            },
          )
        ],
      ),
    );
  }
}
