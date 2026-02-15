import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homesloc/core/colors/colors.dart';
import 'package:homesloc/models/freshup/freshup_availability_model.dart';

class FreshupSlotRow extends StatefulWidget {
  final List<FreshupSlot>? slots;
  final Function(List<String>)? onSlotsSelected;
  final List<String> initialSelectedSlotIds;

  const FreshupSlotRow({
    super.key,
    this.slots,
    this.onSlotsSelected,
    this.initialSelectedSlotIds = const [],
  });

  @override
  State<FreshupSlotRow> createState() => _FreshupSlotRowState();
}

class _FreshupSlotRowState extends State<FreshupSlotRow> {
  late List<String> _selectedSlotIds;

  @override
  void initState() {
    super.initState();
    _selectedSlotIds = List.from(widget.initialSelectedSlotIds);
  }

  @override
  void didUpdateWidget(FreshupSlotRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelectedSlotIds != oldWidget.initialSelectedSlotIds) {
      _selectedSlotIds = List.from(widget.initialSelectedSlotIds);
    }
  }

  void _toggleSlot(String slotId) {
    setState(() {
      if (_selectedSlotIds.contains(slotId)) {
        _selectedSlotIds.remove(slotId);
      } else {
        _selectedSlotIds.add(slotId);
      }
    });
    widget.onSlotsSelected?.call(_selectedSlotIds);
  }

  @override
  Widget build(BuildContext context) {
    final displaySlots = widget.slots ?? [];

    if (displaySlots.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Text(
          'No slots available for this date',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: fontColor,
            fontSize: 12.sp,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: displaySlots.map((slot) {
            final isSelected = _selectedSlotIds.contains(slot.id);
            return GestureDetector(
              onTap: () => _toggleSlot(slot.id ?? ""),
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? blue.withOpacity(0.05) : gwhite,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                      color: isSelected ? blue : border,
                      width: isSelected ? 1.5 : 0.5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            size: 14.sp, color: isSelected ? blue : grey),
                        SizedBox(width: 6.w),
                        Text(
                          'Stay Slot',
                          style: TextStyle(
                            color: isSelected ? blue : grey,
                            fontFamily: 'Poppins',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "${slot.checkIn ?? 'N/A'} - ${slot.checkOut ?? 'N/A'}",
                      style: TextStyle(
                        color: black,
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
