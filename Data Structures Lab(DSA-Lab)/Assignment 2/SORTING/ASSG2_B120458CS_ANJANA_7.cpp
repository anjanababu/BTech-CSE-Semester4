#include<iostream>
#include<fstream>
#include<sys/time.h>
using namespace std;
/////////MERGE SORT////////
int merge_sort(int *array,int starting,int ending);
int merge(int *array,int s,int m,int e);

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
 	int size;
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
	
	gettimeofday(&start,NULL);	//MERGE SORT begins
	merge_sort(array,0,size-1);
	gettimeofday(&end,NULL);  //MERGE SORT ends
	
	ofstream myoutput("mergesortoutput.txt");
	for(i=0;i<size;i++)
		myoutput<<array[i]<<"\n";
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
int merge_sort(int *array,int starting,int ending)
{
	int mid;
	if(starting<ending)
	{
		mid=(starting+ending)/2;
		merge_sort(array,starting,mid);
		merge_sort(array,mid+1,ending);
		merge(array,starting,mid,ending);
	}
}
int merge(int *array,int s,int m,int e)
{
	int size1,size2,i,j;
	size1=m-s+2;//extra 1 space for sentinels
	size2=e-m+1;
	int *left=new int[size1];
	int *right=new int[size2];
	for(i=0;i<size1-1;i++)
		left[i]=array[s+i];
	for(j=0;j<size2-1;j++)
		right[j]=array[m+j+1];
	left[size1-1]=1000000000;//sentinels
	right[size2-1]=1000000000;
	i=0,j=0;
	int k;
	for(k=s;k<=e;k++)
	{
		if(left[i]<=right[j])
		{
			array[k]=left[i];
			i++;
		}
		else
		{
			array[k]=right[j];
			j++;
		}
	}
}
	
	


