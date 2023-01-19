import 'dart:math';

import 'package:flutter/material.dart';

enum SpreadType {
  quarter(
    arcLength: pi / 2,
  ),
  third(
    arcLength: 2 * pi / 3,
  );

  final double arcLength;
  const SpreadType({required this.arcLength});

  double getRadius(double spaceRequired) {
    switch (this) {
      case SpreadType.quarter:
        return (spaceRequired * 2) / pi;
      case SpreadType.third:
        return (spaceRequired * 3) / (2 * pi);
    }
  }

  double getAdditionalHeight(double radius) {
    switch (this) {
      case SpreadType.quarter:
        return 0;
      case SpreadType.third:
        return radius / 2;
    }
  }
}

class ExplodingActionButton extends StatefulWidget {
  final List<FloatingActionButton> children;
  final SpreadType type;
  final FloatingActionButton? overrideMainButtonWidget;
  const ExplodingActionButton({
    required this.children,
    this.type = SpreadType.quarter,
    this.overrideMainButtonWidget,
    super.key,
  });

  @override
  State<ExplodingActionButton> createState() => ExplodingActionButtonState();
}

class ExplodingActionButtonState extends State<ExplodingActionButton> {
  final GlobalKey mainButtonKey = GlobalKey();
  bool floatingChoiceActive = false;
  double floatingActionButtonHeight = 56;
  double spacerSize = 20;
  double choiceAreaWidth = 250;
  double additionalHeight = 50;

  @override
  void initState() {
    /// (buttonDiameter + spacerSize) * button# = space
    /// circumference/4 = spaceRequired
    /// c = 2r(pi)
    /// (space * 2)/pi = r
    _initializeVariables();
    super.initState();
  }

  void _initializeVariables() {
    final double buttonSpace = floatingActionButtonHeight + spacerSize;
    final spaceRequired = buttonSpace * widget.children.length;
    choiceAreaWidth = widget.type.getRadius(spaceRequired);
    choiceAreaWidth = max(choiceAreaWidth, 2 * (floatingActionButtonHeight + spacerSize));
    additionalHeight = widget.type.getAdditionalHeight(choiceAreaWidth);
  }

  @override
  Widget build(BuildContext context) {
    _initializeVariables();

    final theme = Theme.of(context);
    final Widget mainButton = widget.overrideMainButtonWidget ?? FloatingActionButton(
      enableFeedback: false,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      elevation: 0,
      onPressed: () {
        floatingChoiceActive = !floatingChoiceActive;
        setState(() {});
      },
      backgroundColor: floatingChoiceActive //
          ? Colors.transparent
          : theme.primaryColor,
      foregroundColor: floatingChoiceActive //
          ? theme.primaryColor
          : Colors.white,
      child: const Icon(Icons.circle_outlined),
    );

    Widget child = mainButton;
    if (floatingChoiceActive) {
      child = LayoutBuilder(
        builder: (context, constraints) {
          final maxDistance = constraints.maxWidth - floatingActionButtonHeight;
          if (maxDistance.isInfinite) return mainButton;

          List<Widget> positionButtons() {
            final angleIncrement = widget.type.arcLength / (widget.children.length - 1);

            double angle = (pi / 2) * 0;
            final List<Widget> positions = [];
            for (final button in widget.children) {
              final double x = maxDistance * cos(angle) + additionalHeight;
              final double y = maxDistance * sin(angle);
              positions.add(
                Positioned(
                  bottom: x,
                  right: y,
                  child: GestureDetector(
                    onTap: () {
                      button.onPressed?.call();
                      setState(() => floatingChoiceActive = false);
                    },
                    child: AbsorbPointer(
                      absorbing: true,
                      child: button,
                    ),
                  ),
                ),
              );
              angle += angleIncrement;
            }

            return positions;
          }

          return Stack(
            children: [
              Positioned(
                bottom: additionalHeight * (constraints.maxWidth / choiceAreaWidth),
                right: 0,
                child: mainButton,
              ),
              ...positionButtons(),
            ],
          );
        },
      );
    } else {
      child = Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.zero,
          // padding: EdgeInsets.only(bottom: additionalHeight/2),
          child: mainButton,
        ),
      );
    }

    final double maxWidth = floatingChoiceActive //
        ? choiceAreaWidth
        : floatingActionButtonHeight;
    final double maxHeight = maxWidth + additionalHeight;

    const Curve curve = Curves.easeIn;
    const Duration duration = Duration(milliseconds: 200);

    return AnimatedSize(
      duration: duration,
      curve: curve,
      alignment: Alignment.bottomRight,
      child: AnimatedContainer(
        duration: duration,
        curve: curve,
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          maxWidth: maxWidth,
        ),
        // color: Colors.red,
        alignment: Alignment.bottomRight,
        child: AnimatedSwitcher(
          switchInCurve: curve,
          switchOutCurve: curve,
          duration: duration,
          child: child,
        ),
      ),
    );
  }
}
