import 'package:client/board/board_space/board_click_interface.dart';
import 'package:client/board/board_space/planet.dart';
import 'package:client/data/system_data.dart';
import 'package:client/model/planet_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class System extends ConsumerStatefulWidget {
  const System(this.constraints, this.system, this.planets, this.listener, {super.key});

  final SystemModel system;
  final List<PlanetState>? planets;
  final BoxConstraints constraints;
  final BoardClickInterface listener;
  @override
  ConsumerState<System> createState() => _SystemState();
}

class _SystemState extends ConsumerState<System> {
  @override
  Widget build(BuildContext context) {
    int systemSize =
        widget.system.planets != null ? widget.system.planets!.length : 0;
    return GestureDetector(
      onDoubleTap: (){
        widget.listener.processDoubleTap();
      },
      onTap: () {
        widget.listener.processTap();
      },
      child: switch (systemSize) {
        3 => threePlanetSystem(),
        2 => twoPlanetSystem(),
        1 => onePlanetSystem(),
        int() => null
      },
    );
  }

  Widget twoPlanetSystem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(widget.constraints.maxHeight * 0.2, 0, 0, 0),
          child: Planet(
            planet: widget.system.planets![0],
            owner: widget.planets![0].planetOwner,
            numGroundForces: widget.planets![0].numGroundForces,
            diameter: widget.constraints.maxHeight * 0.4
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, widget.constraints.maxHeight * 0.2, 0),
          child: Planet(
            planet: widget.system.planets![1],
            owner: widget.planets![1].planetOwner,
            numGroundForces: widget.planets![1].numGroundForces,
            diameter: widget.constraints.maxHeight * 0.4
          ),
        ),
      ],
    );
  }

  Widget onePlanetSystem() {
    return Center(
      child: Planet(
        planet: widget.system.planets![0],
        numGroundForces: widget.planets![0].numGroundForces,
        owner: widget.planets![0].planetOwner,
        diameter: widget.constraints.maxHeight * 0.4
      ),
    );
  }

  Widget threePlanetSystem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Planet(
          planet: widget.system.planets![0],
          numGroundForces: widget.planets![0].numGroundForces,
          owner: widget.planets![0].planetOwner,
          diameter: widget.constraints.maxHeight * 0.3
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Planet(
              planet: widget.system.planets![1],
              owner: widget.planets![1].planetOwner,
              numGroundForces: widget.planets![1].numGroundForces,
              diameter: widget.constraints.maxHeight * 0.3
            ),
            SizedBox(
              width: widget.constraints.maxWidth * 0.1,
            ),
            Planet(
              planet: widget.system.planets![2],
              owner: widget.planets![2].planetOwner,
              numGroundForces: widget.planets![2].numGroundForces,
              diameter: widget.constraints.maxHeight * 0.3
            ),
          ],
        ),
      ],
    );
  }
}
