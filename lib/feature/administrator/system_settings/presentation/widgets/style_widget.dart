import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class ColorPickerField extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onChanged;
  final String? label;
  final String? heading;

  const ColorPickerField({
    super.key,
    required this.initialColor,
    required this.onChanged,
    this.label, this.heading,
  });

  @override
  State<ColorPickerField> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends State<ColorPickerField> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = widget.initialColor;
  }

  Future<void> _openPicker() async {Color temp = _color;
    await showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text(widget.label ?? 'Pick a color'),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
                ColorPicker(pickerColor: temp, onColorChanged: (c) => temp = c,
                  pickerAreaHeightPercent: 0.7,
                  enableAlpha: false,
                  displayThumbColor: true),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(onPressed: () {
                setState(() => _color = temp);
                widget.onChanged(_color);
                log("color is $_color");
                Navigator.pop(context);
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(10);
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: InkWell(onTap: _openPicker, borderRadius: border,
        child: CustomContainer(showShadow: false,border: Border.all(color: Theme.of(context).hintColor, width: .5),
          borderRadius: Dimensions.paddingSizeExtraSmall,
          child: Row(children: [
            Text("${widget.heading ?? widget.label ?? 'sidebar_color'.tr}: ", style: textRegular.copyWith(fontSize: 14, color: Theme.of(context).hintColor)),

              CustomContainer(width: 28, height: 28,color: _color, showShadow: false,borderRadius: 5,),
              const SizedBox(width: 12),
              Expanded(child: Text('#${_color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
                  style: textRegular.copyWith(fontFeatures: [const FontFeature.tabularFigures()])),
              ),
              const Icon(Icons.color_lens_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
