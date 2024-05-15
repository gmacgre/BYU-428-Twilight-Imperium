import 'package:client/board/board_space/anomaly.dart';
import 'package:client/board/board_space/board_click_interface.dart';
import 'package:client/board/board_space/planet.dart';
import 'package:client/board/board_space/wormhole.dart';
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
        (widget.system.planets != null ? widget.system.planets!.length : 0) +
        (widget.system.anomaly != null ? 1 : 0) +
        (widget.system.wormhole != null ? 1 : 0);
    return GestureDetector(
      onDoubleTap: (){
        widget.listener.processDoubleTap();
      },
      onTap: () {
        widget.listener.processTap();
      },
      child: switch (systemSize) {
        // 4 => fourItemSystem(),
        3 => _threeItemSystem(),
        2 => _twoItemSystem(),
        1 => _oneItemSystem(),
        int() => null
      },
    );
  }

  List<Widget> _interiors(double size) {
    List<Widget> toReturn = [];
    if(widget.planets != null) {
      for(int i = 0; i < widget.planets!.length; i++) {
        toReturn.add(
          Planet(
            planet: widget.system.planets![i], 
            owner: widget.planets![i].planetOwner, 
            numGroundForces: widget.planets![i].numGroundForces, 
            diameter: size
          )
        );
      }
    }
    if(widget.system.wormhole != null) {
      toReturn.add(
        WormholeWidget(
          wormhole: widget.system.wormhole!,
          diameter: size
        )
      );
    }
    if(widget.system.anomaly != null) {
      toReturn.add(
        AnomalyWidget(
          anomaly: widget.system.anomaly!,
          diameter: size
        )
      );
    }
    return toReturn;
  }

  Widget _twoItemSystem() {
    List<Widget> interiors = _interiors(widget.constraints.maxHeight * 0.4);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(widget.constraints.maxHeight * 0.2, 0, 0, 0),
          child: interiors[0]
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, widget.constraints.maxHeight * 0.2, 0),
          child: interiors[1]
        ),
      ],
    );
  }

  Widget _oneItemSystem() {
    List<Widget> interiors;
    if(widget.system.anomaly != null) {
      interiors = _interiors(widget.constraints.maxWidth);
    }
    else {
      interiors = _interiors(widget.constraints.maxHeight * 0.4);
    }
    
    return Center(
      child: interiors[0]
    );
  }

  Widget _threeItemSystem() {
    List<Widget> interiors = _interiors(widget.constraints.maxHeight * 0.3);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        interiors[0],
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            interiors[1],
            SizedBox(
              width: widget.constraints.maxWidth * 0.1,
            ),
            interiors[2]
          ],
        ),
      ],
    );
  }
}
