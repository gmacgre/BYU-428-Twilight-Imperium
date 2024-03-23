import 'package:client/board/planet.dart';
import 'package:client/data/system_data.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class System extends ConsumerStatefulWidget {
  const System(this.system, {super.key});

  final SystemModel system;
  @override
  ConsumerState<System> createState() => _SystemState();
}

class _SystemState extends ConsumerState<System> {
  @override
  Widget build(BuildContext context) {
    int systemSize =
        widget.system.planets != null ? widget.system.planets!.length : 0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        10.0,
        20.0,
        10.0,
        20.0,
      ),
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            Planet(
              planet: widget.system.planets![0],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Planet(
              planet: widget.system.planets![1],
            ),
            const SizedBox(),
          ],
        ),
      ],
    );
  }

  Widget onePlanetSystem() {
    return Planet(
      planet: widget.system.planets![0],
    );
  }

  Widget threePlanetSystem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Planet(
          planet: widget.system.planets![0],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Planet(planet: widget.system.planets![1]),
            Planet(planet: widget.system.planets![2]),
          ],
        ),
      ],
    );
  }
}
