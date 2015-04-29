#include<iostream>
#include<fstream>
#include<stdlib.h>
#include<sys/time.h>
//////RANDAMIZED_SELECT MEDIAN///////
using namespace std;
int randomized_select(int *array,int s,int e,int i);
int randomized_partition(int *array,int s,int e);
int partition(int *array,int s,int e);

int swap(int &a,int &b);
int i,m,k;
int main()
{
 struct timeval start, end;
	
 float median;
 int size,num;
 
 char fname[30];
 cout<<"Enter the File Name  : ";
 cin>>fname;
 
 ifstream myfile(fname);//opened file to read
 if(myfile.good())
 {
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
	
	int m1,m2;
	gettimeofday(&start,NULL);	//RANDOMIZED SELECTION begins
	if(size%2!=0)
		median=randomized_select(array,0,size-1,(size+1)/2);//provide the kth element(index+1)
	else
	{
		m1=randomized_select(array,0,size-1,size/2);
		m2=randomized_select(array,0,size-1,(size/2)+1); 
		median=float(m1+m2)/2;
	}
	cout<<"Median : "<<median<<"\n";
	gettimeofday(&end,NULL);  //RANDOMIZED SELECTION ends
	cout<<"Running Time : "<<((double) (end.tv_usec - start.tv_usec) / 1000000 + (double) (end.tv_sec - start.tv_sec))<<" sec\n";
	
	delete[] array;
	}
	else
		cout<<"ERROR:The size entered was not valid!!\n";

 }
 else
	cout<<"ERROR:Sorry!!!The file cannot be opened\n";

 myfile.close();
 return 0;
}
int randomized_select(int *array,int s,int e,int key)//selects the keyth random element
{
	if(s==e)
		return array[s];
	m=randomized_partition(array,s,e);
	k=m-s+1;
	if(key==k)
		return array[m];
	else if(key<k)
		return randomized_select(array,s,m-1,key);
	else 
		return randomized_select(array,m+1,e,key-k);
} 
int randomized_partition(int *array,int s,int e)
{
	int range=e-s+1;
	int r=rand()%range+s;
	swap(array[e],array[r]);
	return partition(array,s,e);
}
int partition(int *array,int s,int e)
{
		int j,pivot;
		pivot=array[e];
		i=s-1;
		for(j=s;j<e;j++)
			if(array[j]<=pivot)
			{
				i++;
				swap(array[i],array[j]);
			}
		swap(array[i+1],array[e]);
		return (i+1);
}
int swap(int &a,int &b)
{
	int temp;
	temp=a;
	a=b;
	b=temp;
}
	
	


