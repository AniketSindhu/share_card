class CreditModel{
  final int cards;
  final int price;
  final int credits;
  CreditModel({this.cards,this.price,this.credits}); 
}

List<CreditModel> addCreditsList=[
  CreditModel(cards:10,price:10,credits:10 ),
  CreditModel(cards:30,price:25,credits: 30),
  CreditModel(cards:50,price:40,credits: 50),
  CreditModel(cards:100,price:99,credits: 100)
];