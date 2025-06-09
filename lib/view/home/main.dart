import 'dart:ui';

import 'package:daily_journal/components/card_journal.dart';
import 'package:daily_journal/constants/color.dart';
import 'package:daily_journal/constants/enum.dart';
import 'package:daily_journal/model/journal_entry.dart';
import 'package:daily_journal/view/add_edit_screen/main.dart';
import 'package:daily_journal/view_model/journal_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Widget renderList(List<JournalEntry> entries) {
    return entries.isEmpty
        ? const Center(child: Text('No entries yet.'))
        : ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    CustomSlidableAction(
                        onPressed: (context) {
                          final journalProvider = Provider.of<JournalViewModel>(
                              context,
                              listen: false);
                          journalProvider.deleteEntry(entry);
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
                child: CardJournal(
                  title: entry.title,
                  content: entry.content,
                  date: entry.date.toLocal().toString(),
                  status: entry.status ?? "",
                  imagePath: entry.filePath ?? "",
                  tagList: entry.tagList,
                  onTap: () {
                      showModalBottomSheet<void>(
                        isDismissible: false,
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: AddEditScreen(entry: entry),
                          );
                        },
                      );
                  },
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    final journalProvider = Provider.of<JournalViewModel>(context);
    final entries = journalProvider.entries;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu_rounded,
          color: Colors.black,
        ),
        title: const Text(
          'Daily Journal',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.black,
            height: 2,
          ),
        ),
      ),
      body: Column(
        children: [
          TabBar(
              indicatorColor: tabController.index == 0
                  ? Colors.blue.shade500
                  : tabController.index == 1
                      ? ColorCustom.GREEN
                      : ColorCustom.YELLOW,
              controller: tabController,
              tabs: [
                Tab(
                  child: Text(
                    "All",
                    style: TextStyle(
                        color: tabController.index == 0
                            ? Colors.blue.shade500
                            : Colors.black),
                  ),
                ),
                Tab(
                    child: Text(
                  "PLUBLISHED",
                  style: TextStyle(
                      color: tabController.index == 1
                          ? ColorCustom.GREEN
                          : Colors.black),
                )),
                Tab(
                  child: Text(
                    "DRAFT",
                    style: TextStyle(
                        color: tabController.index == 2
                            ? ColorCustom.YELLOW
                            : Colors.black),
                  ),
                ),
              ]),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              renderList(entries),
              renderList(entries
                  .where((e) => e.status == JournalStatus.PUBLISHED)
                  .toList()),
              renderList(entries
                  .where((e) => e.status == JournalStatus.DRAFT)
                  .toList()),
            ]),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                isDismissible: false,
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) {
                  return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: const AddEditScreen());
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: ColorCustom.GREEN,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(width: 2, color: Colors.black)),
              child: const Icon(
                Icons.add,
                size: 24,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
