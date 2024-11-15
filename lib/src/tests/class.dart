
main() {
  A a = C();
  print(a.getX);
}

interface class A{
  final int _x = 50;
  int get getX {
    return _x;
  }
  int y = 0;
}

final class C extends A{
  void test(){}
}
