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
void breadthFirstSearch(int s);

void enqueue(int *Q,int element);
int dequeue(int *Q);
bool queueEmpty(int *Q);
bool queueFull(int *Q);

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

		breadthFirstSearch(s);
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
void breadthFirstSearch(int s){
	int i,u;
	
	for(i=0;i<num_v;++i)
		status[i] = unknown;

	enqueue(Q,s);
	status[s] = unknown;
	
	while(!queueEmpty(Q))
	{
		u = dequeue(Q);
		cout<<u<<" ";
		status[u] = discovered;

		for(int v=0;v<num_v;++v){
			/*Check for adjacent unknown vertices */
			if(adjMatrix[u][v]!=0 and status[v] == unknown){
				status[v] = discovered;
				enqueue(Q,v);
			}
		}
		status[u] = processed;
	}
	cout<<endl;
}

void enqueue(int *Q,int element){
	if(queueFull(Q))/*Queue is full*/
		cout<<"OVERFLOW";
	else{
		if(rear==-1)/*initially*/
			front=0;
		else if(rear==num_e-1)
			rear=-1;
		Q[++rear]=element;
	}
}
int dequeue(int *Q){
	if(queueEmpty(Q))/*Queue is empty*/
		return -1;
	else{
		int temp=Q[front];
		if(front==rear)/*only one element in the queue*/
			front=rear=-1;
		else if(front==num_e-1)
			front=0;
		else
			front++;
		return temp;
	}
}
bool queueEmpty(int *Q){
	if(front == -1 or front > rear)
		return true;
	else
		return false;
}
bool queueFull(int *Q){
	if(rear == num_e-1)
		return true;
	else 
		return false;
}	
