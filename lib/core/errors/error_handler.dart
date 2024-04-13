import 'package:flutter/material.dart';

class ErrorHandler extends StatefulWidget {
  final Widget child;

  const ErrorHandler({
    super.key,
    required this.child,
  });

  @override
  State<ErrorHandler> createState() => _ErrorHandlerState();
}

class _ErrorHandlerState extends State<ErrorHandler> {
  void onError(FlutterErrorDetails errorDetails) {
    // Add your error handling logic here, e.g., logging, reporting to a server, etc.
    print('Caught error: ${errorDetails.exception}');
  }

  @override
  Widget build(BuildContext context) {
    return ErrorWidgetBuilder(
      builder: (context, errorDetails) {
        // Display a user-friendly error screen
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(
            child: Text('Something went wrong. Please try again later.'),
          ),
        );
      },
      onError: onError,
      child: widget.child,
    );
  }
}

class ErrorWidgetBuilder extends StatefulWidget {
  final Widget Function(BuildContext, FlutterErrorDetails) builder;
  final void Function(FlutterErrorDetails) onError;
  final Widget child;

  const ErrorWidgetBuilder({
    super.key,
    required this.builder,
    required this.onError,
    required this.child,
  });

  @override
  State<ErrorWidgetBuilder> createState() => _ErrorWidgetBuilderState();
}

class _ErrorWidgetBuilderState extends State<ErrorWidgetBuilder> {
  @override
  void initState() {
    super.initState();
    // Set up global error handling
    FlutterError.onError = widget.onError;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
