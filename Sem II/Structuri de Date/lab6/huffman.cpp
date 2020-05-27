#include <iostream>
#include <set>
#include <map>
#include <fstream>
#include <queue>

using namespace std;
ifstream f("text.in");
class Node
{
	char c;
	int frecventa;
	Node *left, *right;

public:
	Node(char c, int frecv, Node *left = NULL, Node *right = NULL)
	{
		this->c = c;
		this->frecventa = frecv;
		this->left = left;
		this->right = right;
	}
	bool operator<(Node other)
	{
		if (this->frecventa > other.frecventa)
		{
			return false;
		}
		return true;
	}
	char getChar() { return this->c; }
	int getFrecv() const
	{
		return this->frecventa;
	}
	Node *getLeft() { return this->left; }
	Node *getRight() { return this->right; }
};
void inOrder(Node *root, string w)
{
	if (!root)
		return;
	inOrder(root->getLeft(), w + "0");
	if (root->getChar())
		cout << root->getChar() << " : " << w << endl;
	inOrder(root->getRight(), w + "1");
}

struct CmpNodesPtS
{
	bool operator()(const Node *lhs, const Node *rhs) const
	{
		return lhs->getFrecv() >= rhs->getFrecv();
	}
};

int main()
{
	priority_queue<Node *, vector<Node *>, CmpNodesPtS> coada;
	map<char, int> dictionar;
	string x;
	while (f >> x)
	{
		for (int i = 0; i < x.size(); i++)
		{
			dictionar[x[i]]++;
		}
		dictionar[' ']++;
	}
	for (pair<char, int> i : dictionar)
	{
		cout << i.first << " " << i.second << endl;
		Node *aux = new Node(i.first, i.second);
		coada.push(aux);
	}
	while (coada.size() > 1)
	{
		Node *first = coada.top();
		coada.pop();
		Node *second = coada.top();
		coada.pop();
		Node *aux = new Node(0, first->getFrecv() + second->getFrecv(), first, second);
		coada.push(aux);
	}
	inOrder(coada.top(), "");

	return 0;
}