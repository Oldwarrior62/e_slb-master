import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/appendices/appendices_container.dart';
import 'package:flutter_complete_guide/appendices/appendices_title.dart';
import '../appendices/appendices_drawer.dart';

class ConversionTable extends StatefulWidget {
  const ConversionTable({Key? key}) : super(key: key);
  static const routeName = '/conversion';

  @override
  State<ConversionTable> createState() => _ConversionTableState();
}

class _ConversionTableState extends State<ConversionTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversion tables'),
      ),
      drawer: AppendicesDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            AppendicesTitle(conversionTitle: ' Metric Conversion '),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppendicesContainer(
                    appendicesText: '1 centimeter (cm) = 10 milimeters (mm)'),
                AppendicesContainer(
                    appendicesText: '1 meter (m) = 100 centimeters (cm)'),
                AppendicesContainer(
                    appendicesText: '1 kilometer (km) = 1000 meters (m)'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            AppendicesTitle(conversionTitle: 'Standard Conversion'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppendicesContainer(
                    appendicesText: ' 1 foot (ft) = 12 inches (in) '),
                AppendicesContainer(
                    appendicesText: ' 1 yard (yd) = 3 feet (ft) '),
                AppendicesContainer(
                    appendicesText: ' 1 yard (yd) = 36 inches (in) '),
                AppendicesContainer(
                    appendicesText: ' 1 mile (mi) = 1760 yards (yd) '),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            AppendicesTitle(conversionTitle: ' Metric -> Standard Conversion '),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppendicesContainer(
                    appendicesText: '1 milimeter (mm) = 0.03937 inches (in)'),
                AppendicesContainer(
                    appendicesText: '1 centimeters (cm) = 0.3937 inches (in)'),
                AppendicesContainer(
                    appendicesText: '1 meters (m) = 39.37008 inches (in)'),
                AppendicesContainer(
                    appendicesText: '1 meter (m) = 3.28084 feet (ft)'),
                AppendicesContainer(
                    appendicesText: '1 meter (m) = 1.09361 yards (yd)'),
                AppendicesContainer(
                    appendicesText: '1 kilometer (km) = 1093.6133 yards (yd)'),
                AppendicesContainer(
                    appendicesText: '1 kilometer (km) = 0.62137 miles (mi)')
              ],
            ),
            SizedBox(
              height: 10,
            ),
            AppendicesTitle(conversionTitle: ' Standard -> Metric Conversion '),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppendicesContainer(
                    appendicesText: '1 inch (in) = 2.54 cetimeters (cm)'),
                AppendicesContainer(
                    appendicesText: '1 foot (ft) = 30.46 centimeters (cm)'),
                AppendicesContainer(
                    appendicesText: '1 yard (yd) = 91.44 centimeters (cm)'),
                AppendicesContainer(
                    appendicesText: '1 yard (yd) = 0.9144 meters (m)'),
                AppendicesContainer(
                    appendicesText: '1 mile (mi) = 1609.344 meters (m)'),
                AppendicesContainer(
                    appendicesText: '1 mile (mi) = 1.609344 kilometers (km)'),
              ],
            ),
            // ConversionTitle(conversionTitle: 'Time'),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 40,
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
