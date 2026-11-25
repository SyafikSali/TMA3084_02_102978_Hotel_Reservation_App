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

  Widget _buildRoomPhoto(RoomType room, ColorScheme colorScheme) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.asset(
        room.assetPath,
        height: 160,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(room.icon, size: 36, color: colorScheme.primary),
                const SizedBox(height: 6),
                Text(
                  room.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
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
                      'PARK HYATT SEOUL · STAY SUMMARY',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Check-in ${widget.checkIn}'),
                    const SizedBox(height: 4),
                    Text('${widget.guests} guests'),
                    const SizedBox(height: 10),
                    Container(
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
                      subtitle: Text(
                        isPreferred
                            ? '${room.rateLabel} · Preferred'
                            : room.rateLabel,
                        style: TextStyle(
                          color: isPreferred
                              ? colorScheme.tertiary
                              : colorScheme.onSurfaceVariant,
                          fontWeight: isPreferred
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  body: AnimatedContainer(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeInOut,
                    color: isPreferred
                        ? colorScheme.secondaryContainer.withValues(alpha: 0.35)
                        : Colors.transparent,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRoomPhoto(room, colorScheme),
                        const SizedBox(height: 12),
                        Text(room.description),
                      ],
                    ),
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
