import 'package:flutter/material.dart';

import 'jagged_container.dart';

class JaggedListTile extends StatelessWidget {
  final String? imageUrl;
  const JaggedListTile({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: JaggedContainer(
        strokeWidth: 2,
        onEdit: () {},
        aspectRatio: 1.0,
        networkImage: imageUrl,
        maxHeight: 60,
      ),
    );
  }
}
