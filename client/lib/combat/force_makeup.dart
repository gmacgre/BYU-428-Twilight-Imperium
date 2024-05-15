import 'dart:math';

class ForceMakeup {
  int flagship;
  int warsun;
  int dreadnaught;
  int cruiser;
  int carrier;
  int destroyer;
  int fighter;

  ForceMakeup({
    required this.flagship,
    required this.warsun,
    required this.dreadnaught,
    required this.cruiser,
    required this.carrier,
    required this.destroyer,
    required this.fighter,
  });

  int forceSize() {
    return flagship + warsun + dreadnaught + cruiser + carrier + destroyer + fighter;
  }

  int fire() {
    int toReturn = 0;
    for(int i = 0; i < flagship * 2; i++) {
      if(Random().nextInt(10) >= 7) toReturn++;
    }
    for(int i = 0; i < warsun * 3; i++) {
      if(Random().nextInt(10) >= 3) toReturn++;
    }
    for(int i = 0; i < dreadnaught; i++) {
      if(Random().nextInt(10) >= 5) toReturn++;
    }
    for(int i = 0; i < cruiser; i++) {
      if(Random().nextInt(10) >= 7) toReturn++;
    }
    for(int i = 0; i < carrier; i++) {
      if(Random().nextInt(10) >= 7) toReturn++;
    }
    for(int i = 0; i < destroyer; i++) {
      if(Random().nextInt(10) >= 9) toReturn++;
    }
    for(int i = 0; i < fighter; i++) {
      if(Random().nextInt(10) >= 9) toReturn++;
    }
    return toReturn;
  }
}