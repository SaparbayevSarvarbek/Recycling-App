import 'package:flutter/material.dart';
import '../models/bin_model.dart';

class LocationDetailsWidget extends StatefulWidget {
  final Bin bin;

  const LocationDetailsWidget({Key? key, required this.bin}) : super(key: key);

  @override
  State<LocationDetailsWidget> createState() => _LocationDetailsWidgetState();
}

class _LocationDetailsWidgetState extends State<LocationDetailsWidget> {
  bool _isFullScreen = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            final isNowFull = notification.extent >= 0.95;
            if (_isFullScreen != isNowFull) {
              setState(() {
                _isFullScreen = isNowFull;
              });
            }
            return true;
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 48.0, left: 16, right: 16, bottom: 16),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Recycling Centre',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 26, color: Color(0xFF1A441D)),
                        ),
                        Text(
                          widget.bin.name,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF1A441D)),
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: Image.asset(widget.bin.imagePath, height: 150),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Recycle Categories',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 26, color: Color(0xFF1A441D)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.bin.description,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFF1A441D)),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Instructions:',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 26, color: Color(0xFF1A441D)),
                        ),
                        Wrap(
                          spacing: 12,
                          alignment: WrapAlignment.center,
                          children: widget.bin.instructions.map((instr) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'For Cardboard,',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xFF1A441D)),
                                ),
                                Image.asset(
                                  instr.imagePath,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  instr.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  right: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Image.asset(
                          'assets/images/close.png',
                          width: 32,
                          height: 32,
                        ),
                      ),
                      if (!_isFullScreen)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => FractionallySizedBox(
                                heightFactor: 1.0,
                                child: LocationDetailsWidget(bin: widget.bin),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/fullscreen.png',
                            width: 32,
                            height: 32,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
