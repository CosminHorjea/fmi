#include "Node.h"
#include "BST.h"
#include <iostream>
using namespace std;

void showAndDelete(int *v, unsigned count) {
	for (unsigned i = 0; i < count; i++) {
		cout << v[i] << " ";
	}
	delete[] v;
}

int main() {
	BST b;
	b.insert(10);
	b.insert(8);
	b.insert(4);
	b.insert(16);
	b.insert(13);
	b.insert(11);
	b.insert(20);
	b.insert(22);
	printTree(b);
	int *v = BST::preorder(b);
	cout << endl;
	showAndDelete(v, b.getSize());
	v = BST::postorder(b);
	cout << endl;
	showAndDelete(v, b.getSize());
	cout << endl;
	cout << "The height is " << b.height() << endl;
	b.remove(4);
	b.remove(13);
	b.remove(20);
	b.remove(10);
	BST::print(b, 1);
	cin.get();
	return 0;
}