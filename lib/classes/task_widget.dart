import 'package:flutter/material.dart';

Widget taskWidget(
    {required String name,
    required String description,
    required VoidCallback onPressed,
    required VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black38,
            width: 2.5,
          ),
          color: Colors.black12,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      description,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    ),
  );
}
