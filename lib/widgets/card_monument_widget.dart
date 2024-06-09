import 'package:escucha_tu_historia/models/monument_reduced.dart';
import 'package:flutter/material.dart';

class CardMonument extends StatelessWidget {
  const CardMonument(
      {super.key,
      required this.size,
      required this.onTap,
      required this.monument});

  final Size size;
  final VoidCallback onTap;
  final MonumentReduced monument;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xff036242).withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10),
                    ),
                    child: FadeInImage(
                      placeholder:
                          const AssetImage('assets/images/loading.gif'),
                      image: NetworkImage(
                        monument.image!,
                      ),
                      width: double.infinity,
                      height: size.height * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text(
                          monument.name ?? 'No name',
                          style: TextStyle(
                            fontSize: size.height * 0.015,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: size.width * 0.1,
                decoration: const BoxDecoration(
                  color: Color(0xff036242),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    monument.number.toString(),
                    style: TextStyle(
                      fontSize: size.height * 0.03,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
