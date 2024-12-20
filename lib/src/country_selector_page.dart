import 'package:flutter/material.dart';
import 'package:flutter_country_selector/src/country_selector_base.dart';
import 'package:flutter_svg/svg.dart';

import 'localization/localization.dart';
import 'widgets/_country_list_view.dart';
import 'widgets/_search_box.dart';

/// Same as [CountrySelectorSheet] but designed as a full page
class CountrySelectorPage extends CountrySelectorBase {
  const CountrySelectorPage({
    super.key,
    required super.onCountrySelected,
    super.scrollController,
    super.scrollPhysics,
    super.showDialCode,
    super.countryListBackgroundColor,
    super.noResultMessage,
    super.favoriteCountries,
    super.countries,
    super.dividerColor,
    super.searchAutofocus,
    super.backgroundWidget,
    super.subtitleStyle,
    super.titleStyle,
    super.searchBoxDecoration,
    super.backButtonIcon,
    super.backgroundDecoration,
    super.searchBoxTextStyle,
    super.searchBoxIconColor,
    super.flagSize,
  });

  @override
  CountrySelectorPageState createState() => CountrySelectorPageState();
}

class CountrySelectorPageState extends CountrySelectorBaseState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const SizedBox.shrink(),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: widget.backButtonIcon ?? const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          if (widget.backgroundWidget != null)
            Positioned.fill(
              child: widget.backgroundWidget!,
            ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                      onChanged: onSearch,
                      onSubmitted: (_) => onSubmitted(),
                      style: widget.searchBoxTextStyle,
                      decoration: widget.searchBoxDecoration),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      return CountryListView(
                        countries: controller.filteredCountries,
                        favorites: controller.filteredFavorites,
                        showDialCode: widget.showDialCode,
                        countryListBackgroundColor: widget.countryListBackgroundColor,
                        dividerColor: widget.dividerColor,
                        onTap: (country) => widget.onCountrySelected(country.isoCode),
                        flagSize: widget.flagSize,
                        scrollController: widget.scrollController,
                        scrollPhysics: widget.scrollPhysics,
                        noResultMessage: widget.noResultMessage,
                        titleStyle: widget.titleStyle,
                        subtitleStyle: widget.subtitleStyle,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
