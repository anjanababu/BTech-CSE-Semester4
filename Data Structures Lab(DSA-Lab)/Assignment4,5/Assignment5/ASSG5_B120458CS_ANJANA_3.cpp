//Find shortest distances using Dijkstra's algorithm */
#include<iostream>
#include<fstream>
#include<stdlib.h>
using namespace std;
#define TEMP 0
#define PERM 1

#define INFINITY 10000
#define NIL -1
int num_v,num_e,i,j;    
int** adjMatrix;
struct Graph{
	int pi;	/*predecessor of each vertex in shortest path*/ 
	int d;
	int status;
};
void DIJKSTRA_ALGORITHM(Graph *vertex,int s);
void INITIALIZE_SINGLE_SOURCE(Graph *vertex,int s);
void RELAX(Graph *vertex,int i,int current);
int MIN_VERTEX(Graph *vertex);
void pathLength(Graph *vertex,int s,int v);
void createGraph(ifstream &myfile,int num_ver,int num_e);

	
int main(){
	cout<<"Enter the filename : ";
	char fname[66];
	cin>>fname;

	ifstream myfile(fname);
	if(myfile.good()){
		myfile>>num_v;
		myfile>>num_e;

		adjMatrix = new int*[num_v];
		for(j = 0; j < num_v; ++j)
    			adjMatrix[j] = new int[num_v];
		
		createGraph(myfile,num_v,num_e);
       		
		Graph* vertex = (Graph*)malloc(num_v * sizeof(Graph));

		cout<<"Enter the source vertex : ";
		int s;		
		cin>>s;

		DIJKSTRA_ALGORITHM(vertex,s);

        	cout<<"Length of Shortest Path from Source Vertex "<<"("<<s<<")\n";
		
		/*Prints just the list of Vertices*/
		for(i=0;i<num_v;i++)
			cout<<i<<"   ";
		cout<<endl;
	
		/*Prints the Shortest PathLengths*/
		for(i=0;i<num_v;i++)
			pathLength(vertex,s,i);
		cout<<endl;

		myfile.close();
	}
	else
		cout<<"ERROR:File cannot be opened......\n";
}
void DIJKSTRA_ALGORITHM(Graph *vertex,int s){
	int i,current;

	INITIALIZE_SINGLE_SOURCE(vertex,s);
	
	/*Search for a temp vertex with minimum vertex[].d and make it current vertex*/
	while(true){
		current = MIN_VERTEX(vertex);
		if(current == NIL)
			return;
		vertex[current].status = PERM;
		for(i=0;i<num_v;i++)
			RELAX(vertex,i,current);/*Checks for adjacent TEMP vertices */
			
	}
}
void INITIALIZE_SINGLE_SOURCE(Graph *vertex,int s){
	for(i=0;i<num_v;i++){	   
		vertex[i].d = INFINITY;
		vertex[i].pi =  NIL;
		vertex[i].status = TEMP;
	}
	vertex[s].d = 0;//distance to the source node is 0
}
void RELAX(Graph *vertex,int i,int current){
	if (adjMatrix[current][i] !=0 and vertex[i].status == TEMP )
		if(vertex[current].d + adjMatrix[current][i] < vertex[i].d){
			vertex[i].pi = current;  
			vertex[i].d = vertex[current].d + adjMatrix[current][i];    
		}
}	
void createGraph(ifstream &myfile,int num_ver,int num_e){
	int i,start,end,weight;

	for(i=1;i<=num_e;++i){
		 myfile>>start;
		 myfile>>end;
		 myfile>>weight;
	
		 adjMatrix[start][end] = weight;
		 adjMatrix[end][start] = weight;
	}
}
void pathLength(Graph *vertex,int s, int v )
{
	int u;
	int shortdist = 0;	                               
	while(v != s){
		u = vertex[v].pi;
		shortdist += adjMatrix[u][v];
		v = u;	
	}
	cout<<shortdist<<"  ";
}
/*Returns
 *TEMP vertex with minimum value of vertex[].d
 *NIL if no TEMP vertex left or all TEMP vertices left have vertex[].d INFINITY*/
int MIN_VERTEX(Graph *vertex){
	int i;
	int min = INFINITY;
	int k = NIL;  
	for(i=0;i<num_v;i++)
		if(vertex[i].status == TEMP and vertex[i].d < min){
			min = vertex[i].d;
			k = i;
		}
	return k;
}
/*void pathLength(Graph *vertex,int s, int v )
{
	int u;
	int *path = new int[num_v];	//stores the shortest path
	int shortdist = 0;	        //length of shortest path 
	int count = 0;		//number of vertices in the shortest path
	                              
	while(v != s){
		++count;
		path[count] = v;
		u = vertex[v].pi;
		shortdist += adjMatrix[u][v];
		v = u;	
	}
	++count;
	path[count]=s;
	cout<<shortdist<<"  ";
}*/
