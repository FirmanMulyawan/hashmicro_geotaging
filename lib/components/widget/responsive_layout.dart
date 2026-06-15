import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget Function(BuildContext, BoxConstraints, bool tablet) builder;

  const ResponsiveLayout({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;
            final isPortrait = orientation == Orientation.portrait;

            final screenSize = isPortrait ? maxHeight : maxWidth;

            final screenScale = screenSize / (isPortrait ? 800 : 360);

            final scaledConstraints = BoxConstraints(
              maxWidth: maxWidth / screenScale,
              maxHeight: maxHeight / screenScale,
            );

            bool isTablet = constraints.maxWidth > 500;

            return builder(context, scaledConstraints, isTablet);
          },
        );
      },
    );
  }
}
