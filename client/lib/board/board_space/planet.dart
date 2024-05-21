import 'package:client/data/color_data.dart';
import 'package:client/data/planet_data.dart';
import 'package:client/res/hover_tip.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:client/res/unit_tokens/pds.dart';
import 'package:client/res/unit_tokens/spacedock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Planet extends StatefulWidget {
  const Planet({
    super.key,
    required this.planet,
    required this.owner,
    required this.numGroundForces,
    required this.hasSpacedock,
    required this.numPDS,
    required this.diameter
  });
  final PlanetModel planet;
  final int owner;
  final int numGroundForces;
  final double diameter;
  final bool hasSpacedock;
  final int numPDS;
  @override
  State<Planet> createState() => _PlanetState();
}

class _PlanetState extends State<Planet> {
  GlobalKey key = GlobalKey();
  late OverlayEntry? entry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: (widget.planet.name == 'Mecatol Rex') ? widget.diameter * 1.5 : widget.diameter,
        height: (widget.planet.name == 'Mecatol Rex') ? widget.diameter * 1.5 : widget.diameter,
        child: MouseRegion(
          key: key,
          onEnter: _onEnter,
          onExit: _onExit,
          child: Stack(
            children: [
              Container(
                width: (widget.planet.name == 'Mecatol Rex') ? widget.diameter * 1.5 : widget.diameter,
                height: (widget.planet.name == 'Mecatol Rex') ? widget.diameter * 1.5 : widget.diameter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(50),
                  color: (widget.owner == -1)? Colors.white : ColorData.playerColor[widget.owner],
                  border: Border.all(
                    width: 3,
                    color: ColorData.traitColor[widget.planet.trait]!,
                  )
                ),
                child: Center(
                  child: OutlinedLetters(
                    content: '${widget.numGroundForces}'
                  ),
                ),
              ),
              // Show other "surrounding" elements
              (widget.hasSpacedock && widget.owner != -1)? Positioned(
                height: ((widget.planet.name == 'Mecatol Rex') ? widget.diameter * 1.5 : widget.diameter) * 0.4,
                width: ((widget.planet.name == 'Mecatol Rex') ? widget.diameter * 1.5 : widget.diameter) * 0.4,
                top: ((widget.planet.name == 'Mecatol Rex') ? widget.diameter * 1.5 : widget.diameter) * 0.05,
                left: ((widget.planet.name == 'Mecatol Rex') ? widget.diameter * 1.5 : widget.diameter) * 0.6,
                child: HoverTip(message: 'Spacedock Prod ${widget.planet.resources + 2}', child: SpacedockIcon(color: (widget.owner == -1 || !widget.hasSpacedock)? Colors.transparent : ColorData.playerColor[widget.owner]))
              ) : Container(),
              (widget.numPDS != 0 && widget.owner != -1)? Positioned(
                height: ((widget.planet.name == 'Mecatol Rex') ? widget.diameter * 1.5 : widget.diameter) * 0.4,
                width: ((widget.planet.name == 'Mecatol Rex') ? widget.diameter * 1.5 : widget.diameter) * 0.4,
                top: ((widget.planet.name == 'Mecatol Rex') ? widget.diameter * 1.5 : widget.diameter) * 0.55,
                left: ((widget.planet.name == 'Mecatol Rex') ? widget.diameter * 1.5 : widget.diameter) * 0.05,
                child: HoverTip(message: '${widget.numPDS} PDS System(s)', child: PDSIcon(color: ColorData.playerColor[widget.owner], count: widget.numPDS,))
              ) : Container()
            ]
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
