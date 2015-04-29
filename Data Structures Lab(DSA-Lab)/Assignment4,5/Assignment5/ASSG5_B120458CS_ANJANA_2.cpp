#include<iostream>
#include<fstream>
using namespace std;
#define unknown 1
#define discovered 2
#define processed 3


int num_v;
int num_e;
int front=-1;
int rear=-1;
int** adjMatrix;
int *Q;
int *status;

void createGraph(ifstream &myfile,int num_ver,int num_e);
void depthFirstSearch(int s);
void dfsVisit(int v);

int main(){
	cout<<"Enter the filename : ";
	char fname[66];
	cin>>fname;

	int ch,s;

	ifstream myfile(fname);
	if(myfile.good()){
		myfile>>num_v;
		myfile>>num_e;

		adjMatrix = new int*[num_v];
		for(int j = 0; j < num_v; ++j)
    			adjMatrix[j] = new int[num_v];
		
		createGraph(myfile,num_v,num_e);

		Q=new int[num_v];
		status=new int[num_v];
		
		cout<<"Enter the source vertex : ";
		cin>>s;

		depthFirstSearch(s);
		myfile.close();
	}
	else
		cout<<"ERROR:File cannot be opened......\n";
}
void createGraph(ifstream &myfile,int num_ver,int num_e){
	int i,start,end,weight;

	for(i=1;i<=num_e;++i){
		 myfile>>start;
		 myfile>>end;
		 myfile>>weight;
	
		 adjMatrix[start][end]=weight;
		 adjMatrix[end][start]=weight;

	}
}	
void depthFirstSearch(int s){
	int v;
	
	for(v=0;v<num_v;++v)
		status[v] = unknown;
	dfsVisit(s);
	for(v=0;v<num_v; v++)
		if(status[v] == unknown)
			dfsVisit(v);
}
void dfsVisit(int v){
	int i;
	cout<<v<<" ";
	status[v] = discovered;

	for(i=0;i<num_v;i++)
		if(adjMatrix[v][i] !=0 and status[i] == unknown)
				dfsVisit(i);

	status[v] = processed;
}
