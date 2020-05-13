#include "BST.h"

BST::BST() : root(NULL), count(0)
{
}

BST::BST(BST &tree)
{
	root = NULL; // init the current tree with root=NULL and count=0
	count = 0;	 // so that we can use the insert function
	Node **stack = new Node *[tree.count];
	unsigned stack_size = 0;
	stack[stack_size++] = tree.root;
	while (stack_size > 0)
	{ // traverse the tree in preorder and insert each node in the current tree
		Node *p = stack[--stack_size];
		insert(p->value);
		if (p->right != NULL)
		{
			stack[stack_size++] = p->right;
		}
		if (p->left != NULL)
		{
			stack[stack_size++] = p->left;
		}
	}
	delete[] stack;
	count = tree.count;
}

void BST::insert(int x)
{
	if (root == NULL)
	{ // empty tree insert
		count++;
		root = new Node(x);
		return;
	}
	Node *p = root;
	while (p != NULL)
	{
		if (x < p->value)
		{ // if x is bigger than the value in the current node
			if (p->left != NULL)
			{ // if p has a left child, keep searching in tree
				p = p->left;
			}
			else
			{ // if p has no left child, create a child that will hold value x and stop
				p->left = new Node(x);
				p = NULL;
				count++;
			}
		}
		else if (x > p->value)
		{ // if p has a right child, keep searching in tree
			if (p->right != NULL)
			{
				p = p->right;
			}
			else
			{ // if p has no right child, create a child that will hold value x and stop
				p->right = new Node(x);
				p = NULL;
				count++;
			}
		}
		else
		{ // value already in tree, stop
			p = NULL;
		}
	}
}

std::vector<int> BST::getNodes()
{
	std::vector<int> result;
	if (this->root == NULL)
	{
		return {};
	}
	Node **stack = new Node *[this->count];
	unsigned stack_size = 0;
	Node *p = this->root; // inorder traversal iterative
	while (p != NULL || stack_size > 0)
	{
		if (p != NULL)
		{ // if p is not null we insert in the stack and go to p->left
			stack[stack_size++] = p;
			p = p->left;
		}
		else
		{ // else, remove the tos, print its value and go to its right
			p = stack[--stack_size];
			result.push_back(p->value);
			p = p->right;
		}
	}
	delete[] stack;
	return result;
}

Node *BST::findNode(int x)
{
	Node *node = root, *parent = root;
	while (node != NULL)
	{ // search the node and keep track of the parent;
		if (node->value == x)
		{
			return node;
		}
		else if (x < node->value)
		{
			parent = node;
			node = node->left;
		}
		else
		{
			parent = node;
			node = node->right;
		}
	}
	return NULL;
}

BST::~BST()
{
	Node **stack = new Node *[count];
	unsigned stack_size = 0;
	stack[stack_size++] = root;
	while (stack_size > 0)
	{
		Node *p = stack[--stack_size];
		if (p->left != NULL)
		{
			stack[stack_size++] = p->left;
		}
		if (p->right != NULL)
		{
			stack[stack_size++] = p->right;
		}
		delete p;
	}
	root = NULL;
	count = 0;
}