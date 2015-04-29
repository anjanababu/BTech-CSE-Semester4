#include<iostream>
#include<fstream>
#include<sys/time.h>
using namespace std;
/////////HEAP SORT//////
int left(int node);
int right(int node);
int heap_sort(int *array);
int build_max_heap(int *array);
int max_heapify(int *array,int node);
int swap(int &a,int &b);
int size;
int heapsize;

int main()
{
 struct timeval start, end;
	
 int i;
	
 char fname[30];
 cout<<"Enter the File Name  : ";
 cin>>fname;
 ifstream myfile(fname);//opened file to read
	
 if(myfile.good())
 {
 	int num;
 	myfile>>size;
 	if(size>=0)
 	{
 	int *array=new int [size];

	i=0;
	while(i!=size)//making the array
	{
		myfile>>num;
		array[i]=num;
		i++;
	}
	
	gettimeofday(&start,NULL);	//HEAP SORT begins
	heap_sort(array);
	gettimeofday(&end,NULL);  //HEAP SORT ends
	
	ofstream myoutput("heapsortoutput.txt");
	for(i=0;i<size;i++)
	{
		myoutput<<array[i];
		myoutput<<'\n';
	}
	delete[] array;
	myoutput<<"Running Time : "<<((double) (end.tv_usec - start.tv_usec) / 1000000 + (double) (end.tv_sec - start.tv_sec))<<" sec";
	myoutput.close();
	}
	else
		cout<<"ERROR:The size entered was not valid!!\n";
		
 }
 else
	cout<<"ERROR:Sorry!!!The file cannot be opened\n";

 myfile.close();
 
 return 0;
}
int left(int node)
{
	return (2*node+1);
}
int right(int node)
{
	return (2*node+2);
}
int heap_sort(int *array)
{
	int i;
	build_max_heap(array);
	for(i=size-1;i>0;i--)
	{
			swap(array[0],array[i]);
			heapsize-=1;
			max_heapify(array,0);
	}
}
int build_max_heap(int *array)
{
	int i;
	heapsize=size;
	for(i=size/2-1;i>=0;i--)
		max_heapify(array,i);
}
int max_heapify(int *array,int node)
{
	int l=left(node);
	int r=right(node);
	int largest=node;
	if(l<heapsize && array[l]>array[node])
		largest=l;
	if(r<heapsize && array[r]>array[largest])
		largest=r;
	if(largest!=node)
	{
		swap(array[node],array[largest]);
		max_heapify(array,largest);
	}
}	
int swap(int &a,int &b)
{
	int temp;
	temp=a;
	a=b;
	b=temp;
}
	
	


