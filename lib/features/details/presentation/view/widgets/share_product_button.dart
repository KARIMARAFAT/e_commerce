import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProductButton extends StatelessWidget {
  const ShareProductButton({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final String shareLink =
            'https://autoswift-c3d18.web.app/products/$productId';
        final String shareMessage =
            'Look at this product on Huma Volve: $shareLink';

        await Share.share(
          shareMessage,
          subject: 'Check out this product on Huma Volve',
        );
      },
      icon: const Icon(Icons.share),
    );
  }
}
