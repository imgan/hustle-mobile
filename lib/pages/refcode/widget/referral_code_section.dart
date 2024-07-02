import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/typography/d_din_exp.dart';

class ReferralCodeSection extends StatelessWidget {
  const ReferralCodeSection({super.key, required this.refCode});

  final String refCode;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 0)),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Referral Code:',
                  style: DDinExp.regular.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  refCode,
                  style: DDinExp.bold.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: refCode)).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Copied to clipboard")));
                });
              },
              child: Container(
                  alignment: Alignment.center,
                  width: 80,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.0)),
                  child: Text(
                    'Copy',
                    style: DDinExp.bold.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  )),
            )
          ],
        ));
  }
}
