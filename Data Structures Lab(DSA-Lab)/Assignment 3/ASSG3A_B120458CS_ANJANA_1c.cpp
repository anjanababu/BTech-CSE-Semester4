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
void copy_circular_sll_to_file(char fname[66],Node* head);

int main()
{	
	char fname1[66];
	cout<<"Enter first file name : ";
	cin>>fname1;
	
	char fname2[66];
	cout<<"Enter output file name : ";
	cin>>fname2;

	copy_circular_sll_to_file(fname2,create_sll(fname1));
	
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
void copy_circular_sll_to_file(char fname[66],Node* head){
	ofstream outfile(fname , ios::out | ios::binary);
	if(outfile.good()){
		Node* ptr=head;
		if(ptr!=NULL){/*merged list is not empty*/
			outfile.write( reinterpret_cast<const char*>(&ptr->key) , sizeof(int));
			ptr=ptr->next;
			while(ptr!=head){
				outfile.write( reinterpret_cast<const char*>(&ptr->key) , sizeof(int));
				ptr=ptr->next;
			}
		}
		outfile.close();
	}
	else{
		cout<<"ERROR:Sorry!!Couldn't open the file for writing\n";	
		exit(1);
	}
}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
