part of appx_components;

class SliverGridDelegateWithFixedHeight extends SliverGridDelegate{
  /// Creates a delegate that makes grid layouts with a fixed item height.
  const SliverGridDelegateWithFixedHeight({
        required this.maxCrossAxisExtent,
        required this.itemHeight,
  });

  final double maxCrossAxisExtent;

  final double itemHeight;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final width = constraints.crossAxisExtent;
    var crossItems = width ~/ maxCrossAxisExtent;
    if (width % maxCrossAxisExtent != 0) {
      crossItems += 1;
    }
    return SliverGridRegularTileLayout(
      crossAxisCount: crossItems,
      mainAxisStride: itemHeight,
      crossAxisStride: width / crossItems,
      childMainAxisExtent: itemHeight,
      childCrossAxisExtent: width / crossItems,
      reverseCrossAxis: false
    );
  }

  @override
  bool shouldRelayout(covariant SliverGridDelegate oldDelegate) {
    if(oldDelegate is! SliverGridDelegateWithFixedHeight) return true;
    if(oldDelegate.maxCrossAxisExtent != maxCrossAxisExtent
        || oldDelegate.itemHeight != itemHeight){
      return true;
    }
    return false;
  }

}