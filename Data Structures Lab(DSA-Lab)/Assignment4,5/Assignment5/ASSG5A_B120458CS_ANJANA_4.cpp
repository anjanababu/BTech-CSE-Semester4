//Minimum spanning tree by Kruskal's Algorithm
#include<iostream>
#include<fstream>
#include<stdlib.h>
using namespace std;
struct Edge{
	int u;
	int v;
	int weight;
};
struct Node{
	int key;
	int rank;
	Node* parent;
	Node* next;
	Node* tail;//tail of the set
};
int **adjMatrix;
int i,j;
int WghtTree = 0; /* Weight of the spanning tree */
int num_v,num_e;

Node* head=NULL;
void makeSet(int x);
Node* findSet(int x);
Node* find(Node* &temp);
void unionSet(int x,int y);

void KRUSKAL_ALGORITHM(Edge* tree);
void createGraph(ifstream &myfile,Edge* tree,int num_v,int num_e);
void createTree(Edge *tree);
void insertionSort(Edge* tree);

int main(){	
	cout<<"Enter the filename\n";
	char fname[66];
	cin>>fname;
        
	ifstream myfile(fname);
	if(myfile.good()){
		myfile>>num_v;
		myfile>>num_e;
	
		/* Will contain the edges of minimum spanning tree */
		Edge* tree = (Edge* )malloc(num_e * sizeof(Edge));

		adjMatrix = new int*[num_v];
		for(i = 0; i < num_v; i++)
	    		adjMatrix[i] = new int[num_v];
	    
	    	for(i=0;i<num_v;i++)
			for(j=0;j<num_v;j++)
				adjMatrix[i][j]=0;
		
		createGraph(myfile,tree,num_v,num_e);

		KRUSKAL_ALGORITHM(tree);

		myfile.close();
	}
	else
		cout<<"ERROR:File cannot be opened......\n";
}
void KRUSKAL_ALGORITHM(Edge* tree){
	insertionSort(tree);
	
	for(i=0;i<num_v;i++)
		makeSet(i);

	for(i=0;i<num_e;i++)
		if(findSet(tree[i].u)!=findSet(tree[i].v)){
			adjMatrix[tree[i].u][tree[i].v] = tree[i].weight;
			adjMatrix[tree[i].v][tree[i].u] = tree[i].weight;
			WghtTree += tree[i].weight;
			unionSet(tree[i].u,tree[i].v);
		}
	cout<<"Weight of Tree = "<<WghtTree<<endl;

	cout<<"ADJACENCY MATRIX of MINIMUM SPANNING TREE\n";
	for(i=0;i<num_v;i++){ 
		for(j=0;j<num_v;j++) 
			cout<<adjMatrix[i][j]<<" ";
		cout<<endl;
	}
}
void createGraph(ifstream &myfile,Edge* tree,int num_v,int num_e){
	int i,start,end,wt;

	for(i=0;i<num_e;++i){
		 myfile>>tree[i].u;
		 myfile>>tree[i].v;
		 myfile>>tree[i].weight;	
	}
}
void insertionSort(Edge* tree){
	int key;
	for(i=1;i<num_e;i++){
		Edge temp = tree[i];
		key=tree[i].weight;
		j=i-1;
		while(j>=0 && tree[j].weight>key){
			tree[j+1]=tree[j];
			--j;
		}
		tree[j+1]=temp;	
	}
}	
void makeSet(int x)
{
	Node* ptr = new Node;
	ptr->key = x;
	ptr->parent = ptr;
	ptr->tail=ptr;
	ptr->next=head;	
	ptr->rank=0;
	head=ptr;
}
Node* findSet(int x){
	Node* temp=head;
	
	while(temp!=NULL and temp->key!=x)//to get the pointer
		temp=temp->next;
	
	if(temp==NULL){
		cout<<"ELEMENT NOT FOUND\n";
		return temp;
	}
	else
		return find(temp);
}
Node* find(Node* &temp){
	if(temp==temp->parent)
		return temp;
	else
		temp->parent=find(temp->parent);
}	
		
void unionSet(int x,int y){
	Node* a = findSet(x); 
	Node* b = findSet(y);
	if(a!=b){
		//link(a,b)
		if(a->rank < b->rank)
			a->parent = b;
		else{
			b->parent = a;
			if(a->rank == b->rank)
				++a->rank;
		}
	}		
}
