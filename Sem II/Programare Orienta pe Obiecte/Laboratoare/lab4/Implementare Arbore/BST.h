#ifndef _BST_H
#define _BST_H
#include "Node.h"

class BST {
	Node* root;
	unsigned count;
	unsigned depth(Node*);
public:
	BST();
	BST(BST&);
	~BST();
	void insert(int);
	unsigned getSize();
	friend void printTree(BST);
	static int* preorder(BST);
	static int* postorder(BST);
	unsigned height();
	static void print(BST, int);
	void remove(int);
};

#endif // _BST_H