import 'package:flutter/widgets.dart';
import 'package:top_music/common/ui/touchable/touchable.dart';

enum AppButtonType { primary, outlined }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.child,
    this.type = AppButtonType.primary,
    this.onPress,
  });

  final Widget child;
  final AppButtonType type;
  final VoidCallback? onPress;

  final BoxDecoration primaryDecoration = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0XffFF870E), Color(0xffD236D2)],
    ),
    borderRadius: BorderRadius.all(Radius.circular(62)),
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(22, 0, 0, 0),
        blurRadius: 8,
        offset: Offset(0, 4),
      )
    ],
  );

  final BoxDecoration outlinedDecoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      border: Border.fromBorderSide(
        BorderSide(
          width: 2,
          color: Color(0xffF27046),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Touchable(
      onPress: onPress,
      child: Container(
        decoration: type == AppButtonType.primary
            ? primaryDecoration
            : outlinedDecoration,
        height: 50,
        child: Center(child: child),
      ),
    );
  }
}
