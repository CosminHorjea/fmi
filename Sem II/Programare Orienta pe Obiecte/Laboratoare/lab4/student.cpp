#include "student.h"
using namespace std;
student::student(string m, string p ,float m_b, vector<string> s):nume(m),prenume(p),medie_bac(m_b),specializari(s) {
	this->id_student = "FMI_" + to_string(nr_student);
}

int student::nr_student = 0;

bool student::esteInscris(string s) {
	for (string spec : specializari) {
		if (spec == s) {
			return true;
		}
	}
	return false;
}