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
Node* alternate_merge(Node* head1,Node* head2);
void copy_circular_sll_to_file(char fname[66],Node* head);
void copy_file_to_file(char src_fname[66],char dest_fname[66]);
void program(char fname1[66],char fname2[66],char fname3[66]);

int main()
{	
	char fname1[66];
	cout<<"Enter first file name : ";
	cin>>fname1;
	
	char fname2[66];
	cout<<"Enter second file name : ";
	cin>>fname2;
	
	char fname3[66];
	cout<<"Enter output file name : ";
	cin>>fname3;
	
	program(fname1,fname2,fname3);
	
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
Node* alternate_merge(Node* head1,Node* head2){
	if(head1==NULL)
		return head2;
	if(head2==NULL)
		return head1;

	int dup1=limit1;
	int dup2=limit2;
	Node* ptr1=head1;
	Node* ptr2=head2;
	Node* temp1;
	Node* temp2;

	if(limit1>=limit2){
		while(dup2>0){
			--dup2;
			temp1=ptr1->next;
			temp2=ptr2->next;
			ptr1->next=ptr2;
			if(dup2!=0){
				ptr2->next=temp1;
				tail2->next=temp2;
			}
			else
				tail2->next=temp1;			
			ptr2=temp2;
			ptr1=temp1;
		}	
	}				
	else
		while(dup1>0){
			--dup1;
			temp1=ptr1->next;
			temp2=ptr2->next;
			ptr1->next=ptr2;
			if(dup1!=0){
				ptr2->next=temp1;
				tail2->next=temp2;
			}
			else
				tail2->next=head1;
			ptr2=temp2;
			ptr1=temp1;
		}
	return head1;
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
void program(char fname1[66],char fname2[66],char fname3[66]){
	char tempfile[66];	
	strcpy(tempfile,fname3);
	strcat(tempfile,".temp");
	
	head1=create_sll(fname1);
	tail1=tail;	
	limit1=limit;

	head2=create_sll(fname2);
	tail2=tail;
	limit2=limit;

	Node* final_head=alternate_merge(head1,head2);

	copy_circular_sll_to_file(tempfile,final_head);
	
	copy_file_to_file(tempfile,fname3);
}
	

 	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
