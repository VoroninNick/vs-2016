String.prototype.capitalize = function() {
  var str = this
  return str.charAt(0).toUpperCase() + str.slice(1);
}