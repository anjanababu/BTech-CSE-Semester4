#include<iostream>
#include<fstream>
#include<sys/time.h>
using namespace std;
/////////QUICK SORT/////////
int quick_sort(int *array,int starting,int ending);
int partition(int *array,int s,int e);
int swap(int &a,int &b);
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
	
	gettimeofday(&start,NULL);	//QUICK SORT begins
	quick_sort(array,0,size-1);
	gettimeofday(&end,NULL);  //QUICK SORT ends
	
	ofstream myoutput("quicksortoutput.txt");
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
int quick_sort(int *array,int starting,int ending)
{
	int mid;
	if(starting<ending)
	{
		mid=partition(array,starting,ending);
		quick_sort(array,starting,mid-1);
		quick_sort(array,mid+1,ending);
	}
}
int partition(int *array,int s,int e)
{
		int i,j,pivot;
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
	
	


