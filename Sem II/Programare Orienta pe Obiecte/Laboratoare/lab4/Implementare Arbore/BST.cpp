#include "BST.h"

BST::BST() : root(NULL), count(0) {

}

BST::BST(BST &tree) {
	root = NULL;                                 // init the current tree with root=NULL and count=0
	count = 0;                                   // so that we can use the insert function
	Node** stack = new Node*[tree.count];
	unsigned stack_size = 0;
	stack[stack_size++] = tree.root;
	while (stack_size > 0) {                    // traverse the tree in preorder and insert each node in the current tree
		Node* p = stack[--stack_size];
		insert(p->value);
		if (p->right != NULL) {
			stack[stack_size++] = p->right;
		}
		if (p->left != NULL) {
			stack[stack_size++] = p->left;
		}
	}
	delete[] stack;
	count = tree.count;
}

void BST::insert(int x) {
	if (root == NULL) {                  // empty tree insert
		count++;
		root = new Node(x);
		return;
	}
	Node *p = root;
	while (p != NULL) {
		if (x < p->value) {              // if x is bigger than the value in the current node
			if (p->left != NULL) {       // if p has a left child, keep searching in tree
				p = p->left;
			}
			else {                      // if p has no left child, create a child that will hold value x and stop
				p->left = new Node(x);
				p = NULL;
				count++;
			}
		}
		else if (x > p->value) {       // if p has a right child, keep searching in tree
			if (p->right != NULL) {
				p = p->right;
			}
			else {                     // if p has no right child, create a child that will hold value x and stop
				p->right = new Node(x);
				p = NULL;
				count++;
			}
		}
		else {                         // value already in tree, stop
			p = NULL;
		}
	}
}

unsigned BST::getSize() {
	return count;
}

void printTree(BST tree) {
	if (tree.root == NULL) {
		return;
	}
	Node** stack = new Node*[tree.count];
	unsigned stack_size = 0;
	Node* p = tree.root;                     // inorder traversal iterative
	while (p != NULL || stack_size > 0) {
		if (p != NULL) {                     // if p is not null we insert in the stack and go to p->left
			stack[stack_size++] = p;
			p = p->left;
		}
		else {                               // else, remove the tos, print its value and go to its right
			p = stack[--stack_size];
			std::cout << p->value << " ";
			p = p->right;
		}
	}
	delete[] stack;
}

int* BST::preorder(BST tree) {
	if (tree.root == NULL) {
		return NULL;
	}
	Node** stack = new Node*[tree.count];
	int *vector = new int[tree.count], vector_size = 0;
	unsigned stack_size = 0;                   // preoder traversal iterative
	stack[stack_size++] = tree.root;           // insert the root in the stack
	while (stack_size > 0) {                   // while the stack is not empty 
		Node* p = stack[--stack_size];         // extract the tox
		vector[vector_size++] = p->value;      // push it in the array
		if (p->right != NULL) {                // if the node has a right child
			stack[stack_size++] = p->right;    // push it to the stack
		}
		if (p->left != NULL) {                 // if the node has a left child
			stack[stack_size++] = p->left;     // push it to the stack
		}                                      // add the left child second because it will be the first to be popped at the next step
	}
	delete[] stack;                            // free the stack
	return vector;                             // return the array containing the elements in preorder
}

int* BST::postorder(BST tree) {
	if (tree.root == NULL) {
		return NULL;
	}
	Node** stack = new Node*[tree.count];
	int *vector = new int[tree.count], vector_size = 0;
	unsigned stack_size = 0;
	Node* p = tree.root;                                               // postorder traversal right-left-root
	do {
		while (p != NULL) {                                            // while p is not NULL move to the left most node
			if (p->right != NULL) {                                    // if the node has a right child
				stack[stack_size++] = p->right;                        // add it to the stack
			}
			stack[stack_size++] = p;                                   // add the node to the stack
			p = p->left;                                               // move p to the left
		}
		p = stack[--stack_size];                                       // pop the tos into p
		if (p->right != NULL && stack[stack_size - 1] == p->right) {   // if p has a right child and the child is the tos
			stack[stack_size - 1] = p;                                 // make p tos
			p = p->right;                                              // move to the right to process the right child first
		}
		else {
			vector[vector_size++] = p->value;                          // else, add the value from p in the array
			p = NULL;                                                  // make p NULL, to check the new tos
		}
	} while (stack_size > 0);
	delete[] stack;
	return vector;
}

unsigned BST::depth(Node* p) {
	if (p == NULL) {                   // if the node is null then depth is 0
		return 0; 
	}
	unsigned r = depth(p->right);     // compute the depth the right child
	unsigned l = depth(p->left);      // compute the depth of the left child
	if (l > r) {                      // if the left child is taller than the right
		return l + 1;                 // return l+1 as depth
	}
	return r + 1;                     // else return r+1
}

unsigned BST::height() {
	return depth(root);              // return the depth of the root node
}

void BST::print(BST tree, int i) {
	int *v;
	if (i == 0) {
		v = preorder(tree);                            // if i is 0 compute the preorder array
	}
	else {
		v = postorder(tree);                           // else compute the postorder array
	}
	for (unsigned i = 0; i < tree.getSize(); i++) {    // print the array
		std::cout << v[i] << " ";
	}
	delete[] v;                                        // free the space
}

void BST::remove(int x) {
	Node* node = root, *parent=root;
	bool found = false;
	while (!found && node != NULL) {                      // search the node and keep track of the parent;
		if (node->value == x) {
			found = true;
		}else if (x < node->value) {
			parent = node;
			node = node->left;
		}
		else {
			parent = node;
			node = node->right;
		}
	}
	if (!found) {                                        // if the value is not found then STOP
		return;
	}
	if (node->right == NULL && node->left == NULL) {     // if the node has now children
		if (parent->right == node) {                     // set the link to the parent on NULL
			parent->right = NULL;
		}
		else {
			parent->left = NULL;
		}
		delete node;                                      // delete the node
	}
	else if (node->left != NULL && node->right == NULL) { // if the node has a left child
		if (parent->right == node) {                      // pass the left child to the parent
			parent->right = node->left;
		}
		else {
			parent->left = node->left;
		}
		delete node;                                       // delete the node
	}
	else if (node->left == NULL && node->right != NULL) {  // if the node has a right child to the same as for left child
		if (parent->right == node) {
			parent->right = node->right;
		}
		else {
			parent->left = node->right;
		}
		delete node;
	}
	else {                                                 // if the node has two children
		Node* succesor = node->right;                      // get the inorder successor
		parent = node;                                     // i.e. the minimum value from the right subtree
		while (succesor->left != NULL) {
			parent = succesor;
			succesor = succesor->left;
		}
		node->value = succesor->value;                     // swap the values between node and its successor
		delete succesor;
		if (parent == node) {                              // delete the successor node from tree
			parent->right = NULL;
		}
		else {
			parent->left = NULL;
		}
	}
	count--;                                               // decrese the node count
}

BST::~BST() {
	Node** stack = new Node*[count];
	unsigned stack_size = 0;
	stack[stack_size++] = root;
	while (stack_size > 0) {
		Node *p = stack[--stack_size];
		if (p->left != NULL) {
			stack[stack_size++] = p->left;
		}
		if (p->right != NULL) {
			stack[stack_size++] = p->right;
		}
		delete p;
	}
	root = NULL;
	count = 0;
}