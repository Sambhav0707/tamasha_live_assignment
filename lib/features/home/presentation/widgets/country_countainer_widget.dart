import 'package:flutter/material.dart';
import 'package:tamasha_assignment/core/constants/app_colors.dart';

class CountryCountainerWidget extends StatelessWidget {
  final String? commonName;
  final String? officialName;
  final double? height;
  final double? width;

  const CountryCountainerWidget({
    super.key,
    this.commonName,
    this.officialName,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width ?? double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(isDark),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.getOutlineColor(isDark), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.getShadowColorWithOpacity(
              isDark,
              isDark ? 0.3 : 0.08,
            ),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Common name
          Text(
            commonName ?? "India",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.getOnSurfaceColor(isDark),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 12),
          // Common row with emoji
          Row(
            children: [
              Text("🌍 ", style: TextStyle(fontSize: 16)),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "common: ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.getOnSurfaceColor(isDark),
                        ),
                      ),
                      TextSpan(
                        text: commonName ?? "India",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColors.getOnSurfaceColor(isDark),
                        ),
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Official row with emoji
          Row(
            children: [
              Text("🏛️ ", style: TextStyle(fontSize: 16)),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "official: ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.getOnSurfaceColor(isDark),
                        ),
                      ),
                      TextSpan(
                        text: officialName ?? "Bharat",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColors.getOnSurfaceColor(isDark),
                        ),
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
