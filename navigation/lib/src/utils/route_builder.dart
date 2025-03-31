import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class RouteBuilder {
  static Route<T> withoutAnimation<T>(
    _,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    return PageRouteBuilder<T>(
      settings: page,
      barrierColor: Colors.black.withAlpha(127),
      barrierDismissible: true,
      opaque: false,
      fullscreenDialog: true,
      pageBuilder: (_, __, ___) => child,
    );
  }

  static Route<T> dismissibleDialog<T>(
    _,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    return PageRouteBuilder<T>(
      settings: page,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      opaque: false,
      fullscreenDialog: true,
      pageBuilder: (_, __, ___) => child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }

  static Route<T> modalDialogWithoutAnimation<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    return PageRouteBuilder<T>(
      settings: page,
      opaque: false,
      fullscreenDialog: true,
      pageBuilder: (_, __, ___) => child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      barrierColor: Colors.black.withAlpha(127),
    );
  }

  static Route<T> modalDialog<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    return PageRouteBuilder<T>(
      settings: page,
      opaque: false,
      barrierDismissible: true,
      fullscreenDialog: true,
      pageBuilder: (_, __, ___) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: __,
            curve: Curves.easeInOut,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.zero,
          child: _ModalRouteBuilder(
            child: child,
          ),
        ),
      ),
      reverseTransitionDuration: Duration.zero,
      barrierColor: Colors.black.withAlpha(127),
    );
  }
}

class _ModalRouteBuilder extends StatefulWidget {
  final Widget child;

  const _ModalRouteBuilder({
    required this.child,
  });

  @override
  State<_ModalRouteBuilder> createState() => _ModalRouteBuilderState();
}

class _ModalRouteBuilderState extends State<_ModalRouteBuilder> {
  final Key _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Dismissible(
        key: _key,
        direction: DismissDirection.down,
        onDismissed: (_) {
          AutoRouter.of(context).maybePop();
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
