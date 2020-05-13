#ifndef _NODE_H
#define _NODE_H
#include <iostream>

class BST;

class Node
{
	int value;
	Node *left, *right;
	static unsigned objects;

public:
	Node(int val = 0, Node *l = NULL, Node *r = NULL);
	Node(Node &);
	friend class BST;
	friend void printTree(BST);
};

#endif // _NODE_H