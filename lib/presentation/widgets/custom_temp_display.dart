import 'package:flutter/material.dart';
import 'package:weather_app_flutter/data/utility/urls.dart';

class CustomTempDisplay extends StatefulWidget {
  const CustomTempDisplay({
    super.key,
    required this.temperature,
    required this.iconId,
  });
  final double temperature;
  final String iconId;

  @override
  State<CustomTempDisplay> createState() => _CustomTempDisplayState();
}

class _CustomTempDisplayState extends State<CustomTempDisplay> {
  late final ValueNotifier<bool> _isCelsiusNotifier = ValueNotifier<bool>(true);
  late final ValueNotifier<double> _tempNotifier =
      ValueNotifier<double>(widget.temperature);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          Urls.getWeatherIcon(widget.iconId),
          height: 100,
          width: 100,
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isCelsiusNotifier,
          builder: (context, isCelsius, child) {
            return ValueListenableBuilder<double>(
              valueListenable: _tempNotifier,
              builder: (context, temp, child) {
                return InkWell(
                  onTap: toggleTemperature,
                  child: Text(
                    '${temp.toStringAsFixed(1)} °${isCelsius ? "C" : "F"}',
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  void toggleTemperature() {
    if (_isCelsiusNotifier.value) {
      _tempNotifier.value = (_tempNotifier.value * 9 / 5) + 32;
    } else {
      _tempNotifier.value = (_tempNotifier.value - 32) * 5 / 9;
    }
    _isCelsiusNotifier.value = !_isCelsiusNotifier.value; // Toggle the state
  }

  @override
  void dispose() {
    _isCelsiusNotifier.dispose();
    _tempNotifier.dispose();
    super.dispose();
  }
}
