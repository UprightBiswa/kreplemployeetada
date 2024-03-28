import 'package:flutter/material.dart';
import 'package:kreplemployee/app/data/constants/constants.dart';

class AttendanceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? itemColor;
  final VoidCallback? onTap;

  const AttendanceCard({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.itemColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 0,
      color: itemColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusFifty),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDarkMode(context)
                ? const Color(0xFFEAF6EF)
                : AppColors.kAccent7,
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 32,
            color: isDarkMode(context)
                ? AppColors.kSecondary
                : const Color(0xFFEAF6EF),
          ),
        ),
        title: Text(
          title,
          style: AppTypography.kBold16.copyWith(
            color: isDarkMode(context) ? AppColors.kWhite : AppColors.kGrey,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: AppTypography.kLight12.copyWith(
                  color:
                      isDarkMode(context) ? AppColors.kWhite : AppColors.kGrey,
                ),
              )
            : null,
        trailing: Icon(
          Icons.navigate_next,
          color:
              isDarkMode(context) ? const Color(0xFFEAF6EF) : AppColors.kGrey,
        ),
      ),
    );
  }
}
