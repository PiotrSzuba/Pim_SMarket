import "package:flutter/material.dart";
import 'package:pim_smarket/theme.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.studentName, required this.tags});

  final String studentName;
  final String tags;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: CustomTheme.pinkColor),
          borderRadius: CustomTheme.circularBorder,
        ),
        constraints: const BoxConstraints(
          minWidth: double.infinity,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: CustomTheme.pinkColor),
                borderRadius: CustomTheme.circularBorder,
              ),
              constraints: const BoxConstraints(minWidth: 70, minHeight: 70),
              margin: const EdgeInsets.only(right: 20),
              //child:
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  studentName,
                  style: CustomTheme.pinkTitle,
                ),
                const SizedBox(height: 20),
                Text(
                  tags,
                  style: CustomTheme.pinkText,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                )
              ],
            ))
          ],
        ));
  }
}
