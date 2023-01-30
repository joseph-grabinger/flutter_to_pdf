import 'package:flutter/material.dart';

import 'tearow_item.dart';

class TeaRow extends StatelessWidget {
  final String title;
  final double height;
  final double aspectRatio;
  final List<TeaRowItem> items;

  const TeaRow({
    required this.title,
    required this.height,
    required this.aspectRatio,
    required this.items,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: height,
          child: ListView.builder(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: items[index].onTap,
                child: AspectRatio(
                  aspectRatio: aspectRatio, // Din A4
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 1.0,
                      ),
                      image: DecorationImage(
                        image: AssetImage(items[index].imageURL),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}