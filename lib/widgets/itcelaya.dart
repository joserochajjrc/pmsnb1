import 'package:flutter/material.dart';

class itcelaya{
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background_lottie;
  final Widget child;

  const itcelaya({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.child,
    this.background_lottie,
  });
  
}

class Itcelaya extends StatelessWidget {
  const Itcelaya({required this.data, Key? key}): super(key: key);

  final itcelaya data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      child: Column(
        children: [
          if (data.background_lottie != null) data.background_lottie!,
          const Spacer(flex: 3),
          Flexible(
            flex: 20,
            child: Image(image: data.image)
          ),
          const Spacer(flex: 3),
          Text(
            data.title.toUpperCase(),
            style: TextStyle(
              color: data.titleColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
            maxLines: 1,
          ),
          const Spacer(flex: 1),
          Text(
            data.subtitle,
            style: TextStyle(
              color: data.subtitleColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          const Spacer(flex: 1),
          data.child,
          const Spacer(flex: 10),
        ],
      ),
    );
  }
}