import 'dart:io';

import 'package:daily_journal/constants/color.dart';
import 'package:daily_journal/constants/enum.dart';
import 'package:flutter/material.dart';

class CardJournal extends StatelessWidget {
  const CardJournal(
      {super.key,
      required this.title,
      required this.content,
      required this.date,
      required this.status,
      required this.imagePath,
      required this.onTap,
      this.tagList});
  final String title;
  final String content;
  final String date;
  final String status;
  final String? imagePath;
  final Function()? onTap;
  final List<String>? tagList;

  Color renderColorStatus(String status) {
    switch (status) {
      case JournalStatus.PUBLISHED:
        return ColorCustom.GREEN;
      case JournalStatus.DRAFT:
        return ColorCustom.YELLOW;
      case 'archived':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  Widget build(BuildContext context) {
    final imageFile = File(imagePath ?? "");
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(8)),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                content,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              Wrap(
                children: tagList != null
                    ? tagList!
                        .map((tag) => Container(
                              margin: const EdgeInsets.only(right: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(tag,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14)),
                            ))
                        .toList()
                    : [],
              ),
              if (imagePath != "") ...{
                Center(
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                      child: Image.file(imageFile,
                          height: 150, width: 150, fit: BoxFit.fill)),
                )
              }
            ],
          ),
          Positioned(
              right: 10,
              top: 0,
              child: Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                  color: renderColorStatus(status),
                  borderRadius: BorderRadius.circular(999),
                ),
              )),
        ]),
      ),
    );
  }
}
