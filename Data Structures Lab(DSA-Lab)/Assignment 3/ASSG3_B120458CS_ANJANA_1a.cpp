#include<iostream>
#include<stdlib.h>
#include<fstream>
using namespace std;
int size;
int top=-1;

void push(int *stk,int element);
int pop(int *stk);
int peek(int *stk);
void show(int *stk);
int main()
{
	int ch,element,status;
	int *stk;

	cout<<"Enter the file name : ";
	char fname[66];
	cin>>fname;
	ifstream myfile(fname);

	if(myfile.good()){
	myfile>>size;
	if(myfile.good())
		if(size>0 && size<100)
			stk=new int[size];
		else{
			cout<<"ERROR: Invalid Stack Size\n";
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
		case 3:	status=peek(stk);
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
	return 0;
}
void push(int *stk,int element){
	if(top==size-1)/*Stack is full*/
		cout<<"OVERFLOW";	
	else
		stk[++top]=element;
}
int pop(int *stk){
	if(top==-1)/*Stack is empty*/
		return -1;
	else
		return stk[top--];
}
int peek(int *stk){
	if(top==-1)
		return -1;
	else
		return stk[top];
}
void show(int *stk){
	if(top==-1)
		cout<<"EMPTY\n";
	else{
		int temp=top;
		while(temp>=0)
			cout<<stk[temp--]<<" ";
		cout<<"\n";
	}
}
