library ezanimation;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A class to make animations easier and more accessible to the Flutter audience
/// [Listenable] is extended for easy rebuilds when value changes
class EzAnimation extends Listenable {
  /// Begin value for [Tween] that creates the animation
  final begin;

  /// End value for [Tween] that creates the animation
  final end;

  /// Duration to pass to the [AnimationController]
  final Duration duration;

  /// Curve for when the animation goes ahead
  final Curve curve;

  /// Curve when the animation goes back
  final Curve reverseCurve;

  /// Custom Ticker Provider for not using the default TickerProvider
  CustomProvider _tickerProvider = CustomProvider();

  /// Tween to create an animation from the given values
  Tween _tween;

  /// AnimationController to control the resultant animations
  /// Making a custom implementation of how tickers function internally was unnecessary
  AnimationController _controller;

  /// The animation that the user ultimately needs
  Animation _resultAnimation;

  EzAnimation(this.begin, this.end, this.duration, {this.curve = Curves.linear, this.reverseCurve = Curves.linear}) {
    _tween = Tween(begin: begin, end: end);
    _controller = AnimationController(vsync: _tickerProvider, duration: duration);
    _resultAnimation = _tween.animate(CurvedAnimation(parent: _controller, curve: curve, reverseCurve: reverseCurve));
  }

  /// Gets current value of animation
  get value => _resultAnimation.value;

  /// Gets current progress of animation
  get progress => _controller.value;

  /// Adds a listener to the animation
  @override
  void addListener(listener) {
    _resultAnimation.addListener(listener);
  }

  /// Removes listener from the animation
  @override
  void removeListener(listener) {
    _resultAnimation.removeListener(listener);
  }

  /// Starts an animation from a value
  void start({double from}) {
    _controller.forward(from: from);
  }

  /// Ends animation
  void stop() {
    _controller.stop();
  }

  /// Reverses animation
  void reverse({double from}) {
    _controller.reverse(from: from);
  }

  /// Adds an animation listener to the result animation
  void addStatusListener(listener) {
    _resultAnimation.addStatusListener(listener);
  }

  /// Removes the animation listener to the result animation
  void removeStatusListener(listener) {
    _resultAnimation.removeStatusListener(listener);
  }

  /// Disposes ticker and controller
  void dispose() {
    _tickerProvider.dispose();
    _controller.dispose();
  }
}

/// Using a Custom [TickerProvider] helps not use a [SingleTickerProviderStateMixin] or [TickerProviderStateMixin]
/// in the app resulting in removing redundant code
class CustomProvider extends TickerProvider {
  /// Ticker that provides ticks for the controller
  Ticker _ticker;

  @override
  Ticker createTicker(onTick) {
    _ticker = Ticker(onTick);
    return _ticker;
  }

  void dispose() {
    _ticker.dispose();
  }
}