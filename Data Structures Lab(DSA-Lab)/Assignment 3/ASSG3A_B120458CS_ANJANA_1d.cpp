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

void copy_file_to_file(char src_fname[66],char dest_fname[66]);


int main()
{	
	char fname1[66];
	cout<<"Enter first file name : ";
	cin>>fname1;
	
	char fname2[66];
	cout<<"Enter second file name : ";
	cin>>fname2;
	
	copy_file_to_file(fname1,fname2);
	
	return 0;
}
void copy_file_to_file(char src_fname[66],char dest_fname[66]){
	ifstream inf(src_fname , ios::in | ios::binary);
	ofstream outf(dest_fname , ios::out);
	int temp_store;
	
	if (!inf.good () || !outf.good()){
		cout<<"ERROR: Sorry the files to be copied couldn't be opened\n";
		exit(1);
	}
	while (true)
	{
		inf.read( reinterpret_cast<char*>(&temp_store) , sizeof(int));
		
		if (!inf.good())
			break;
		
		outf<<temp_store<<endl;
	}
	
	inf.close ();
	outf.close ();
}	
	
	
	
	
	
	
	
