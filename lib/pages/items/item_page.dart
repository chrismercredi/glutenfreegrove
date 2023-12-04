import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/widgets.dart';
import '../../utils/utils.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  static const String routeName = '/items-page';

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    String threeParagraphsOfIpsum = IpsumGenerator.generate(3);
    return Scaffold(
      key: const Key('items-page'),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(16),
              const MassiveHeadlineText(
                text: 'Item',
              ),
              const Gap(16),
              JaggedContainer(
                strokeWidth: 4,
                onEdit: () {},
                aspectRatio: 1.0,
                networkImage: 'https://picsum.photos/600',
                maxHeight: 300,
              ),
              const Gap(8),
              const Text(
                'Username',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),
              Text(
                threeParagraphsOfIpsum,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
