import 'package:flutter/material.dart';

/// The size of the loader indicator.
enum VmLoaderSize {
  small(16),
  medium(24),
  large(32)
  ;

  const VmLoaderSize(this.dimension);

  /// The width and height of the loader.
  final double dimension;
}

class VmLoader extends StatelessWidget {
  const VmLoader({
    super.key,
    required this.size,
    this.color,
  });

  factory VmLoader.small({Color? color}) => VmLoader(size: VmLoaderSize.small, color: color);
  factory VmLoader.medium({Color? color}) => VmLoader(size: VmLoaderSize.medium, color: color);
  factory VmLoader.large({Color? color}) => VmLoader(size: VmLoaderSize.large, color: color);

  /// The size of the loader.
  final VmLoaderSize size;

  /// The color variant of the loader.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size.dimension,
      child: RepaintBoundary(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(color),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
