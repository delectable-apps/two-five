import 'package:flutter/material.dart';
import 'package:two_five/src/navigation/two_five_navigation_bar.dart';

import 'sample_item.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  });

  static const routeName = '/items';

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    final ScrollController homeController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text('SampleItem ${item.id}'),
              leading: const CircleAvatar(
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                Navigator.restorablePushNamed(
                  context,
                  SampleItemDetailsView.routeName,
                );
              });
        },
      ),
      bottomNavigationBar: TwoFiveNavigationBar(
        homeController: homeController,
        currentIndex: 0,
      ),
    );
  }
}
