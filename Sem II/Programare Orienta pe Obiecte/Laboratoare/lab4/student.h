#pragma once
#include <iostream>
#include <vector>
#include <string>
class student
{
	std::string nume,prenume,id_student;
	float medie_bac;
	std::vector<std::string> specializari;
	static int nr_student;
public:
	student(std::string,std::string,float,std::vector<std::string>);
	void afisare();
	bool esteInscris(std::string);

};

