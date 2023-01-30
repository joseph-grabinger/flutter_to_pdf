class TeaRowItem {
  final String imageURL;
  final void Function() onTap;

  const TeaRowItem({
    required this.imageURL,
    required this.onTap,
  });
}