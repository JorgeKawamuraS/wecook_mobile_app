import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BlockMenuContainer extends StatelessWidget {
  final MaterialColor color;
  final VoidCallback? onTap;
  final bool? isSmall;
  final IconData icon;
  final String blockTittle;
  final String? blockSubLabel;
  const BlockMenuContainer({
    Key? key,
    required this.color,
    this.isSmall = false,
    required this.icon,
    required this.blockTittle,
    this.blockSubLabel = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: color[400],
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 10,
                spreadRadius: 4,
                offset: const Offset(2, 6),
              )
            ],
            gradient: AppColors.getDarkLinearGradient(color),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: isSmall! ? Alignment.centerLeft : Alignment.center,
                child: Icon(
                  icon,
                  size: isSmall! ? 60 : 120,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                blockTittle,
                maxLines: 2,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                blockSubLabel!,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ));
  }
}

class TinyBlockContainer extends StatelessWidget {
  final Color color;
  final String image;
  final String blockTittle;

  // ignore: use_key_in_widget_constructors
  const TinyBlockContainer({required this.color, required this.image, required this.blockTittle});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0.2,
            //   offset: const Offset(2, 2),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: image,
          placeholder: (context, url) => SpinKitFadingCube(
            color: AppColors.customPurple,
            size: 30,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class AppColors {
  static Map<int, Color> colorCustomPurple = {
    50: const Color.fromRGBO(142, 81, 236, 1),
    100: const Color.fromRGBO(142, 81, 236, 0.9),
    200: const Color.fromRGBO(142, 81, 236, 0.8),
    300: const Color.fromRGBO(142, 81, 236, 0.7),
    400: const Color.fromRGBO(142, 81, 236, 0.6),
    500: const Color.fromRGBO(142, 81, 236, 0.5),
    600: const Color.fromRGBO(142, 81, 236, 0.4),
    700: const Color.fromRGBO(142, 81, 236, 0.3),
    800: const Color.fromRGBO(142, 81, 236, 0.2),
    900: const Color.fromRGBO(142, 81, 236, 0.1),
  };

  static MaterialColor customPurple = MaterialColor(0xFF8E51EC, colorCustomPurple);

  static LinearGradient getDarkLinearGradient(MaterialColor color) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        color[400]!,
        color[300]!,
        color[200]!,
      ],
      stops: const [
        0.4,
        0.6,
        1,
      ],
    );
  }
}