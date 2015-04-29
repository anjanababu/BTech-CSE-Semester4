#include<iostream>
#include<fstream>
#include<stdlib.h>
using namespace std;
struct Node{
	int key;
	Node* next;
	Node* prev;
};
void create_dll(ifstream& myfile,Node* &head,Node* &tail);
void display_dll(Node* &head);
void delete_alternate(Node* &head);
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
			create_dll(myfile,head,tail);
			dup_lim--;	
		}
		cout<<"BEFORE deletion\n";
		display_dll(head);
		delete_alternate(head);
		cout<<"\nAFTER deletion\n";
		display_dll(head);
		cout<<"\n";
		myfile.close();		
	}
	else
		cout<<"ERROR:Sorry!!The file cannot be opened\n";
}
void create_dll(ifstream& myfile,Node* &head,Node* &tail){/*insertion at the end*/
	Node* ptr=new Node;
	if(ptr==NULL){
		cout<<"ERROR:No space available!!!Aborting....\n";
		exit(1);
	}
	if(head==NULL){
		myfile>>ptr->key;
		ptr->next=NULL;
		ptr->prev=NULL;
		head=ptr;
		tail=ptr;
	}
	else{
		myfile>>ptr->key;
		ptr->prev=tail;
		ptr->next=NULL;
		tail->next=ptr;
		tail=ptr;
	}
}
void delete_alternate(Node* &head){
	Node* ptr=head;
	while(ptr!=NULL && ptr->next!=NULL){
		Node* temp=ptr->next;
		ptr->next=temp->next;
		if(temp->next!=NULL)
			temp->next->prev=ptr;
		delete temp;
		ptr=ptr->next;
	}
}
		
void display_dll(Node* &head){
	Node* temp=head;
	while(temp!=NULL){
		cout<<temp->key<<" ";
		temp=temp->next;
	}
}			
