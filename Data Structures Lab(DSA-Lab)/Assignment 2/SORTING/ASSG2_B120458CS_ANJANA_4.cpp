#include<iostream>
#include<stdio.h>
#include<string.h>
#include<fstream>
#include<malloc.h>
#include<sys/time.h>
using namespace std;
////////SELECTION SORT////////
char swap(char &a,char &b);
int main()
{
 struct timeval start, end;
 
 char fname[30],ch[100];
 cout<<"Enter the File Name  : ";
 cin>>fname;
 ifstream myfile(fname);//opened file to read
 
 if(myfile.good())
 {
	int size,i;
	myfile>>size;
	if(size>=0)
	{
	myfile.ignore(1000, '\n');
	char **strarray=(char **)malloc(sizeof(char*) *size); 

	for(i=0;i<size;i++) 
		strarray[i] = (char *)malloc (sizeof(char) * 100); 
	for(i=0;i<size;i++)
	{
		myfile.getline(ch,100);
		strcpy(strarray[i],ch);
	}

	int pos,j;
	char smallest[100],temp[100];
	gettimeofday(&start,NULL);	//SELECTION SORT begins
	for(i=0;i<size;i++)
	{
		strcpy(smallest,strarray[i]);
		pos=i;
		for(j=i+1;j<size;j++)
			if(strcmp(strarray[j],smallest)<0)
			{
				strcpy(smallest,strarray[j]);
				pos=j;
			}
		if (pos!=i)
		{
			
			strcpy(temp,strarray[i]);
			strcpy(strarray[i],strarray[pos]);
			strcpy(strarray[pos],temp);
		}
	}
	gettimeofday(&end,NULL);  //SELECTION SORT ends
	
	ofstream myoutput("selectionsortoutput.txt");
	for(i=0;i<size;i++)
		myoutput<<strarray[i]<<"\n";
	myoutput<<"Running Time : "<<((double) (end.tv_usec - start.tv_usec) / 1000000 + (double) (end.tv_sec - start.tv_sec))<<" sec";
	myoutput.close();
	
	for (i = 0; i < size; ++i) 
		free(strarray[i]); 
	free(strarray);
	
	}
	else
		cout<<"ERROR:The size entered was not valid!!\n";
 }
 else
	cout<<"ERROR:Sorry!!!The file cannot be opened\n"; 
 myfile.close();
 return 0;
}

