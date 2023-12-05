class IpsumGenerator {
  static const List<String> _ipsumParagraphs = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Diam volutpat commodo sed egestas. Dui faucibus in ornare quam viverra orci. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque. Tempor orci dapibus ultrices in iaculis nunc sed augue lacus.',
    'Eros donec ac odio tempor orci dapibus. Egestas maecenas pharetra convallis posuere morbi leo. Faucibus ornare suspendisse sed nisi lacus sed viverra. Odio morbi quis commodo odio aenean sed adipiscing diam. Nulla facilisi nullam vehicula ipsum a arcu cursus.',
    'Fermentum posuere urna nec tincidunt praesent semper feugiat. Posuere sollicitudin aliquam ultrices sagittis orci. Vitae sapien pellentesque habitant morbi tristique senectus et netus. Ipsum a arcu cursus vitae congue.',
    'Consequat semper viverra nam libero justo laoreet sit. Fermentum posuere urna nec tincidunt praesent semper feugiat. Nec dui nunc mattis enim. Viverra ipsum nunc aliquet bibendum enim facilisis gravida.',
    'Egestas pretium aenean pharetra magna ac placerat vestibulum. At varius vel pharetra vel. Netus et malesuada fames ac. Morbi tincidunt augue interdum velit euismod in pellentesque.'
  ];

  static String generate(int paragraphCount) {
    return List<String>.generate(
            paragraphCount.clamp(0, _ipsumParagraphs.length),
            (index) => _ipsumParagraphs[index % _ipsumParagraphs.length])
        .join('\n\n');
  }
}
