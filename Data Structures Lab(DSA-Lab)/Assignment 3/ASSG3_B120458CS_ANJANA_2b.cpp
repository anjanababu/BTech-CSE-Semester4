#include<iostream>
#include<stdlib.h>
#include<fstream>
using namespace std;
struct Node{
	int key;
	Node* next;
};
struct Queue{
	Node* front;
	Node* rear;
};
void enqueue(Queue* q,int element);
int dequeue(Queue* q);
int peek(Queue* q);
void show(Queue* q);
int main()
{
	int ch,element,status;
	
	Queue* q=new Queue;	
	/* Inital queue is empty. */
	q->front = NULL;
	q->rear = NULL;
	
	cout<<"Enter the file name : ";
	char fname[66];
	cin>>fname;
	ifstream myfile(fname);
	
	if(myfile.good()){
	myfile>>ch;
	while(myfile.good())
	{
		switch(ch){
		case 0: cout<<"Program terminated manually...\n";
			myfile.close();
		        exit(0);
			break;
		case 1:	myfile>>element;
			if(element>=0)
				enqueue(q,element);
			else
				cout<<"Invalid Input..";
			cout<<endl;
			break;
		case 2: status=dequeue(q);
			if(status==-1)
				cout<<"EMPTY\n";
			else
				cout<<status<<"\n";
			break;
		case 3:status=peek(q);
			if(status==-1)
				cout<<"EMPTY\n";
			else
				cout<<status<<"\n";			
			break;
		case 4: show(q);
			break;
		default: cout<<"Invalid Choice....\n";
		}
		myfile>>ch;
	}
	cout<<"Program terminated as EOF is reached...\n";
	myfile.close();
	exit(1);
	}
	else
		cout<<"ERROR: Sorry!! The file cannot be opened...\n";
		
	/* Clean up. */
	delete q;
	return 0;
}
void enqueue(Queue* q,int element){
	Node* ptr=new Node;
	if(ptr==NULL){
		cout<<"No Space Available...Aborting!!\n";
		exit(1);
	}
	ptr->next=NULL;
	ptr->key=element;
	if(q->front==NULL){/*Queue is EMPTY*/
		q->front=q->rear=ptr;
		return;
	}
	q->rear->next=ptr;
	q->rear=ptr;
}
int dequeue(Queue* q){
	if(q->front==NULL)
		return -1;
	else{
		Node* temp;
		int val=q->front->key;
		temp=q->front;
		q->front=q->front->next;
		temp->next=NULL;
		return val;
	}
}
int peek(Queue* q){
	if(q->front==NULL)
		return -1;
	else
		return q->front->key;
}
void show(Queue* q){
	if(q->front==NULL)
		cout<<"EMPTY\n";
	else{
		Node* temp=q->front;
		while(temp!=NULL){
			cout<<temp->key<<" ";
			temp=temp->next;
		}
		cout<<"\n";
	}
}
