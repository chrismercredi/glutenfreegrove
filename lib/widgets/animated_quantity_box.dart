import 'package:flutter/material.dart';

class AnimatedQuantityBox extends StatefulWidget {
  final int itemCount;

  const AnimatedQuantityBox({Key? key, required this.itemCount})
      : super(key: key);

  @override
  _AnimatedQuantityBoxState createState() => _AnimatedQuantityBoxState();
}

class _AnimatedQuantityBoxState extends State<AnimatedQuantityBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousItemCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
          milliseconds: 700), // Increased duration for the bounce effect
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);
  }

  @override
  void didUpdateWidget(AnimatedQuantityBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemCount != _previousItemCount) {
      _animateTo(widget.itemCount);
    }
  }

  void _animateTo(int targetCount) {
    _previousItemCount = targetCount.toDouble();
    _animation = Tween<double>(
      begin: _animation.value,
      end: -50.0 * targetCount, // Assuming each number has a height of 50
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve:
            Curves.elasticOut, // Using an elastic curve for the bounce effect
      ),
    )..addListener(() {
        setState(() {});
      });

    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.black,
      alignment: Alignment.center,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: child,
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              10, // Adjust the range as needed
              (index) => Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
