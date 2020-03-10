#pragma once
#include "student.h"
#include <vector>
using namespace std;

class App
{
	vector<student> s;
public:
	void add(student);
	void show(string);
	void remove(string);// to do, find a student by id


};

