#ifndef _BST_H
#define _BST_H
#include "Node.h"
#include <vector>
class BST
{
	Node *root;
	unsigned count;
	unsigned depth(Node *);

public:
	BST();
	BST(BST &);
	~BST();
	void insert(int);
	std::vector<int> getNodes();
	Node *findNode(int);
};

#endif // _BST_H