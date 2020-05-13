#include "Node.h"

Node::Node(int val, Node *l, Node *r) : value(val), left(l), right(r)
{
	objects++;
}

Node::Node(Node &n) : value(n.value), left(n.left), right(n.right)
{
	objects++;
}

unsigned Node::objects = 0;