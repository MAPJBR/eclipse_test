
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_to_eclipse/app_module.dart';
import 'package:teste_to_eclipse/core/services/resources/assets.gen.dart';




class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1500), () => Modular.to.pushNamed(Routes.listpage));

    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Assets.images.nasaLogo.image(width: constraints.maxWidth / 2);
          },
        ),
      ),
    );
  }
   
}
