import 'package:flutter/material.dart';
import 'package:seatup_app/view/app_route/app_routes.dart';

class PageHub extends StatelessWidget {
  const PageHub({super.key});

  @override
  Widget build(BuildContext context) {
    final items = AppRoutes.menuItems; // 버튼 목록

    return Scaffold(
      appBar: AppBar(title: const Text('SeatUp - Page Hub')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = items[index];

          return SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, item.route),
              child: Align(alignment: Alignment.centerLeft, child: Text(item.title)),
            ),
          );
        },
      ),
    );
  }
}
