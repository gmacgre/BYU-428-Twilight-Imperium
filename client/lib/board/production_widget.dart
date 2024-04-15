import 'package:client/board/coordinate.dart';
import 'package:client/board/production_provider.dart';
import 'package:client/board/ship_selector_provider.dart';
import 'package:client/data/strings.dart';
import 'package:client/model/board_state.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductionWidget extends ConsumerWidget {
  const ProductionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool productionActive =
        ref.watch(boardStateProvider).currentPhase == TurnPhase.production;
    return Visibility(
      visible: productionActive,
      child: Material(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 300,
          color: Colors.blueGrey,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Text("Resources: "),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              // Add selected ships here
              const OutlinedLetters(
                content: "Units to produce",
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: ShipType.values.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          ShipType.values[index].label,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                            'Resource Cost: 1'), // replace with actual resource cost
                        const SizedBox(width: 10),
                        DropdownButton<int>(
                          value: ref
                                  .watch(productionProvider)
                                  .selectedQuantities[ShipType.values[index]] ??
                              0,
                          onChanged: (int? newValue) {
                            ref
                                .read(productionProvider.notifier)
                                .updateSelectedQuantity(
                                    ShipType.values[index], newValue!);
                          },
                          items: List<int>.generate(10, (i) => i)
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      ref.read(productionProvider.notifier).cancel();
                    },
                    child: const OutlinedLetters(content: Strings.cancel),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(productionProvider.notifier).submit();
                    },
                    child: const OutlinedLetters(content: Strings.submit),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
