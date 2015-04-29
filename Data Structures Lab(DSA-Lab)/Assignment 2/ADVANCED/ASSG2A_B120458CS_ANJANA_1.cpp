#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<fstream>
#include<malloc.h>
#include<sys/time.h>
using namespace std;
int i,j,m,k;
int errorflag=0;

char* randomized_select(char **array,int s,int e,int key);
int randomized_partition(char **array,int s,int e);
int partition(char **array,int s,int e);
int main()
{
 struct timeval start, end;
 
 int prev=0;
 int key;
 cout<<"Enter the value of k : ";
 cin>>key;
 int numstring=0;
 char fname[30],ch;
 cout<<"Enter the File Name  : ";
 cin>>fname;
 
 ifstream myfile(fname);
 if(myfile.good())
 {
	gettimeofday(&start,NULL);	//Algo Begins
	 //NUMBER OF STRINGS
	ch=myfile.get();
	while(myfile.good())//to ensure file contains atleast one string
	{
		numstring=1;
		while(myfile.good())
		{
			if(ch==' ')
				numstring++;
			ch=myfile.get();
		}
	}
	myfile.close();
	if (key<=numstring && key>0)
	{
		//myfile.seekg(0);
		char **strarray=(char **)malloc(sizeof(char*) *numstring); 
		for(i=0;i<numstring;i++) 
			strarray[i] = (char *)malloc (sizeof(char) * 6);
		
		ifstream myfile(fname);
		//MAKE STRING ARRAY	
		for(i=0;i<numstring && errorflag==0;i++)
		{
			j=0;
			ch=myfile.get();
			while(j<=6 && myfile.good() && errorflag==0)
			{
				if(ch>='a' && ch<='z')
				{
					strarray[i][j]=ch;	
					j++;
					
				}	
				else if(ch==' '|| ch==EOF)
				{
					strarray[i][j]='\0';
					break;
				}
				else if(ch=='\n')
					prev=10;
				else
				{
					errorflag=1;
					cout<<"\nERROR:Invalid Input Character\n";break;
				}
				ch=myfile.get();
				if(prev==10)
					if(ch!=EOF)
					{
						errorflag=1;
						cout<<"\nERROR:Inalid Newline charachter\n";break;
					}
			}
			if(j>6 && errorflag==0)
			{
				errorflag=1;
				if ((ch!=' ' || ch!=EOF) && (ch>='a' && ch<='z'))
					cout<<"\nERROR:Sting contain more than 6 characters\n";
				else if((ch!=' ' || ch!=EOF) && !(ch>='a' && ch<='z'))
					cout<<"\nERROR:Sting contain more than 6 characters which is an invalid input\n";
			}
		}//String array made!!
		
		if(errorflag==0)
		{
		//RANDOMIZED-SELECTION
		cout<<"\n"<<key<<"th smallest word : ";
		cout<<randomized_select(strarray,0,numstring-1,key);
		cout<<"\n";
		}
	}
	else
		cout<<"\nERROR:k entered is not within the bound (ie NOT 0<k<numberofstrings !!!\n";
	gettimeofday(&end,NULL);  //Algo Ends
	cout<<"Running Time : "<<((double) (end.tv_usec - start.tv_usec) / 1000000 + (double) (end.tv_sec - start.tv_sec))<<" sec\n";
 }
 else
	cout<<"ERROR:Sorry!!!The file cannot be opened\n"; 

 myfile.close();
 return 0;
}

char* randomized_select(char **array,int s,int e,int key)//selects the keyth random element
{
	if(s==e)
		return array[s];
	else
	{
	m=randomized_partition(array,s,e);
	k=m-s+1;
	if(key==k)
		return array[m];
	else if(key<k)
		return randomized_select(array,s,m-1,key);
	else 
		return randomized_select(array,m+1,e,key-k);
	}
} 
int randomized_partition(char **array,int s,int e)
{
	int range=e-s+1;
	int r=rand()%range+s;
	swap(array[e],array[r]);
	return partition(array,s,e);
}

int partition(char **array,int s,int e)
{
		int j;
		char temp[7];
		i=s-1;
		for(j=s;j<e;j++)
			if(strcmp(array[j],array[e])<=0)
			{
				i++;
				
				strcpy(temp,array[i]);
				strcpy(array[i],array[j]);
				strcpy(array[j],temp);
			}
		strcpy(temp,array[i+1]);
		strcpy(array[i+1],array[e]);
		strcpy(array[e],temp);
		return (i+1);
}

	
	




