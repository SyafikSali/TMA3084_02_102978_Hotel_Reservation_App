import 'package:flutter/material.dart';

import 'room_list_page.dart';
import 'room_type.dart';
import 'validators.dart';

class BookingFormPage extends StatefulWidget {
  const BookingFormPage({super.key});

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  DateTime? _checkIn;
  double _guests = 2;
  RoomPreference _room = RoomPreference.double;
  bool _breakfast = false;
  bool _accepted = false;
  String? _dateError;
  String? _policyError;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _checkIn ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (!mounted || picked == null) return;
    setState(() {
      _checkIn = picked;
      _dateError = null;
    });
  }

  void _submit() {
    final formIsValid = _formKey.currentState!.validate();
    final dateError = validateCheckIn(_checkIn);
    final policyError = validateAgreement(_accepted);
    setState(() {
      _dateError = dateError;
      _policyError = policyError;
    });
    if (!formIsValid || dateError != null || policyError != null) return;

    final guest = _nameController.text.trim();
    final checkInText = MaterialLocalizations.of(context)
        .formatShortDate(_checkIn!);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Booking saved for $guest')));

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => RoomListPage(
          preferred: _room,
          guests: _guests.round(),
          checkIn: checkInText,
          breakfast: _breakfast,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final errorStyle = TextStyle(
      color: colorScheme.error,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Book a Room')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [colorScheme.primary, const Color(0xFF23282E)],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: colorScheme.secondary.withValues(alpha: 0.65),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: colorScheme.secondary.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.spa_outlined,
                        color: colorScheme.secondary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PARK HYATT SEOUL',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.4,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Teheran-ro, Gangnam-gu · Modern Luxury',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: colorScheme.onPrimary.withValues(
                                    alpha: 0.85,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'GUEST RESERVATION',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Guest name',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: validateName,
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone number',
                          prefixIcon: Icon(Icons.phone_outlined),
                          border: OutlineInputBorder(),
                        ),
                        validator: validatePhone,
                      ),
                      const SizedBox(height: 14),
                      OutlinedButton.icon(
                        onPressed: _pickDate,
                        icon: const Icon(Icons.calendar_month),
                        label: Text(
                          _checkIn == null
                              ? 'Choose check-in date'
                              : MaterialLocalizations.of(context)
                                    .formatShortDate(_checkIn!),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: _dateError != null ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 220),
                        child: _dateError != null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  top: 6,
                                  left: 12,
                                ),
                                child: Text(_dateError!, style: errorStyle),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'ACCOMMODATION PREFERENCES',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Guests: ${_guests.round()}'),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_guests.round()} guests',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: _guests,
                        min: 1,
                        max: 6,
                        divisions: 5,
                        label: _guests.round().toString(),
                        onChanged: (double value) =>
                            setState(() => _guests = value),
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<RoomPreference>(
                        segments: const [
                          ButtonSegment(
                            value: RoomPreference.single,
                            label: Text('Single'),
                            icon: Icon(Icons.single_bed),
                          ),
                          ButtonSegment(
                            value: RoomPreference.double,
                            label: Text('Double'),
                            icon: Icon(Icons.bed),
                          ),
                          ButtonSegment(
                            value: RoomPreference.family,
                            label: Text('Family'),
                            icon: Icon(Icons.family_restroom),
                          ),
                        ],
                        selected: {_room},
                        onSelectionChanged: (Set<RoomPreference> next) =>
                            setState(() => _room = next.first),
                      ),
                      const SizedBox(height: 12),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 260),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: _breakfast
                              ? colorScheme.secondaryContainer.withValues(
                                  alpha: 0.65,
                                )
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SwitchListTile(
                          title: const Text('Include breakfast'),
                          subtitle: const Text(
                            'Added to each night of the stay',
                          ),
                          value: _breakfast,
                          onChanged: (bool value) =>
                              setState(() => _breakfast = value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CheckboxListTile(
                        title: const Text('I accept the hotel policy'),
                        value: _accepted,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool? value) {
                          setState(() {
                            _accepted = value ?? false;
                            _policyError = null;
                          });
                        },
                      ),
                      AnimatedOpacity(
                        opacity: _policyError != null ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 220),
                        child: _policyError != null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  bottom: 8,
                                ),
                                child: Text(_policyError!, style: errorStyle),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: FilledButton(
                  onPressed: _submit,
                  child: const Text('Reserve'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
