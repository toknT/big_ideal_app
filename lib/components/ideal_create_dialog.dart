import 'package:big_ideal_app/providers/ideals_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdealCreateDialog extends HookConsumerWidget {
  const IdealCreateDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> createIdeal(
      String body,
      int crime,
      String color,
    ) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('USER_EMAIL', color);
      ref.read(idealsProvider.notifier).insert(body, crime, color);
    }

    final body = useState('');
    final color = useState('');
    final crime = useState(100);
    final controller = useTextEditingController();

    void initUserSetting() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('USER_EMAIL');
      if (email != null) {
        color.value = email;
        controller.text = color.value;
      }
    }

    useEffect(() {
      initUserSetting();
      return null;
    }, []);

    return AlertDialog(
      content: SizedBox(
        height: 300,
        width: 200,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                maxLines: 2,
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
                  hintText: 'メッセージ',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 91, 121, 114)),
                ),
                cursorColor: Colors.tealAccent,
                autofocus: true,
                onChanged: (value) {
                  body.value = value.trim();
                },
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                '>> 犯罪係数[${crime.value}]',
              ),
              Slider(
                value: crime.value.toDouble(),
                max: 1000,
                divisions: 1000,
                min: 0,
                onChanged: (value) {
                  crime.value = value.toInt();
                },
                activeColor: Colors.tealAccent,
              ),
              TextFormField(
                controller: controller,
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
                  hintText: '君の色',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 91, 121, 114),
                  ),
                ),
                cursorColor: Colors.tealAccent,
                onChanged: (value) {
                  color.value = value.trim();
                },
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                '君の色、メールアドレスなど',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: body.value == '' || color.value == ''
                        ? null
                        : () {
                            createIdeal(body.value, crime.value, color.value)
                                .then((value) {
                              Navigator.of(context).pop();
                            });
                          },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.tealAccent,
                      disabledForegroundColor:
                          const Color.fromARGB(255, 91, 121, 114),
                    ),
                    child: const Text('自白する'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
