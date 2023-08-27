import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

// Widget responsible for providing the draggable, resizable, and rotatable functionality.
class board_screen_provider extends StatelessWidget {
  final Widget child;

  // Constructor for the board_screen_provider widget
  const board_screen_provider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // A ValueNotifier to manage the transformation matrix
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());

    return MatrixGestureDetector(
      // Callback for matrix updates (resize, rotate, and drag)
      onMatrixUpdate: (m, tm, sm, rm) {
        notifier.value = m;
      },
      child: AnimatedBuilder(
        animation: notifier,
        builder: (ctx, childWidget) {
          return Transform(
            transform: notifier.value,
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.contain, 
                child: child
              ),
            ),
          );
        },
      ),
    );
  }
}
