import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FriendColor extends StatefulWidget {
  final String color;
  final int crime;
  const FriendColor({super.key, required this.color, required this.crime});

  @override
  State<FriendColor> createState() => _FriendColorState();
}

class _FriendColorState extends State<FriendColor> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        ClipboardData data = ClipboardData(text: widget.color);
        Clipboard.setData(data);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('コピーされました'),
          backgroundColor: Colors.tealAccent,
        ));
      },
      title: Text(
        '友達: ${widget.color}',
        style: const TextStyle(color: Colors.tealAccent),
      ),
      trailing: Text(
        '犯罪係数[${widget.crime}]',
        style: const TextStyle(color: Colors.tealAccent),
      ),
    );
  }
}
