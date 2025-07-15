class Product {
  String _name;
  String _dscription;
  double _price;

  Product(this._name, this._dscription, this._price);

  String get name => _name;
  String get description => _dscription;
  double get price => _price;

  set name(String name) => _name = name;
  set description(String description) => _dscription = description;
  set price(double price) => _price = price;

  @override
  String toString() {
    return 'Name: $_name\nDescription: $_dscription\nPrice:\$$_price';
  }
}
