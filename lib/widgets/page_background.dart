import 'package:flutter/material.dart';

class PageBackground extends StatelessWidget {
  const PageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 110, 185, 113),
                    Color.fromARGB(255, 174, 200, 143)
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                ),
              ),
              const Spacer()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 110, 185, 113),
                    Color.fromARGB(255, 174, 200, 143)
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 110, 185, 113),
                    Color.fromARGB(255, 174, 200, 143)
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                ),
              ),
              const Spacer()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                height: 260,
                width: 260,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 110, 185, 113),
                    Color.fromARGB(255, 174, 200, 143)
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                ),
              ),
              const Spacer()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 110, 185, 113),
                    Color.fromARGB(255, 174, 200, 143)
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 110, 185, 113),
                    Color.fromARGB(255, 174, 200, 143)
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                ),
              ),
              const Spacer()
            ],
          ),
        ],
      ),
    );
  }
}
