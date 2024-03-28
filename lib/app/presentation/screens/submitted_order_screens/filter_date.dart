import 'package:flutter/material.dart';

class DateField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onTap;
  const DateField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    return PrimaryContainerFilter(
      radius: 10,
      child: TextFormField(
        readOnly: true,
        style: const TextStyle(fontSize: 16, color: Colors.white),
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        onTap: widget.onTap,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 3),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: widget.hintText,
          suffixIcon: Icon(Icons.calendar_today),
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }
}

class PrimaryContainerFilter extends StatelessWidget {
  final Widget child;
  final double? radius;
  final Color? color;

  const PrimaryContainerFilter({
    Key? key,
    required this.child,
    this.radius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 30),
        boxShadow: [
          BoxShadow(
            color: color ?? const Color(0XFF1E1E1E),
          ),
          const BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 0,
            color: Colors.black,
          ),
        ],
      ),
      child: child,
    );
  }
}
