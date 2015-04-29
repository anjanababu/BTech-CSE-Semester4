#include<iostream>
#include<stdlib.h>
#include<malloc.h>
#include<fstream>
using namespace std;
struct Node{
	int k;
	Node* next;
};
int m;

int insert(Node** h,int key);
bool search(Node** h,int key);
int hashfunction(int key);

int main()
{
	int ch,key,index;

	cout<<"Enter the file name : ";
	char fname[66];
	cin>>fname;

	ifstream myfile(fname);

	if(myfile.good()){
	myfile>>m;
	if(!myfile.good()){
		cout<<"Program terminated as EOF is reached...\n";
		myfile.close();
		exit(0);
	}
	else if(m<=0){
		cout<<"ERROR:Enter a valid hash table size(m>0)";
		exit(1); 
	}

	Node** h =(Node** )malloc(m * sizeof(struct Node*));
	for(int i=0;i<m;i++)
		h[i]=NULL;	
	myfile>>ch;
	while(myfile.good())
	{
		switch(ch){
		case 0: cout<<"Program terminated manually...\n";
			myfile.close();
		        exit(0);
			break;
		case 1:	myfile>>key;
			index=insert(h,key);
			cout<<index<<endl;		
			break;
		case 2: myfile>>key;
			if(search(h,key))
				cout<<"FOUND\n";
			else
				cout<<"NOT FOUND"<<"\n";
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
int insert(Node** h,int key){
	int hash_val;
	hash_val = hashfunction(key);

	Node* ptr=new Node;
	ptr->k=key;
	ptr->next=h[hash_val];
	h[hash_val]=ptr;

	return hash_val;	
}
bool search(Node** h,int key){
	int hash_val;
	hash_val = hashfunction(key);

	Node* temp;
	temp=h[hash_val];
	cout<<hash_val<<" ";

	while(temp!=NULL){
		if(temp->k==key)
			return true;
		else
			temp=temp->next;
	}
	return false;
}
int hashfunction(int key){
	return (key % m);
}
