import 'package:flutter/material.dart';
import 'package:tamasha_assignment/core/constants/app_colors.dart';
import 'package:tamasha_assignment/features/home/data/model/country_model.dart';
import 'package:tamasha_assignment/features/home/domain/entities/country.dart';

class DetailScreen extends StatelessWidget {
  final CountryModel country;

  const DetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(isDark),
      body: SafeArea(
        child: Column(
          children: [
            // Minimal App Bar
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.getSurfaceColor(isDark),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.getShadowColorWithOpacity(
                      isDark,
                      isDark ? 0.3 : 0.05,
                    ),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.getOnSurfaceColor(isDark),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Country Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.getOnSurfaceColor(isDark),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Country Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.getSurfaceColor(isDark),
                        borderRadius: BorderRadius.circular(16),
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
                        children: [
                          // Country Icon
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.getPrimaryContainerColor(isDark),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.flag,
                              size: 28,
                              color: AppColors.getPrimaryColor(isDark),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Country Name
                          Text(
                            country.name.common,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppColors.getOnSurfaceColor(isDark),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            country.name.official,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.getOnSurfaceVariantColor(isDark),
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Info Cards
                    _buildInfoCard(
                      context: context,
                      title: 'Official Name',
                      content: country.name.official,
                      icon: Icons.verified,
                      iconColor: const Color(0xFF10B981),
                    ),
                    const SizedBox(height: 12),

                    _buildInfoCard(
                      context: context,
                      title: 'Common Name',
                      content: country.name.common,
                      icon: Icons.language,
                      iconColor: const Color(0xFF3B82F6),
                    ),

                    // Native Names Section
                    if (country.name.nativeName != null &&
                        country.name.nativeName!.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        'Native Names',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.getOnSurfaceColor(isDark),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...country.name.nativeName!.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _buildNativeNameCard(
                            context: context,
                            languageCode: entry.key,
                            nativeName: entry.value,
                          ),
                        );
                      }).toList(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required String title,
    required String content,
    required IconData icon,
    required Color iconColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(isDark),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.getShadowColorWithOpacity(
              isDark,
              isDark ? 0.3 : 0.05,
            ),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.getOnSurfaceVariantColor(isDark),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.getOnSurfaceColor(isDark),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNativeNameCard({
    required BuildContext context,
    required String languageCode,
    required NativeName nativeName,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(isDark),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.getOutlineColor(isDark), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.getPrimaryContainerColor(isDark),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  languageCode.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.getPrimaryColor(isDark),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.translate,
                color: AppColors.getPrimaryColor(isDark),
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildNativeNameRow(context, 'Official', nativeName.official),
          const SizedBox(height: 6),
          _buildNativeNameRow(context, 'Common', nativeName.common),
        ],
      ),
    );
  }

  Widget _buildNativeNameRow(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            '$label:',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.getOnSurfaceVariantColor(isDark),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.getOnSurfaceColor(isDark),
            ),
          ),
        ),
      ],
    );
  }
}
