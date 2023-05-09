import 'package:flutter/widgets.dart';
import 'package:top_music/theming/app_styles.dart';

class HorizontalWrapper extends StatelessWidget {
  const HorizontalWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppStyles.sizes.screenPadding,
      ),
      child: child,
    );
  }
}
