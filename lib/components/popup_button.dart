import 'package:daily_journal/constants/color.dart';
import 'package:daily_journal/constants/enum.dart';
import 'package:flutter/material.dart';

class CreateTaskButton extends StatefulWidget {
  const CreateTaskButton({super.key, this.onPress});
  final Function(String type)? onPress;
  @override
  State<CreateTaskButton> createState() => _CreateTaskButtonState();
}

class _CreateTaskButtonState extends State<CreateTaskButton> {
  String? selectedType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initialize with default type
      setState(() {
        selectedType = JournalStatus.PUBLISHED;
      });
    });
  }

  void _onSelect(String type) {
    setState(() {
      selectedType = type;
    });

    // Submit task with selected type
    print('Create Task of type: $type');
    // You can trigger form submission or action here
  }

  String renderSubmitTypeText() {
    switch (selectedType) {
      case JournalStatus.PUBLISHED:
        return 'Publish';
      case JournalStatus.DRAFT:
        return 'Draft';
      case JournalStatus.ARCHIVED:
        return 'Archive';

      default:
        return JournalStatus.PUBLISHED;
    }
  }

  Color renderColorSumbitType() {
    switch (selectedType) {
      case JournalStatus.PUBLISHED:
        return ColorCustom.GREEN;
      case JournalStatus.DRAFT:
        return ColorCustom.YELLOW;
      case JournalStatus.ARCHIVED:
        return Colors.blue.shade300;
      case JournalStatus.DELETED:
        return Colors.red.shade300;
      default:
        return Colors.green.shade300; // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPress != null) {
          widget.onPress!(selectedType ?? JournalStatus.PUBLISHED);
        }
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: renderColorSumbitType(),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                renderSubmitTypeText(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              child: VerticalDivider(
                color: Colors.black,
                thickness: 2,
                width: 1,
              ),
            ),
            PopupMenuButton<String>(
              icon:
                  const Icon(Icons.arrow_drop_up_rounded, color: Colors.white),
              color: Colors.white,
              onSelected: _onSelect,
              itemBuilder: (context) => [
                const PopupMenuItem(
                    value: JournalStatus.PUBLISHED,
                    child: Text(JournalStatus.PUBLISHED)),
                const PopupMenuItem(
                    value: JournalStatus.DRAFT,
                    child: Text(JournalStatus.DRAFT)),
                const PopupMenuItem(
                    value: JournalStatus.ARCHIVED,
                    child: Text(JournalStatus.ARCHIVED)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
