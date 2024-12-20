import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';

import '../search/searchable_country.dart';
import '_no_result_view.dart';

class CountryListView extends StatelessWidget {
  /// Callback function triggered when user select a country
  final Function(SearchableCountry) onTap;

  /// List of countries to display
  final List<SearchableCountry> countries;
  final double? flagSize;

  /// list of favorite countries to display at the top
  final List<SearchableCountry> favorites;

  /// proxy to the ListView.builder controller (ie: [ScrollView.controller])
  final ScrollController? scrollController;

  /// The [ScrollPhysics] of the Country List
  final ScrollPhysics? scrollPhysics;

  /// whether the country dialcode should be displayed as the [ListTile.subtitle]
  final bool showDialCode;

  final String? noResultMessage;

  final TextStyle? subtitleStyle;
  final TextStyle? titleStyle;
  final Color? dividerColor;
  final Color? countryListBackgroundColor;

  const CountryListView({
    super.key,
    required this.countries,
    required this.favorites,
    required this.onTap,
    required this.noResultMessage,
    this.scrollController,
    this.dividerColor,
    this.scrollPhysics,
    this.countryListBackgroundColor,
    this.showDialCode = true,
    this.flagSize = 40,
    this.subtitleStyle,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final allListElements = [
      ...favorites,
      if (favorites.isNotEmpty) null,
      ...countries,
    ];

    if (allListElements.isEmpty) {
      return NoResultView(title: noResultMessage);
    }

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: countryListBackgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListView.builder(
        physics: scrollPhysics,
        controller: scrollController,
        itemCount: allListElements.length,
        itemBuilder: (BuildContext context, int index) {
          final country = allListElements[index];
          if (country == null) {
            return Divider(height: 1, color: dividerColor ?? Colors.grey); // Separator
          }

          return GestureDetector(
            onTap: () => onTap(country),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Row(
                    children: [
                      CircleFlag(
                        country.isoCode.name,
                        size: flagSize ?? 40,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          country.name,
                          style: titleStyle ?? const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      if (showDialCode)
                        Text(
                          country.formattedCountryDialingCode,
                          style: subtitleStyle ?? const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                    ],
                  ),
                ),
                if (index != allListElements.length - 1) Divider(height: 1, color: dividerColor ?? Colors.grey), // Add separator
              ],
            ),
          );
        },
      ),
    );
  }
}
