import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spacex_launches/models/rocket.dart';

class RocketSlider extends StatelessWidget {
  final List<Rocket> rockets;
  final void Function(int) onPageChanged;
  final int currentIndex;
  final double cardRadius;

  const RocketSlider({
    required this.rockets,
    required this.onPageChanged,
    required this.currentIndex,
    this.cardRadius = 14.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        viewportFraction: 0.78,
        onPageChanged: (index, reason) => onPageChanged(index),
      ),
      items: rockets.map((rocket) {
        final imageUrl = rocket.flickrImages.isNotEmpty ? rocket.flickrImages[0] : null;
        return Builder(builder: (context) {
          return SizedBox(
            child: Card(
              color: const Color(0xFF1E1E1E),
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cardRadius)),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (imageUrl != null)
                    Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity, loadingBuilder: (c, ch, prog) {
                      if (prog == null) return ch;
                      return const Center(child: CircularProgressIndicator());
                    }, errorBuilder: (c, e, s) {
                      return Center(child: Icon(Icons.broken_image, size: 56, color: Colors.grey[500]));
                    })
                  else
                    Center(child: Icon(Icons.image_not_supported, size: 56, color: Colors.grey[400])),

                  Positioned(left: 0, right: 0, bottom: 0, height: 70, child: Container(decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black54])))),
                ],
              ),
            ),
          );
        });
      }).toList(),
    );
  }
}
