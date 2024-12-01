import 'package:flutter/material.dart';

import '../globals/style.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,

      children: [
        // search bar
        Flexible(
          child: SearchBar(
            hintText: "Search here...",
            hintStyle: WidgetStatePropertyAll(
                TextStyle(
                    color: dark50
                )
            ),

            textStyle: WidgetStatePropertyAll(
                TextStyle(
                    fontSize: text_md,
                )
            ),
          
            padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10, vertical:1)),
            backgroundColor: WidgetStatePropertyAll(light),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: borderSM)),
            elevation: const WidgetStatePropertyAll(0),
          ),
        ),

        const SizedBox(width: 10,),

        
        // search button
        MaterialButton(
          onPressed: () {},
          color: Color(0xffC3DAFC),
          minWidth: 46,
          elevation: 0,

          child: const Icon(Icons.search_rounded),
        )
      ],
    );
  }
}
