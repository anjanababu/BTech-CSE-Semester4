#include<iostream>
#include<fstream>
#include<sys/time.h>
using namespace std;
/////////INSERTION SORT///////
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
	char buffer[50];
 	int size;
 	double num;
 	myfile>>size;
 	if(size>=0)
 	{
 	double *array=new double [size];

	i=0;
	while(i!=size)//making the array
	{
		myfile>>num;
		array[i]=num;
		i++;
	}
	
	gettimeofday(&start,NULL);	//INSERTION SORT begins
	int j;
	double key;
	for(i=1;i<size;i++)
	{
		key=array[i];
		j=i-1;
		while(j>=0 && array[j]>key)
		{
			array[j+1]=array[j];
			--j;
		}
		array[j+1]=key;
	}
	gettimeofday(&end,NULL);  //INSERTION SORT ends
	
	ofstream myoutput("insertionsortoutput.txt");
	for(i=0;i<size;i++)
	{
		sprintf(buffer,"%.5f",array[i]);
		myoutput<<buffer<<"\n";
	}
	delete[] array;
	myoutput<<"Running Time : "<<((double) (end.tv_usec - start.tv_usec) / 1000000 + (double) (end.tv_sec - start.tv_sec))<<" sec";
	myoutput.close();
	}
	else
		cout<<"ERROR: Size of the array was not valid!!!\n";
 }
 else
	cout<<"ERROR:Sorry!!!The file cannot be opened\n";

 myfile.close();
 
 return 0;
}
