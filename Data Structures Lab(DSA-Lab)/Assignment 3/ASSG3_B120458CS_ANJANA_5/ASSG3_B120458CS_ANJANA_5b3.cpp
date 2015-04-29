#include<iostream>
#include<stdlib.h>
#include<malloc.h>
#include<fstream>
#include<math.h>
using namespace std;

int m;
int hash_val;
double knuth = (sqrt(5) - 1)/2;

int insert(int *h,int key);
bool search(int *h,int key);
int hashfunction(int key,int probe);
int sub_hashf1(int key);
int sub_hashf2(int key);

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

	int *h=new int[m];
	for(int i=0;i<m;i++)
		h[i]=100000000;	
	myfile>>ch;
	while(myfile.good())
	{
		switch(ch){
		case 0: cout<<"Program terminated manually...\n";
			myfile.close();
		        exit(0);
			break;
		case 1: myfile>>key;
			insert(h,key);		
			break;
		case 2: myfile>>key;
			if(search(h,key))
				cout<<"FOUND\n";
			else
				cout<<"NOT FOUND\n";
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
int insert(int *h,int key){
	int probe=0;
	hash_val = hashfunction(key,probe);
	
	while((h[hash_val]!=100000000) && (probe<m)){
		cout<<hash_val<<" ";
		probe++;
		hash_val = hashfunction(key,probe);
	}

	cout<<hash_val<<" ";

	if(probe>=m)
		cout<<"HASH TABLE IS FULL\n";
	else{
		h[hash_val]=key;
		cout<<endl;
	}
}
bool search(int *h,int key){

	int probe=0;
	hash_val = hashfunction(key,probe);

	while((h[hash_val]!=key) && (probe<m) && (h[hash_val]!=100000000)){
		cout<<hash_val<<" ";
		probe++;
		hash_val = hashfunction(key,probe);
	}
	
	cout<<hash_val<<" ";

	if(h[hash_val]==key)
		return true;
	else
		return false;
}

int hashfunction(int key,int probe){
	//h(k)=(h'(k) + probe*h"(k)) mod m
	//h'(k) = k mod m
	//h"(k) = 1 + (kA mod 1)*m-1
	//h'(k) and m' should be relatively prime so that entire hashtable is searched
	return ( (int)( sub_hashf1(key) + probe * sub_hashf2(key))  %  m);
}
int sub_hashf1(int key){
	return (key % m);
}

int sub_hashf2(int key){
	return (1 + floor((  (key * knuth) - floor(key * knuth) ) * (m - 1)));
}
