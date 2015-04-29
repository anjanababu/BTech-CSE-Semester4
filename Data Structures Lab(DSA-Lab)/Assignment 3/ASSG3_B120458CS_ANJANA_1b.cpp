#include<iostream>
#include<stdlib.h>
#include<fstream>
using namespace std;
struct Node{
	int key;
	Node* next;
};
struct Stack{
	Node* top;
};
void push(Stack* stk,int element);
int pop(Stack* stk);
int peek(Stack* stk);
void show(Stack* stk);
int main()
{
	int ch,element,status;

	Stack* stk=new Stack;
	/*Initially stack is empty*/
	stk->top=NULL;

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
				push(stk,element);
			else
				cout<<"Invalid Input..";
			cout<<endl;
			break;
		case 2: status=pop(stk);
			if(status==-1)
				cout<<"EMPTY\n";
			else
				cout<<status<<"\n";
			break;
		case 3: status=peek(stk);
			if(status==-1)
				cout<<"EMPTY\n";
			else
				cout<<status<<"\n";
			break;
		case 4: show(stk);
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
	delete stk;
	return 0;
}
void push(Stack* stk,int element){
	Node* ptr=new Node;
	if(ptr==NULL){
		cout<<"No Space Available...Aborting!!";
		exit(1);
	}
	if(stk->top==NULL){
		ptr->next=NULL;
		ptr->key=element;
		stk->top=ptr;
	}
	else{
		ptr->next=stk->top;
		ptr->key=element;
		stk->top=ptr;
	}
}
int pop(Stack* stk){
	if(stk->top==NULL)/*Stack is empty*/
		return -1;
	else{
		Node* temp;
		int val=stk->top->key;
		temp=stk->top;
		stk->top=stk->top->next;
		temp->next=NULL;
		return val;
	}
}
int peek(Stack* stk){
	if(stk->top==NULL)
		return -1;
	else
		return stk->top->key;
}
void show(Stack* stk){
	if(stk->top==NULL)
		cout<<"EMPTY\n";
	else{
		Node* temp=stk->top;
		while(temp!=NULL){
			cout<<temp->key<<" ";
			temp=temp->next;
		}
		cout<<"\n";
	}
}
