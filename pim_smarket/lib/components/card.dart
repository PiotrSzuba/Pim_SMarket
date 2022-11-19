import "package:flutter/material.dart";
import 'package:pim_smarket/theme.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {super.key,
      required this.name,
      required this.tags,
      required this.onPressed,
      required this.imageUrl});

  final String name;
  final String tags;
  final Function onPressed;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onPressed(),
        overlayColor: MaterialStateProperty.all(CustomTheme.pinkColor50),
        borderRadius: CustomTheme.circularBorder,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: CustomTheme.pinkColor),
                borderRadius: CustomTheme.circularBorder,
                color: CustomTheme.elementFillColor),
            constraints: const BoxConstraints(
              minWidth: double.infinity,
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomTheme.pinkColor),
                    borderRadius: CustomTheme.circularBorder,
                  ),
                  margin: const EdgeInsets.only(right: 20),
                  child: ClipRRect(
                    borderRadius: CustomTheme.circularBorder,
                    child: SizedBox.fromSize(
                        size: const Size.square(70),
                        child: Image.network(
                          imageUrl ??
                              'https://media.tenor.com/m8oi5KsmOZ0AAAAS/loli.gif',
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      name,
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
            )));
  }
}
