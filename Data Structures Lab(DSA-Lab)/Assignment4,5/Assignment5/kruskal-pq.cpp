//Minimum spanning tree by Kruskal's Algorithm
#include<iostream>
#include<fstream>
#include<stdlib.h>
using namespace std;
struct Edge{
	int u;
	int v;
	int weight;
	Edge* next;
};
int** adjMatrix;
int i,j;
Edge* front = NULL;

void createGraph(ifstream &myfile,int num_v,int num_e);
void createTree(Edge *tree);

void insertPriorityQueue(int s,int e,int wt);
Edge* deletePriorityQueue();
bool priorirtyQueueEmpty();


int num_v,num_e;
	
int main(){
	
	int WghtTree = 0; /* Weight of the spanning tree */
	
	cout<<"Enter the filename\n";
	char fname[66];
	cin>>fname;
        
	ifstream myfile(fname);
	if(myfile.good()){
		myfile>>num_v;
		myfile>>num_e;
	
		/* Will contain the edges of minimum spanning tree */
		Edge* tree = (Edge* )malloc(num_e * sizeof(Edge));
		
		createGraph(myfile,num_v,num_e);
		createTree(tree);
	
		adjMatrix = new int*[num_v];
		for(i = 0; i < num_v; i++)
	    		adjMatrix[i] = new int[num_v];
	    
	    	for(i=0;i<num_v;i++)
			for(j=0;j<num_v;j++)
				adjMatrix[i][j]=0;
	
		/*create adjacency matrix*/
		for(i=0;i<=num_v-1;i++){
		        adjMatrix[tree[i].u][tree[i].v] = tree[i].weight;
		        adjMatrix[tree[i].v][tree[i].u] = tree[i].weight;
			WghtTree += tree[i].weight;
		}
		cout<<"Weight of Tree = "<<WghtTree<<endl;
		
		cout<<"ADJACENCY MATRIX of MINIMUM SPANNING TREE\n";
		for(i=0;i<num_v;i++){ 
			for(j=0;j<num_v;j++) 
				cout<<adjMatrix[i][j]<<" ";
			cout<<endl;
		}
		myfile.close();
	}
	else
		cout<<"ERROR:File cannot be opened......\n";
}

void createGraph(ifstream &myfile,int num_v,int num_e){
	int i,start,end,wt;

	for(i=0;i<num_e;++i){
		 myfile>>start;
		 myfile>>end;
		 myfile>>wt;
	
		 insertPriorityQueue(start,end,wt);
		 insertPriorityQueue(end,start,wt);
	}
}
void createTree(Edge *tree)
{
	Edge* tmp;

	int v1,v2,root_v1,root_v2;
	int* parent = new int[num_v]; /*Holds parent of each vertex */
	int i,count = 0;    /* Denotes number of edges included in the tree */

	for(i=0;i<num_v;i++)
		parent[i] = -1;

	while(!priorirtyQueueEmpty() and count < num_v-1 ) /*till pq empty and n-1 edges added to the tree*/
	{
		tmp = deletePriorityQueue();
		v1 = tmp->u;
		v2 = tmp->v;
		while( v1 !=-1 )
		{
			root_v1 = v1;
			v1 = parent[v1];
		}
		while( v2 != -1  )
		{
			root_v2 = v2;
			v2 = parent[v2];
		}
		if(root_v1 != root_v2){/*Insert the edge (v1, v2)*/
			count++;
			tree[count].u = tmp->u;
			tree[count].v = tmp->v;
			tree[count].weight = tmp->weight;
			parent[root_v2]=root_v1;
		}
	}
	if(count < num_v-1){
		cout<<"Graph is not connected, no spanning tree possible\n";
		exit(1);
	}
}

//*Inserting edges in the linked priority queue */..............................................
void insertPriorityQueue(int s,int e,int wt){
	Edge* ptr = new Edge;
	ptr->u = s;
	ptr->v = e;
	ptr->weight = wt;
	
	if(front == NULL or ptr->weight < front->weight ){//PQ empty OR d=smallest edge
		ptr->next = front;
		front = ptr;
	}
	else{
		Edge* q = front;
		while(q->next != NULL and q->next->weight <= ptr->weight)
			q = q->next;
		ptr->next = q->next;
		q->next = ptr;
		if(q->next == NULL)	/*Edge added at end*/
			ptr->next = NULL;
	}
}
//*Deleting an edge from the linked priority queue*/
Edge* deletePriorityQueue(){
	Edge* temp = front;
	front = front->next;
	return temp;
}
bool priorirtyQueueEmpty(){
	if(front == NULL)
		return true;
	else
		return false;
}
