#include <iostream>

using namespace std;

struct list{
  int info;
  list *next;
}*prim,*ultim;

void add_front(int x){
  /*

    x- numar intreg care trebuie adaugat la inceputul listei
  
  */
  list *new_list = new list;
  new_list->info=x;
  new_list->next=prim;
  prim=new_list;
  if(new_list->next==NULL)
    ultim=new_list;
}

void add_back(int x){
  /*
    x- numar intreg care trebuie adaugat la finalul listei
  
  */
  list *new_list = new list;
  new_list->info=x;
  new_list->next=NULL;
  if(ultim==NULL){
    prim=new_list;
    ultim=new_list;
  }else{
    ultim->next=new_list;
    ultim=new_list;
  }
}

void afisareLista(){
  /*
    Afisam lista folosind pointerul prim
  */
  list *p=prim;
  while(p){
    cout<<p->info<<" ";
    p=p->next;
  }
}

int cautareLista(int x){
  /*
    x - elementul care trebuie cautat in lista

    @return indexul pe care se afla sau -1 daca nu este in lista

  */
  int i=1;
  list *p = prim;
  while(p){
    if(p->info == x)
      return i;
    p=p->next;
    i++;
  }
  return -1;
}

int cautareListaPozitie(int x){
  /*
    x- pozitia de pe care trebuie sa luam valoarea

    @ return int valuarea de pe pozitia x sau -1 daca x mai mare decat lungimea listei
  */
  list *p=prim;
  int index=1;
  while(p){
    if(index==x)
      return p->info;
    p=p->next;
  }
  return -1;

}

void insert_after_value(int x,int val){
  /*
    x - elementul pe care trebuie sa-l inseram
    val - valoare dupa care trebuie sa inseram elementul x
  */
  list *new_list=new list();
  new_list->info=x;
  list *p = prim;
  while(p){
    if(p->info == val){
      if(p->next==NULL)
        ultim=new_list;
      new_list->next=p->next;
      p->next=new_list;
      return;
    }
    p=p->next;
  }
}

void inser_after_index(int i,int val){
  /*
    i - pozitia de dupa care adaugam
    val- valoarea pe care o adaugam
  */
  list* p = prim;
  list new_nod;
  new_nod.info=val;
  if(i==-1){
    new_nod.next=p;
    prim=&new_nod;
    return;
  }
  while(i--){
    p=p->next;
    if(!p) break;
  }
  list aux = p->next;
  n->next=new_nod;
  new_nod->next=aux;

}

void delete_value(int val){
  /*
    val- valoarea care trebuie stearsa
  */
  list p=start;
  if(p->info==val){
    start=start->next;
    return;
  }
  if(end->info==val){
    //todo parcurgere si stergere penultim elem
  }
  while(p){
    if(p->next->info==val){
      p->next=p->next->next;
    }
  }
}
void delete_index(int i){
  /*
    i- pozitia din lista pe care vreau sa o sterg
  */
  if(i==0){
    start=start->next;
    return;
  }
  list p = start;
  while(i-->0){
    p=p->next;
  }
  p->next=p->next->next;

}

int main() {
  add_front(12);
  afisareLista();
}