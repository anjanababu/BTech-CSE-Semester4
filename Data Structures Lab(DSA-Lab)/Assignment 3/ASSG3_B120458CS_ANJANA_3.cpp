#include<iostream>
#include<malloc.h>
#include<stdlib.h>
#include<fstream>
using namespace std;
struct priorityqueue{
	int val;
	int priority;
}empty;

int heapsize = 0;

int left(int index);
int right(int index);
int parent(int index);

void min_heapify(priorityqueue *pq,int index);
int getindex(priorityqueue *pq,int data);
void swap(int &a,int &b);

void insert(priorityqueue *pq,priorityqueue element);
priorityqueue remove(priorityqueue *pq);
priorityqueue peek(priorityqueue *pq);
void increase_key(priorityqueue *pq,priorityqueue element,int newpr);

int main(){
	
	int ch,newpr,data,i;
	priorityqueue element;

	cout<<"Enter the file name : ";
	char fname[66];
	cin>>fname;

	ifstream myfile(fname);

	if(myfile.good()){
	/*myfile>>m;
	if(m==EOF){
		cout<<"Program terminated as EOF is reached...\n";
		myfile.close();
		exit(0);
	}
	else if(m<=0){
		cout<<"ERROR:Enter a valid hash table size(m>0)";
		exit(1); 
	}*/

	priorityqueue* pq =(priorityqueue* )malloc(100 * sizeof(struct priorityqueue));

	myfile>>ch;
	while(myfile.good())
	{
		switch(ch){
		case 0: cout<<"Program terminated manually...\n";
			myfile.close();
		        exit(0);
			break;
		case 1:	myfile>>element.val;
			myfile>>element.priority;
			if(element.priority>=1 && element.val>=0){
				insert(pq,element);cout<<"\n";
			}
			else if(element.priority<1)
				cout<<"INVALID PRIORITY\n";	
			else if(element.val<0)
				cout<<"INVALID VALUE\n";
			break;
		case 2: element = remove(pq);
			if(element.priority == -1){
				empty.priority = 0;
				cout<<"EMPTY\n";
			}
			else
				cout<<element.val<<" ("<<element.priority<<")"<<endl;
			break;
		case 3: element = peek(pq);
			if(element.priority == -1){
				empty.priority = 0;
				cout<<"EMPTY\n";
			}
			else
				cout<<element.val<<" ("<<element.priority<<")"<<endl;
			break;
		case 4: myfile>>data;
			element = pq[getindex(pq,data)];
			myfile>>newpr;	
			if(data<0)
				cout<<"INVALID VALUE\n";
			else if(newpr<1)
				cout<<"INVALID PRIORITY\n";
			else if(element.priority>newpr){
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
void insert(priorityqueue *pq,priorityqueue element){
	pq[heapsize]=element;
	pq[heapsize].priority = 100000000;
	++heapsize;
	increase_key(pq,pq[heapsize-1],element.priority);
}
//pq element newpr
void increase_key(priorityqueue *pq,priorityqueue element,int newpr){
	if(newpr>element.priority)
		cout<<"WRONG PRIORITY";
	else{
		int x = getindex(pq,element.val);
		pq[x].priority = newpr;		
		while(x>0 && pq[x].priority<pq[parent(x)].priority){
			swap(pq[x],pq[parent(x)]);
			x = parent(x);
		}
	}
}
priorityqueue remove(priorityqueue *pq){
	if(heapsize>0){
		priorityqueue max=pq[0];
		pq[0]=pq[heapsize-1];
		--heapsize;
		min_heapify(pq,0);
		return max;
	}
	else{
		empty.priority=-1;
		return empty;
	}
}
priorityqueue peek(priorityqueue *pq){
	if(heapsize>0)
		return pq[0];
	else{
		empty.priority=-1;
		return empty;
	}
}
int left(int index){
	return (2*index + 1);
}
int right(int index){
	return (2*index + 2);
}
int parent(int index){
	return ((int)((index+1)/2) - 1);
}
void min_heapify(priorityqueue *pq,int index){
	int l = left(index);
	int r = right(index);
	
	int smallest = index;

	if(l<heapsize && pq[l].priority < pq[index].priority)
		smallest = l;
	if(r<heapsize && pq[r].priority < pq[smallest].priority)
		smallest = r;
	if(smallest!=index){
		swap(pq[index],pq[smallest]);
		min_heapify(pq,smallest);
	}
}
	
void swap(priorityqueue &a,priorityqueue &b){
	priorityqueue temp;
	temp=a;
	a=b;
	b=temp;
}
int getindex(priorityqueue *pq,int data){
	int t=0;
	while(pq[t].val!=data && t<heapsize){
		++t;
	}
	if(pq[t].val == data)
		return t;
	else
		return -1;
}
	
	
	
