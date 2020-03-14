#include "Nod.h"
#include "Lista.h"

using namespace std;

void f(Lista l, int x) { // with no copy constructor, changes made in function f are visible outside
	l.print();
	l.insert(x);
}

int main() {
	Lista l(4);
	l.print();
	Lista l2(4, 3);
	l2.print();
	l2.insertAt(2, 2);
	l2.print();
	l2.insertAt(4, 4);
	l2.print();
	l2.insert(10);
	l2.print();
	l2.remove(4);
	l2.print();
	l2.reverse().print();
	cout << l2.hasDuplicates();
	cin.get();
	return 0;
}