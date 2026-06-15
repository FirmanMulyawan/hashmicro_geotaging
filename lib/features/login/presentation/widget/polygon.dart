part of login_library;

class Polygon extends StatelessWidget {
  const Polygon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -70,
      right: -100,
      child: Image.asset(
        AssetsImage.polygonTopReight,
        width: 352.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
