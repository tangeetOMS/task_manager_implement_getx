import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_path.dart';

class AppLogo extends StatefulWidget {
  const AppLogo({
    super.key,
  });

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsPath.logoSvg,
      width: 120,
    );
  }
}
