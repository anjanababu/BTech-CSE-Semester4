#include<iostream>
#include<fstream>
#include<stdlib.h>
#include<string.h>
using namespace std;
struct Node{
	int key;
	Node *next;
};

Node* head;
Node* tail;

Node* head1;
Node* head2;

Node* tail1;
Node* tail2;

int limit=0;
int limit1,limit2;

Node* create_sll(char fname[66]);

int main()
{	
	char fname1[66];
	cout<<"Enter first file name : ";
	cin>>fname1;
	
	cout<<"Returned "<<create_sll(fname1)<<endl;
	
	return 0;
}
Node* create_sll(char fname[66]){/*insertion at the end*/
	ifstream infile(fname , ios::in | ios::binary);
	int number;
	limit=0;
	head=NULL;
	tail=NULL;
	if(infile.good()){
	infile.read( reinterpret_cast<char*>(&number) , sizeof(int));
	while(!infile.eof()){
		++limit;
		Node* ptr=new Node;
		if(ptr==NULL){
			cout<<"ERROR:No space available!!!Aborting....\n";
			exit(1);
		}

		if(head==NULL){
			ptr->key=number;
			ptr->next=NULL;
			head=ptr;
			tail=ptr;			
		}	
		else{
			ptr->key=number;
			ptr->next=NULL;
			tail->next=ptr;
			tail=ptr;
		}
		infile.read( reinterpret_cast<char*>(&number) , sizeof(int));
	}
	if(tail!=NULL)
		tail->next=head;
	infile.close();
	return head;
	}
	else{
		cout<<"ERROR:Sorry!!Couldn't open the file for reading\n";	
		exit(1);
	}
}
	
	
	
	
	
	
	
	
	
	
