import '../resources/exports/index.dart';

class AnimatedEmtyWidget extends StatefulWidget {
  const AnimatedEmtyWidget({super.key});

  @override
  State<AnimatedEmtyWidget> createState() => _AnimatedEmtyWidgetState();
}

class _AnimatedEmtyWidgetState extends State<AnimatedEmtyWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<AlignmentGeometry> animation = Tween<AlignmentGeometry>(
    begin: Alignment.topCenter,
    end: Alignment.center,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: AlignTransition(
        alignment: animation,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildCard(),
            Positioned(
              bottom: -60,
              left: 60,
              child: _buildCard(),
            ),
          ],
        ).paddingOnly(right: 60),
      ),
    );
  }

  Container _buildCard() {
    return Container(
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 0.0),
            color: AppColors.primary.light(amount: 0.4),
            blurRadius: 20.0,
          )
        ],
      ),
      child: Container(
        height: 120,
        width: 280,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.disabled.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(45),
              ),
            ),
            SpaceH24(),
            Container(
              width: 170,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.disabled.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
