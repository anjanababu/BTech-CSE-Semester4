#include<iostream>
#include<fstream>
#include<stdlib.h>
using namespace std;
struct Node{
	int key;
	Node *next;
};
void create_sll(ifstream& myfile,Node* &head,Node* &tail);
int count_key_greater_ten(Node* &head);
int main()
{	
	Node* head=NULL;
	Node* tail=NULL;

	char fname[66];
	cout<<"Enter the file name : ";
	cin>>fname;

	ifstream myfile(fname);
	if(myfile.good()){
		int limit;
		myfile>>limit;
		if(!myfile.good())
			exit(1);
		if(limit<=0){
			cout<<"ERROR:Size of the Singly Linked List was invalid(<=0)\n";
			exit(1);
		}
		int dup_lim=limit;
		while(dup_lim){
			create_sll(myfile,head,tail);
			dup_lim--;	
		}
		int cnt=count_key_greater_ten(head);
		cout<<"COUNT = "<<cnt<<endl<<"ie. ";
		cout<<cnt<<" numbers greater than 10 in the singly linked list\n";
		myfile.close();
	}
	else
		cout<<"ERROR:Sorry!!The file cannot be opened\n";
}
void create_sll(ifstream& myfile,Node* &head,Node* &tail){/*insertion at the end*/
	Node* ptr=new Node;
	if(ptr==NULL){
		cout<<"ERROR:No space available!!!Aborting....\n";
		exit(1);
	}
	if(head==NULL){
		head=ptr;
		tail=ptr;
		myfile>>ptr->key;
		ptr->next=NULL;
	}
	else{
		myfile>>ptr->key;
		tail->next=ptr;
		tail=ptr;
	}
}
int count_key_greater_ten(Node* &head){
	Node* ptr=head;
	int count=0;
	while(ptr!=NULL){
		if(ptr->key>10)
			++count;
		ptr=ptr->next;
	}
	return count;
}
