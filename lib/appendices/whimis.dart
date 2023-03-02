import 'package:flutter/material.dart';

import 'package:flutter_complete_guide/appendices/appendices_title.dart';
import 'package:flutter_complete_guide/appendices/whimis_helper.dart';
import '../appendices/appendices_drawer.dart';

class Whimis extends StatelessWidget {
  const Whimis({Key? key}) : super(key: key);
  static const routeName = '/whimis';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WHIMIS'),
      ),
      drawer: AppendicesDrawer(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              AppendicesTitle(conversionTitle: 'WHIMIS'),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 50,
            ),
            child: Column(
              children: [
                WhimisHelper(
                  whimisSymble: 'lib/images/Compressed_gas.png',
                  whimisClass: 'Compressed Gas',
                ),
                WhimisHelper(
                  whimisSymble: 'lib/images/Fire.png',
                  whimisClass: 'Flamable and Combustible Material',
                ),
                WhimisHelper(
                  whimisSymble: 'lib/images/Oxidizing.png',
                  whimisClass: 'Oxidizing Material',
                ),
                // WhimisHelper(
                //   whimisSymble: 'lib/images/skull.png',
                //   whimisClass:
                //       'Material Causing Immediate and Serious Toxic Effect',
                // ),
                WhimisHelper(
                  whimisSymble: 'lib/images/Causing_other toxic_effects.png',
                  whimisClass: 'Material Causing Other Toxic Effects',
                ),
                WhimisHelper(
                  whimisSymble: 'lib/images/Biohazardous.png',
                  whimisClass: 'Biodazardous Infectious Materials',
                ),

                WhimisHelper(
                  whimisSymble: 'lib/images/Corrosive.png',
                  whimisClass: 'Corrosive Material',
                ),
                WhimisHelper(
                  whimisSymble: 'lib/images/Dangerous_reactiove.png',
                  whimisClass: 'Dangerously Reactive Material',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
