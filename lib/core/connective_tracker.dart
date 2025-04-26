import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityTracker extends StatefulWidget {
  final Widget child;
  final Widget? offlineWidget;

  const ConnectivityTracker(
      {super.key, required this.child, this.offlineWidget});

  @override
  State<ConnectivityTracker> createState() => _ConnectivityTrackerState();
}

class _ConnectivityTrackerState extends State<ConnectivityTracker> {
  // final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isOnline = true;

  Future<void> _initConnectivity() async {
    try {
      final List<ConnectivityResult> results =
      await Connectivity().checkConnectivity();
      _updateConnectionStatus(results);
    } catch (error) {
      debugPrint('Failed to check connectivity: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _updateConnectionStatus(result);
    });
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    if (!mounted) return;
    setState(() {
      _isOnline = results.any((result) => result != ConnectivityResult.none);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOnline && widget.offlineWidget != null) {
      return widget.offlineWidget!;
    }
    return widget.child;
  }

  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
