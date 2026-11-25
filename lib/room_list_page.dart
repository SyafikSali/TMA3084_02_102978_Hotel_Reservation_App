import 'package:flutter/material.dart';

import 'room_type.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({
    super.key,
    required this.preferred,
    required this.guests,
    required this.checkIn,
    this.breakfast = false,
  });

  final RoomPreference preferred;
  final int guests;
  final String checkIn;
  final bool breakfast;

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  late final List<RoomType> _rooms;

  @override
  void initState() {
    super.initState();
    _rooms = buildRooms(widget.preferred);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Room')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stay Summary',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Check-in ${widget.checkIn}'),
                    const SizedBox(height: 4),
                    Text('${widget.guests} guests'),
                    const SizedBox(height: 10),
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: widget.breakfast
                              ? colorScheme.secondaryContainer
                              : colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.breakfast
                              ? 'Breakfast included'
                              : 'Room only (no breakfast)',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() => _rooms[index].isExpanded = isExpanded);
              },
              children: _rooms.map<ExpansionPanel>((RoomType room) {
                final isPreferred = room.preference == widget.preferred;
                return ExpansionPanel(
                  isExpanded: room.isExpanded,
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      leading: Icon(room.icon, color: colorScheme.primary),
                      title: Text(room.name),
                      subtitle: isPreferred
                          ? Text(
                              'Preferred option',
                              style: TextStyle(color: colorScheme.secondary),
                            )
                          : null,
                    );
                  },
                  body: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    color: isPreferred
                        ? colorScheme.primaryContainer.withValues(alpha: 0.25)
                        : Colors.transparent,
                    child: ListTile(title: Text(room.description)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
