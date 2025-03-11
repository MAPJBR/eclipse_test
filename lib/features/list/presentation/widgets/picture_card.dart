
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_to_eclipse/app_module.dart';
import 'package:teste_to_eclipse/core/services/resources/app_dimens.dart';



import '../../domain/entities/picture.dart';

class PictureCard extends StatelessWidget {
  static const _cardHeight = 300.0;

  final Picture picture;

  const PictureCard({super.key, required this.picture});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: _cardHeight,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: picture.featuredImageUrl,
                      child: CachedNetworkImage(imageUrl: picture.featuredImageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned.fill(child: Container(color: Colors.black26)),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimens.padding02),
                      child: Text(
                        picture.title,
                        style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimens.padding02),
                      child: Text(
                        picture.date,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.5,
              color: Colors.white,
            ),
          ],
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {Modular.to.pushNamed(Routes.detailPage, arguments: picture);}
            ),
          ),
        ),
      ],
    );
  }
}
