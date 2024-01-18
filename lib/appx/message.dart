import 'package:flutter/material.dart';
import 'dart:async';

void showMessage(BuildContext? context, String message,
    {int time = 2, bool useGet = true, Widget? action}) {
  var newEntry = OverlayEntry(builder: (context) => AppSnackBar(message, action));

  _OverlayWidgetState.addOverlay(newEntry);

  Timer(Duration(seconds: time), () => _OverlayWidgetState.remove(newEntry));
}

void hideMessage(BuildContext? context) {
  _OverlayWidgetState.removeAll();
}

void showSnackBar(String message, {int time = 2, bool useGet = true, Widget? trailing}){
  var newEntry = OverlayEntry(builder: (context) => AppSnackBar(message, trailing));

  _OverlayWidgetState.addOverlay(newEntry);

  Timer(Duration(seconds: time), () => _OverlayWidgetState.remove(newEntry));
}

void removeSnackbar(){
  _OverlayWidgetState.removeAll();
}

class AppSnackBar extends StatefulWidget {
  const AppSnackBar(this.message, this.trailing, {super.key});

  final String message;
  final Widget? trailing;

  @override
  State<AppSnackBar> createState() => _AppSnackBarState();
}

class _AppSnackBarState extends State<AppSnackBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).size.width - 400;
    if (padding < 32) {
      padding = 32;
    }
    return AnimatedBuilder(animation: CurvedAnimation(parent: _controller, curve: Curves.ease), builder: (context, child) => Positioned(
      bottom: (24 + MediaQuery.of(context).viewInsets.bottom) * (_controller.value * 2 - 1),
      left: padding / 2,
      right: padding / 2,
      child: Material(
        color: Theme.of(context).colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(4),
        elevation: 2,
        child: Container(
          constraints:
          const BoxConstraints(minHeight: 48, maxHeight: 104),
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Text(
                    widget.message,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    maxLines: 3,
                  )),
              if (widget.trailing != null) widget.trailing!,
              const SizedBox(
                width: 8,
              )
            ],
          ),
        ),
      ),
    ));
  }
}



class OverlayWidget extends StatefulWidget {
  const OverlayWidget(this.child, {super.key});

  final Widget child;

  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  static var overlayKey = GlobalKey<OverlayState>();

  static var entries = <OverlayEntry>[];

  static void addOverlay(OverlayEntry entry){
    if(overlayKey.currentState != null) {
      overlayKey.currentState!.insert(entry);
      entries.add(entry);
    }
  }

  static void remove(OverlayEntry entry){
    if(entries.remove(entry)) {
      entry.remove();
    }
  }

  static void removeAll(){
    for(var entry in entries){
      entry.remove();
    }
    entries.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      key: overlayKey,
      initialEntries: [OverlayEntry(builder: (context) => widget.child)],
    );
  }
}

void showDialogMessage(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: const Text("ok"))
        ],
      ));
}



void showConfirmDialog(BuildContext context, String title, String content,
    void Function() onConfirm) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: const Text("cancel")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: const Text("confirm")),
        ],
      ));
}
