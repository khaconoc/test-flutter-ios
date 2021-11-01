extension MaxLengString on String {
  String maxLength({int len = 20}) {
    if(this.length < len) {
      return this;
    }
    return this.substring(0, len) + '...';
  }
}