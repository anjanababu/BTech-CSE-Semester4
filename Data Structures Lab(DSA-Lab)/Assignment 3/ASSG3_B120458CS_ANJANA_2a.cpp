#include<iostream>
#include<stdlib.h>
#include<fstream>
using namespace std;
int size;
int front=-1;/*points to the element to be deleted*/
int rear=-1;/*points to the last element*/

void enqueue(int *q,int element);
int dequeue(int *q);
int peek(int *q);
void show(int *q);
bool queue_empty(int *q);
bool queue_full(int *q);

int main()
{
	int ch,element,status;
	int *q;

	cout<<"Enter the file name : ";
	char fname[66];
	cin>>fname;
	ifstream myfile(fname);

	if(myfile.good()){
	myfile>>size;
	if(myfile.good())
		if(size>0 && size<100)
			q=new int[size];
		else{
			cout<<"ERROR: Invalid Queue Size\n";
			exit(1);
		}
	else{
		cout<<"Program terminated as EOF is reached...\n";
		myfile.close();
		exit(1);
	}
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
		case 3: status=peek(q);
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
	return 0;
}
void enqueue(int *q,int element){
	if(queue_full(q))/*Queue is full*/
		cout<<"OVERFLOW";
	else{
		if(rear==-1)/*initially*/
			front=0;
		else if(rear==size-1)
			rear=-1;
		q[++rear]=element;
	}
}
int dequeue(int *q){
	if(queue_empty(q))/*Queue is empty*/
		return -1;
	else{
		int temp=q[front];
		if(front==rear)/*only one element in the queue*/
			front=rear=-1;
		else if(front==size-1)
			front=0;
		else
			front++;
		return temp;
	}
}
int peek(int *q){
	if(queue_empty(q))
		return -1;
	else
		return q[front];
}
void show(int *q){
	if(queue_empty(q))
		cout<<"EMPTY\n";
	else{
		if(front<=rear)
			for(int i=front;i<=rear;i++)
				cout<<q[i]<<" ";
		else{
			for(int i=front;i<=size-1;i++)
				cout<<q[i]<<" ";
			for(int i=0;i<=rear;i++)
				cout<<q[i]<<" ";
		}
		cout<<"\n";
	}
}
bool queue_empty(int *q){
	if(front==-1)
		return true;
	else 
		return false;
}
	
bool queue_full(int *q){
	if(front==0 && rear==size-1)
		return true;
	else if(front==rear+1)
		return true;
	else
		return false;
}	
