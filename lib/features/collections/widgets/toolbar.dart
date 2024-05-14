import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/features/assets/widgets/search_input.dart';
import 'package:tmz_damz/shared/widgets/toolbar_button.dart';

class Toolbar extends StatefulWidget {
  final TextEditingController? searchTermController;
  final VoidCallback onReload;
  final void Function() onSearchTermClear;
  final void Function(String searchTerm) onSearchTermChange;

  const Toolbar({
    super.key,
    required this.searchTermController,
    required this.onReload,
    required this.onSearchTermClear,
    required this.onSearchTermChange,
  });

  @override
  State<Toolbar> createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  @override
  Widget build(BuildContext context) {
    return _buildContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              SizedBox(
                width: 46,
                height: 44,
                child: ToolbarButton(
                  icon: MdiIcons.rotateRight,
                  onPressed: widget.onReload,
                ),
              ),
              const SizedBox(width: 4.0),
              Expanded(
                child: SearchInput(
                  controller: widget.searchTermController,
                  onClear: widget.onSearchTermClear,
                  onFieldSubmitted: widget.onSearchTermChange,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContainer({
    required Widget child,
  }) {
    return Container(
      color: const Color(0xFF232323),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF454647),
            ),
            borderRadius: BorderRadius.circular(6.0),
            color: const Color(0xFF353637),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
