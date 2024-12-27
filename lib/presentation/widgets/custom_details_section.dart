import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/presentation/state_holders/location_controller.dart';
import 'package:weather_app_flutter/presentation/utility/image_icon_assets.dart';

import 'custom_details_card.dart';

class CustomDetailsSection extends StatefulWidget {
  const CustomDetailsSection({
    super.key,
  });

  @override
  State<CustomDetailsSection> createState() => _CustomDetailsSectionState();
}

class _CustomDetailsSectionState extends State<CustomDetailsSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Expanded(
          flex: 1,
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomDetailsCard(
                    title: 'Sunrise',
                    subTitle: '6:00am',
                    leadingIcon: SvgPicture.asset(
                      ImageAndIconAssets.locationIconSVG,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  CustomDetailsCard(
                    title: 'Sunset',
                    subTitle: '6:00pm',
                    leadingIcon: SvgPicture.asset(
                      ImageAndIconAssets.locationIconSVG,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  CustomDetailsCard(
                    title: 'Wind Speed',
                    subTitle: 'speed',
                    leadingIcon: SvgPicture.asset(
                      ImageAndIconAssets.locationIconSVG,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  CustomDetailsCard(
                    title: 'Humidity',
                    subTitle: 'humidity',
                    leadingIcon: SvgPicture.asset(
                      ImageAndIconAssets.locationIconSVG,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  CustomDetailsCard(
                    title: 'Pressure',
                    subTitle: 'pressure',
                    leadingIcon: SvgPicture.asset(
                      ImageAndIconAssets.locationIconSVG,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  CustomDetailsCard(
                    title: 'Visibility',
                    subTitle: 'visibility',
                    leadingIcon: SvgPicture.asset(
                      ImageAndIconAssets.locationIconSVG,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
