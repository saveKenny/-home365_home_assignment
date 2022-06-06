import 'package:assets_repository/assets_repository.dart';
import 'package:flutter/material.dart';

class AssetTile extends StatelessWidget {
  const AssetTile({
    Key? key,
    required this.asset,
    this.distanceKm,
  }) : super(key: key);

  final Asset asset;
  final double? distanceKm;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, top: 15, bottom: 15, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(asset.title, style: titleStyle),
                  Text("שכירות חודשית: ₪${asset.priceString}"),
                  const Text("מידע נוסף:"),
                  Text(" • מספר חדרים: ${asset.rooms.toString()}"),
                  Text(" • חדרי שירותים/אמבטיות: ${asset.bathrooms}"),
                  Text(" • ${asset.propertyType}"),
                  Text(" • קומה ${asset.floor} מתוך ${asset.buildingFloors}")
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(asset.thumbnail),
                  ),
                  distanceKm != null
                      ? Positioned(
                          bottom: 5,
                          left: 5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 2, bottom: 2),
                              child:
                                  Text('${distanceKm!.toStringAsFixed(1)} ק"מ'),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
