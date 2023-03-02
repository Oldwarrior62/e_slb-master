import 'package:flutter/material.dart';
import 'patrol_container.dart';
import '../appendices/appendices_drawer.dart';
import 'appendices_title.dart';

class Patrols extends StatelessWidget {
  const Patrols({Key? key}) : super(key: key);
  static const routeName = '/patrols';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patrols'),
      ),
      drawer: AppendicesDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            AppendicesTitle(conversionTitle: 'Patrols'),
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Purpose of a patrol is to Detect, Deter, and Report.',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Detect any unussual activities taking place including safety hazards and security concerns.',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Deter any prohibited activities on your site by your presence in uniform.',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'When on patrol (interior or exterior) - Check the following.',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PatrolContainer(
                    patrolText: '- Exits', patrolTextA: '- Locker rooms'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PatrolContainer(
                    patrolText: '- Fire equipment',
                    patrolTextA: '- Restricted areas'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PatrolContainer(
                    patrolText: '- Lights', patrolTextA: '- Telephone rooms'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PatrolContainer(
                    patrolText: '- Doors, locks',
                    patrolTextA: '- Boiler roomes'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PatrolContainer(
                    patrolText: '- Windows', patrolTextA: '- Loading area'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PatrolContainer(
                    patrolText: '- Washrooms', patrolTextA: '- Path and walks'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PatrolContainer(
                    patrolText: '- Stairwells', patrolTextA: '- Lobby area'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PatrolContainer(
                    patrolText: '- Parking lots', patrolTextA: '- Elevators'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PatrolContainer(
                    patrolText: '- Roof area', patrolTextA: '- Pool'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PatrolContainer(
                    patrolText: '- Basements', patrolTextA: '- Exercise rooms'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PatrolContainer(
                    patrolText: '- Fire panel room',
                    patrolTextA: '- Gates and fences'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PatrolContainer(
                    patrolText: '- Mechanical rooms', patrolTextA: ''),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Report all deficiencies in your notebook to forward to management for action taken as soon as possible.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
