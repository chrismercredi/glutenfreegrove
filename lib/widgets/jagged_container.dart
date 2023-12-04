import 'package:flutter/material.dart';

import '../utils/utils.dart';

class JaggedContainer extends StatelessWidget {
  final double? strokeWidth;
  final double? aspectRatio;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;
  final String? assetImage;
  final String? networkImage;
  final VoidCallback onEdit;

  const JaggedContainer({
    Key? key,
    this.strokeWidth = 1.0,
    this.aspectRatio = 1.0,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.assetImage,
    this.networkImage,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the icon color based on the image presence
    Color iconColor = (networkImage == null && assetImage == null)
        ? Colors.white
        : Colors.black;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0,
        maxWidth: maxWidth ?? double.infinity,
        minHeight: minHeight ?? 0,
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: AspectRatio(
        aspectRatio: aspectRatio!,
        child: Stack(
          children: [
            CustomPaint(
              painter: JaggedHandDrawnBorderPainter(
                strokeWidth: strokeWidth!,
              ),
              child:
                  Container(), // Empty container for the CustomPaint to paint over
            ),
            Positioned(
              top: 1,
              right: 1,
              child: IconButton(
                onPressed: onEdit,
                icon: Icon(Icons.edit, color: iconColor),
              ),
            ),
            _buildImage(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (networkImage != null) {
      return ClipRect(
        child: Image.network(
          networkImage!,
          fit: BoxFit.cover,
        ),
      );
    } else if (assetImage != null) {
      return ClipRect(
        child: Image.asset(
          assetImage!,
          fit: BoxFit.cover,
        ),
      );
    } else {
      // Default 'no image' icon
      return Container(
        color: Colors.black,
        child: const Center(
          child: Icon(Icons.image_not_supported, color: Colors.white),
        ),
      );
    }
  }
}
// }
//             _buildImage(),
//             CustomPaint(
//               painter: JaggedHandDrawnBorderPainter(
//                 strokeWidth: strokeWidth!,
//               ),
//               child:
//                   Container(), // Empty container for the CustomPaint to paint over
//             ),
//             Positioned(
//               top: 1,
//               right: 1,
//               child: IconButton(
//                 onPressed: onEdit,
//                 icon: Icon(Icons.edit, color: iconColor),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImage() {
//     if (networkImage != null) {
//       return ClipRect(
//         child: Image.network(
//           networkImage!,
//           fit: BoxFit.cover,
//         ),
//       );
//     } else if (assetImage != null) {
//       return ClipRect(
//         child: Image.asset(
//           assetImage!,
//           fit: BoxFit.cover,
//         ),
//       );
//     } else {
//       // Default 'no image' icon
//       return Container(
//         color: Colors.black,
//         child: const Center(
//           child: Icon(Icons.image_not_supported, color: Colors.white),
//         ),
//       );
//     }
//   }
// }