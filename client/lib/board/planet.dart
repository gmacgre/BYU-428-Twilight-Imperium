import 'package:client/data/planet_data.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Planet extends StatefulWidget {
  const Planet({
    super.key,
    required this.planet,
  });
  final PlanetModel planet;
  @override
  State<Planet> createState() => _PlanetState();
}

class _PlanetState extends State<Planet> {
  GlobalKey key = GlobalKey();
  late OverlayEntry? entry;
  @override
  Widget build(BuildContext context) {
    return Center(
      key: key,
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(widget.planet.name != "Mecatol Rex"
            ? const Size(
                25,
                25,
              )
            : const Size(40, 40)),
        child: MouseRegion(
          onEnter: _onEnter,
          onExit: _onExit,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(40),
                color: widget.planet.color,
                border: Border.all(
                  //This will be set to the controlling player's color
                  color: Colors.black,
                )),
          ),
        ),
      ),
    );
  }

  void _onEnter(PointerEnterEvent event) {
    entry = getPlanetDetailOverlay();
    Overlay.of(context).insert(entry!);
  }

  void _onExit(PointerExitEvent event) {
    entry?.remove();
    entry?.dispose();
    entry = null;
  }

  OverlayEntry getPlanetDetailOverlay() {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    double x = position.dx;
    double y = position.dy;
    double yAdjustment = 0;
    double xAdjustment = 70;
    double top = y + yAdjustment;
    double left = x + xAdjustment;
    if (top <= 10) {
      top = 10;
    }
    return OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: top,
          left: left,
          child: Container(
            width: 150,
            decoration: const BoxDecoration(
              color: Color.fromARGB(
                200,
                100,
                100,
                100,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(
                fontFamily: 'Handel Gothic D',
                color: Colors.white,
              ),
              child: Column(
                children: [
                  OutlinedLetters(
                    content: widget.planet.name,
                    fontSize: 18,
                  ),
                  Text('Resources: ${widget.planet.resources}'),
                  Text('Influence: ${widget.planet.influence}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
