import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:homesloc/controller/calender_controller.dart';
import 'package:homesloc/core/colors/colors.dart';

class CalendarBottomSheet extends StatefulWidget {
  const CalendarBottomSheet({super.key});

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  final calendarController = Get.find<CalendarController>();
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _firstDay = DateTime.now();
    _lastDay = DateTime.now().add(const Duration(days: 365));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: scaffoldColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // Handle bar at top of bottom sheet
          Container(
            margin: EdgeInsets.only(top: 10.h),
            width: 40.w,
            height: 5.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),

          // Calendar title
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              "Calendar",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: blue,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Calendar section - made flexible
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: blue),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomCalendar(
                  focusedDay: _focusedDay,
                  firstDay: _firstDay,
                  lastDay: _lastDay,
                  selectedDay: _selectedDay,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    calendarController.handleDayTapped(selectedDay);
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                ),
              ),
            ),
          ),

          // Date display section - fixed height
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Check-in date display
                Expanded(
                  child: Obx(() => Container(
                    padding: EdgeInsets.all(8.r),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: blue),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Check-In",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          calendarController.checkInDate.value != null
                              ? calendarController.formatDate(
                                  calendarController.checkInDate.value)
                              : "Select Date",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  )),
                ),

                // Total days display
                Expanded(
                  child: Obx(() => Container(
                    padding: EdgeInsets.all(8.r),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: blue),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${calendarController.totalDays.value}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          "Days",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  )),
                ),

                // Check-out date display
                Expanded(
                  child: Obx(() => Container(
                    padding: EdgeInsets.all(8.r),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: blue),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Check-Out",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          calendarController.checkOutDate.value != null
                              ? calendarController.formatDate(
                                  calendarController.checkOutDate.value)
                              : "Select Date",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  )),
                ),
              ],
            ),
          ),

          // Done button - fixed at bottom
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 43.h,
                decoration: BoxDecoration(
                  color: yellow,
                  borderRadius: BorderRadius.circular(28.sp),
                  boxShadow: [
                    BoxShadow(
                      color: yellow.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      color: black,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500
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
}

class CustomCalendar extends StatefulWidget {
  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime) onPageChanged;

  const CustomCalendar({
    Key? key,
    required this.focusedDay,
    required this.firstDay,
    required this.lastDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late PageController _pageController;
  late DateTime _focusedDay;
  final calendarController = Get.find<CalendarController>();

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.focusedDay;
    _pageController = PageController(
      initialPage: _getMonthIndex(_focusedDay),
    );
  }

  int _getMonthIndex(DateTime date) {
    return (date.year - widget.firstDay.year) * 12 + date.month - widget.firstDay.month;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Month header with navigation - more compact
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _previousMonth,
                icon: Icon(Icons.chevron_left, color: blue, size: 20.sp),
              ),
              Text(
                _getMonthYearString(_focusedDay),
                style: TextStyle(
                  color: blue,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              IconButton(
                onPressed: _nextMonth,
                icon: Icon(Icons.chevron_right, color: blue, size: 20.sp),
              ),
            ],
          ),
        ),
        // Weekday headers - more compact
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: _getWeekdayHeaders(),
          ),
        ),
        SizedBox(height: 4.h),
        // Calendar grid - flexible height
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              final newFocusedDay = DateTime(
                widget.firstDay.year + (index ~/ 12),
                widget.firstDay.month + (index % 12),
                1,
              );
              setState(() {
                _focusedDay = newFocusedDay;
              });
              widget.onPageChanged(newFocusedDay);
            },
            itemBuilder: (context, index) {
              final month = DateTime(
                widget.firstDay.year + (index ~/ 12),
                widget.firstDay.month + (index % 12),
                1,
              );
              return _buildMonthGrid(month);
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _getWeekdayHeaders() {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays.map((day) {
      return Expanded(
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: blue,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      );
    }).toList();
  }

  Widget _buildMonthGrid(DateTime month) {
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    
    // Calculate the number of weeks needed
    final totalDays = firstWeekday - 1 + daysInMonth;
    final weeks = (totalDays / 7).ceil();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: List.generate(weeks, (weekIndex) {
          return Expanded(
            child: Row(
              children: List.generate(7, (dayIndex) {
                final dayNumber = weekIndex * 7 + dayIndex - (firstWeekday - 1) + 1;
                
                if (dayNumber < 1 || dayNumber > daysInMonth) {
                  return Expanded(child: Container());
                }

                final date = DateTime(month.year, month.month, dayNumber);
                final isToday = _isToday(date);
                final isSelected = _isSelected(date);
                final isInRange = _isInRange(date);
                final isPast = date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

                return Expanded(
                  child: GestureDetector(
                    onTap: isPast ? null : () => widget.onDaySelected(date, date),
                    child: Container(
                      margin: EdgeInsets.all(1.r),
                      decoration: BoxDecoration(
                        color: _getDayColor(date, isToday, isSelected, isInRange),
                        borderRadius: BorderRadius.circular(6.r),
                        border: isToday ? Border.all(color: blue, width: 1.5) : null,
                      ),
                      child: Center(
                        child: Text(
                          dayNumber.toString(),
                          style: TextStyle(
                            color: _getDayTextColor(date, isToday, isSelected, isInRange),
                            fontSize: 11.sp,
                            fontWeight: isToday || isSelected ? FontWeight.bold : FontWeight.normal,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }

  Color _getDayColor(DateTime date, bool isToday, bool isSelected, bool isInRange) {
    if (isSelected) return yellow;
    if (isInRange) return grey;
    if (isToday) return blue.withOpacity(0.1);
    if (date.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return Colors.grey.withOpacity(0.1);
    }
    return Colors.transparent;
  }

  Color _getDayTextColor(DateTime date, bool isToday, bool isSelected, bool isInRange) {
    if (isSelected) return black;
    if (isInRange) return blue;
    if (isToday) return blue;
    if (date.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return Colors.grey;
    }
    return black;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool _isSelected(DateTime date) {
    return (calendarController.checkInDate.value != null && 
            _isSameDay(date, calendarController.checkInDate.value!)) ||
           (calendarController.checkOutDate.value != null && 
            _isSameDay(date, calendarController.checkOutDate.value!));
  }

  bool _isInRange(DateTime date) {
    if (calendarController.checkInDate.value == null || 
        calendarController.checkOutDate.value == null) {
      return false;
    }
    
    return date.isAfter(calendarController.checkInDate.value!) &&
           date.isBefore(calendarController.checkOutDate.value!);
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && 
           date1.month == date2.month && 
           date1.day == date2.day;
  }

  String _getMonthYearString(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  void _previousMonth() {
    if (_focusedDay.month > widget.firstDay.month || 
        _focusedDay.year > widget.firstDay.year) {
      final newFocusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
      setState(() {
        _focusedDay = newFocusedDay;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      widget.onPageChanged(newFocusedDay);
    }
  }

  void _nextMonth() {
    if (_focusedDay.month < widget.lastDay.month || 
        _focusedDay.year < widget.lastDay.year) {
      final newFocusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
      setState(() {
        _focusedDay = newFocusedDay;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      widget.onPageChanged(newFocusedDay);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
} 