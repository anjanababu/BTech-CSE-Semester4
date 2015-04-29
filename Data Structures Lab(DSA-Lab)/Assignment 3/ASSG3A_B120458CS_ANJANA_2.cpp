#include<iostream>
#include<malloc.h>
#include<stdlib.h>
#include<fstream>
using namespace std;
struct Node{
	int val;
	int priority;
	Node* next;
	Node* prev;
};

struct PriorityQueue{
	Node* head;
	Node* tail;
};

void insert(PriorityQueue* pq,Node* element);
void increase_key(PriorityQueue* pq,Node* element,int newpr);
Node* remove(PriorityQueue* pq);
Node* peek(PriorityQueue* pq);

void redirect(PriorityQueue* pq,Node* a,Node* b);
Node* getnode(PriorityQueue* pq,int data);
void move_element_to_tail(PriorityQueue* pq,Node* x);

int main(){
	
	int ch,newpr,data,i;
	
	PriorityQueue* pq=new PriorityQueue;	
	/* Inital priority queue is empty. */
	pq->head = NULL;
	pq->tail = NULL;
	
	Node* element = new Node;
	Node* f;
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
		case 1:	myfile>>element->val;
			myfile>>element->priority;
			if(element->priority>=1 && element->val>=0){
				insert(pq,element);cout<<"\n";
			}
			else if(element->priority<1)
				cout<<"INVALID PRIORITY\n";	
			else if(element->val<0)
				cout<<"INVALID VALUE\n";
			break;
		case 2: f = remove(pq);
			if(f == NULL){
				cout<<"EMPTY\n";
			}
			else
				cout<<f->val<<" ("<<f->priority<<")"<<endl;
			break;
		case 3: f = peek(pq);
			if(f == NULL){
				cout<<"EMPTY\n";
			}
			else
				cout<<f->val<<" ("<<f->priority<<")"<<endl;
			break;
		case 4: myfile>>data;
			element = getnode(pq,data);
			myfile>>newpr;	
			if(data<0)
				cout<<"INVALID VALUE\n";
			else if(newpr<1)
				cout<<"INVALID PRIORITY\n";
			else if(element->priority>newpr){
				increase_key(pq,element,newpr);cout<<"\n";
			}
			else
				cout<<"BROKE THE GUARENTEE-newpr is lesser than oldpr\n";
			break;
		default:cout<<"Invalid Choice....\n";
		}
		myfile>>ch;
	}

	cout<<"Program terminated as EOF is reached...\n";
	myfile.close();
	exit(1);
	}
	else
		cout<<"ERROR: Sorry!! The file cannot be opened...\n";
	return 0;
}
void insert(PriorityQueue* pq,Node* element){
	Node* e = new Node;
	e->val = element->val;
	e->priority = element->priority;

	if(pq->head==NULL){/*empty PriorityQueue*/		
		pq->head=e;
		pq->tail=e;
		e->next=NULL;
		e->prev=NULL;
		
	}
	else{
		pq->tail->next=e;
		e->prev=pq->tail;
		e->next=NULL;
		pq->tail=e;
		increase_key(pq,e,e->priority);
	}
}
//pq element newpr
void increase_key(PriorityQueue* pq,Node* element,int newpr){
	if(newpr>element->priority)
		cout<<"WRONG PRIORITY";
	else{	
		Node* x = getnode(pq,element->val);
		if(x==NULL)
			cout<<"NO SUCH ELEMENT EXITS TO INCREASE KEY\n";
		else{
			element->priority = newpr;
			if(x!=pq->tail)
				move_element_to_tail(pq,x);
			x=x->prev;
			Node* t=x;/*prev element*/
			while(x!=NULL && newpr < x->priority){
				t = x;				
				x = x->prev;
			}
			if(t->next == element && t->priority < newpr){/*inserted at correct position*/
				return;
			}
			else{/*requires a redirection*/
				pq->tail = element->prev;					
				redirect(pq,t,element);
			}
	       	}	
	}
}
Node* remove(PriorityQueue* pq){
	if(pq->head!= NULL){
		Node* temp = pq->head;
		pq->head = pq->head->next;
		if(pq->head!=NULL)
			pq->head->prev = NULL;
		temp->next=NULL;
		return temp;
	}
	else
		return NULL;
}
Node* peek(PriorityQueue* pq){
	return pq->head;	
}
Node* getnode(PriorityQueue* pq,int data){
	Node* temp;
	temp = pq->tail;	
	while(temp!=NULL && temp->val!=data)
		temp=temp->prev;
	if(temp->val == data)
		return temp;
	else
		return NULL;
}
void redirect(PriorityQueue* pq,Node* x,Node* element){
	if(x->next == element && x->prev==NULL){/*2 elements only swap*/
		x->next = NULL;
		x->prev = element;
		element->next = x;
		element->prev = NULL;
		pq->head = element;
	}
	else if(x->prev==NULL){/*inserted element has correct position at head*/
		pq->head->prev=element;		
		element->prev = NULL;
		element->next = pq->head;
		pq->head = element;
	}
	else{
		element->prev = x->prev;
		x->prev->next=element;
		x->prev=element;	
		element->next = x;
	}
	pq->tail->next=NULL;
}
void move_element_to_tail(PriorityQueue* pq,Node* x){
	if(x!=pq->tail && x!=pq->head){/* make at tail*/
		x->prev->next=x->next;
		x->next->prev=x->prev;
		x->next=NULL;
		x->prev=pq->tail;
		pq->tail->next=x;
		pq->tail=x;
	}
	else if(x==pq->head && x!=pq->tail){
		x->next->prev=NULL;
		pq->head=x->next;
		x->next=NULL;
		x->prev=pq->tail;
	}
}
				
					


	
	
	
