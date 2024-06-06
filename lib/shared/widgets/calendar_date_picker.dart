import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarDatePicker extends StatelessWidget {
  static const kTextStyle = TextStyle(
    color: Color(0xDEFFFFFF),
  );
  static const kWeekdayLabels = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];

  final DateTime? selectedDate;
  final void Function(DateTime? value) onValueChanged;

  const CalendarDatePicker({
    super.key,
    this.selectedDate,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        calendarType: CalendarDatePicker2Type.single,
        controlsTextStyle: kTextStyle,
        weekdayLabels: kWeekdayLabels,
        dayTextStyle: kTextStyle,
        monthTextStyle: kTextStyle,
        selectedDayTextStyle: const TextStyle(
          color: Colors.black,
        ),
        weekdayLabelTextStyle: kTextStyle.copyWith(
          color: kTextStyle.color!.withAlpha(80),
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
        ),
        yearTextStyle: kTextStyle,
        useAbbrLabelForMonthModePicker: true,
      ),
      value: [selectedDate],
      onValueChanged: (value) {
        onValueChanged(value.firstOrNull);
      },
    );
  }
}

class CalendarDatePickerDropdown extends StatelessWidget {
  final DateTime? selectedDate;
  final void Function(DateTime? value) onValueChanged;

  const CalendarDatePickerDropdown({
    super.key,
    this.selectedDate,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonStyleData: ButtonStyleData(
          height: 42.0,
          padding: const EdgeInsets.only(right: 6.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF454647),
            ),
            borderRadius: BorderRadius.circular(6.0),
            color: const Color(0xFF1D1E1F),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.grey.shade800,
          ),
          padding: EdgeInsets.zero,
          width: 430.0,
        ),
        iconStyleData: const IconStyleData(
          iconDisabledColor: Color(0xFF505255),
          iconEnabledColor: Color(0xFFA4A4A4),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: 420.0,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          padding: const EdgeInsets.all(10.0),
        ),
        isDense: true,
        isExpanded: true,
        value: selectedDate,
        items: [
          DropdownMenuItem<DateTime>(
            value: selectedDate,
            child: _CalendarDatePickerDropdownItem(
              selectedDate: selectedDate,
              onValueChanged: onValueChanged,
            ),
          ),
        ],
        selectedItemBuilder: (context) {
          return [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(
                (selectedDate != null)
                    ? DateFormat.yMMMMd().format(selectedDate!)
                    : '',
              ),
            ),
          ];
        },
        onChanged: (value) {
          // do nothing; needed to "enable" the dropdown
        },
      ),
    );
  }
}

class _CalendarDatePickerDropdownItem extends StatefulWidget {
  final DateTime? selectedDate;
  final void Function(DateTime? value) onValueChanged;

  const _CalendarDatePickerDropdownItem({
    this.selectedDate,
    required this.onValueChanged,
  });

  @override
  State<_CalendarDatePickerDropdownItem> createState() =>
      _CalendarDatePickerDropdownItemState();
}

class _CalendarDatePickerDropdownItemState
    extends State<_CalendarDatePickerDropdownItem> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextButton(
          onPressed: () {},
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
            shape: WidgetStateProperty.all(const RoundedRectangleBorder()),
          ),
          child: const SizedBox.expand(),
        ),
        IgnorePointer(
          child: Container(),
        ),
        Column(
          children: [
            CalendarDatePicker(
              selectedDate: _selectedDate,
              onValueChanged: (value) {
                setState(() {
                  _selectedDate = value;
                });
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Row(
                  children: [
                    _buildClearButton(),
                    const Spacer(),
                    _buildApplyButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildApplyButton() {
    return SizedBox(
      width: 100.0,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          widget.onValueChanged(_selectedDate);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            const Color(0x30FFFFFF),
          ),
          shape: WidgetStateProperty.resolveWith(
            (states) {
              return RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color(0x80000000),
                ),
                borderRadius: BorderRadius.circular(6.0),
              );
            },
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            'Apply',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return SizedBox(
      width: 100.0,
      child: TextButton(
        onPressed: (_selectedDate != null)
            ? () {
                setState(() {
                  _selectedDate = null;
                });
              }
            : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            const Color(0x30FFFFFF),
          ),
          shape: WidgetStateProperty.resolveWith(
            (states) {
              return RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color(0x80000000),
                ),
                borderRadius: BorderRadius.circular(6.0),
              );
            },
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            'Clear',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: (_selectedDate == null) ? Colors.black54 : null,
                ),
          ),
        ),
      ),
    );
  }
}
