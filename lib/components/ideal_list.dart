import 'package:big_ideal_app/components/ideal_item.dart';
import 'package:big_ideal_app/providers/ideals_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IdealList extends ConsumerWidget {
  const IdealList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideals = ref.watch(idealsProvider);
    return ideals.when(
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.tealAccent,
        ),
      ),
      error: (err, stack) => Center(child: Text('error: $err')),
      data: (ideals) {
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: ideals.length,
          itemBuilder: (BuildContext context, int index) {
            return IdealItem(
              ideal: ideals[index],
            );
          },
        );
      },
    );
  }
}
