#include<iostream>
#include<fstream>
#include<sys/time.h>
using namespace std;
////////////LINEAR SEARCH/////////////
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
	
	myfile>>key;//get the number to be searched
	gettimeofday(&start,NULL); //LINEAR SEARCH begins
	i=0;
	int pos=-1;
	while(i!=size)
	{
		if(array[i]==key)
		{
			pos=i;
			cout<<pos<<"\n";
		}
		i++;
	}
	if(pos==-1)
		cout<<pos<<"\n";
	gettimeofday(&end,NULL); //LINEAR SEARCH ends
	delete[] array;
	cout<<"Running Time : "<<((double) (end.tv_usec - start.tv_usec) / 1000000 + (double) (end.tv_sec - start.tv_sec))<<" sec\n";
	}
	else
		cout<<"ERROR: Size of the array was not valid!!!\n";
 }
 else
	cout<<"ERROR:Sorry!!!The file cannot be opened\n";

 myfile.close();
 return 0;
}
