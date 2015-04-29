#include<iostream>
#include<fstream>
#include<stdlib.h>
using namespace std;
struct Node{
	int key;
	int rank;
	Node* parent;
	Node* next;
	Node* next_set_ele;//next_set_ele of the set
};

Node* head=NULL;
void makeSet(int x);
Node* findSet(int x);
void unionSet(int x,int y);

int main()
{
	cout<<"Enter the file name : ";
	char fname[66];
	cin>>fname;
	
	int ch,x,y;
	Node* rep;	
	
	ifstream myfile(fname);
	if(myfile.good()){
		myfile>>ch;
		while(myfile.good()){
			switch(ch){
			case 0: cout<<"Program terminated manually...\n";
				myfile.close();
				exit(0);
				break;
			case 1: myfile>>x;
				makeSet(x);
				cout<<endl;
				break;
			case 2: myfile>>x;
				rep = findSet(x);
				cout<<rep->key<<endl;				
				break;
			case 3:	myfile>>x>>y;
				unionSet(x,y);
				cout<<endl;
				break;
			default:cout<<"Invalid Choice....\n";
		}
		myfile>>ch;
		}
	}
	else
		cout<<"ERROR:File cannot be opened.....\n";
}
			
void makeSet(int x)
{
	Node* ptr = new Node;
	ptr->key = x;
	ptr->parent = ptr;
	ptr->next_set_ele=ptr;
	ptr->next=head;	
	ptr->rank=0;
	head=ptr;
}
Node* findSet(int x){
	Node* temp=head;
	
	while(temp!=NULL and temp->key!=x)//to get the pointer
		temp=temp->next;

	if(temp==NULL)
		cout<<"ELEMENT NOT FOUND\n";
	else
		while(temp->parent!=temp)
			temp=temp->parent;
	return temp;
}

void unionSet(int x,int y){
	Node* a = findSet(x); 
	Node* b = findSet(y);
	if(a!=b){
		//link(a,b)
		if(a->rank < b->rank)
			a->parent = b;
		else{
			b->parent = a;
			if(a->rank == b->rank)
				++a->rank;
		}
	}		
}
