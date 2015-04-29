#include<iostream>
#include<fstream>
#include<sys/time.h>
using namespace std;
///////////BINARY SEARCH/////////
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
 	int size,key,num;
 	myfile>>size;
 	if(size>=0)//size valid
 	{
 	int *array=new int [size];

	i=0;
	while(i!=size)//making the array
	{
		myfile>>num;
		array[i]=num;
		i++;
	}
	
	myfile>>key;//get the number to be searched
	gettimeofday(&start,NULL);	//BINARY SEARCH begins
	int lb,ub,mid,pos;
	lb=0;
	ub=size-1;	
	pos=-1;
	while(lb<=ub)
	{
		mid=(lb+ub)/2;
		if(array[mid]==key)
		{
			pos=mid;
			break;
		}
		else if(array[mid]>key)
			ub=mid-1;
		else
			lb=mid+1;
	}
	gettimeofday(&end,NULL); //BINARY SEARCH ends
	cout<<pos<<"\n";
	delete[] array;
	cout<<"Running Time : "<<((double) (end.tv_usec - start.tv_usec) / 1000000 + (double) (end.tv_sec - start.tv_sec))<<" sec\n";
	}
	else
		cout<<"ERROR:The size entered was not valid!!\n";
 }
 else
	cout<<"ERROR:Sorry!!!The file cannot be opened\n";
 
 myfile.close();
 
 return 0;
}
