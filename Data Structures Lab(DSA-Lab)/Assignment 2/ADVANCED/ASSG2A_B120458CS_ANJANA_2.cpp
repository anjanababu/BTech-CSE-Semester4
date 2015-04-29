#include<iostream>
#include<stdlib.h>
#include<fstream>
#include<string.h>
#include<sys/time.h>
using namespace std;
////////////EXTERNAL SORT//////////
void externalsort(char *file);
void mergefragmentfiles(char *filename, int numfiles);
int left(int node);
int right(int node);
int heap_sort(int *array,int size);
int build_max_heap(int *array,int size);
int max_heapify(int *array,int node,int size);
int swap(int &a,int &b);
int heapsize;
int main ()
{
	struct timeval start, end;
	
	char fname[66];
	cout<<"Enter the File name : ";
	cin>>fname;
	
	gettimeofday(&start,NULL);	//Algo Begins
	externalsort(fname);
	gettimeofday(&end,NULL);  //Algo Ends
	
	cout<<"Running Time : "<<((double) (end.tv_usec - start.tv_usec) / 1000000 + (double) (end.tv_sec - start.tv_sec))<<" sec\n";
	return 0;
}

void externalsort(char *bigfile)//splits a bigfile and sorts and then merge it back
{
	
	int i,len,fragments = 0;
	
	char tempfname[66], buffer[100];
	int *arr = (int *) malloc ((1024*1024) * sizeof(int));//declare 4MB(max) array
	
	strcpy(tempfname,"temp.txt");
	
	if(!arr)//if you cant get 4MB space in memory
	{
		cout<<"ERROR:No memory...Need 4MB to proceed!!\n";
		return;
	}
	ifstream infile(bigfile);
	
	i = 0;
	if(infile.good())
	{
		int num;
		while(true)
		{
			infile>>num;
		
			if(i>=(1024*1024) || !infile.good())//if 4MB got full OR reached end of bigfile
			{
				len = i;
			
				heap_sort(arr,len);
				
				sprintf(buffer,"%s%d",tempfname,fragments);//fragment file of the form temp.txt0/1..
				ofstream fileobj(buffer);
			
				for(i=0;i<len;i++)//making the fragment files by copying the content of 4MB array
					fileobj<<arr[i]<<endl;
					
				i = 0;
				fragments++;
				if (!infile.good())
					break;
			}
			arr[i++]=num;
		}//fragments made!!!!	
		mergefragmentfiles(tempfname,fragments);//takes just the common name(temp.txt) of fragment files
	}
	else
		cout<<"ERROR:Sorry!!The file cannot be opened\n";
	return;
}

void mergefragmentfiles(char *filename,int fragments)
{
	if(fragments==1)
		return;		
		
	int i;
	char buffer[100];
	char in1name[100],in2name[100],outname[100];
	
	bool bnum1=false,bnum2=false;
	int num1,num2;
	

	ifstream in1, in2;
	
	for(i=0;i<fragments/2;i++)
	{
		//getting 2 correct fragments
		sprintf(in1name,"%s%d",filename,2*i);
		ifstream in1(in1name);
		
		sprintf(in2name, "%s%d", filename, 2 * i + 1);
		ifstream in2(in2name);
		
		strcat(outname,".temp");
		ofstream out(outname);
		
		while (true)
		{
			if(!bnum1)
			{
				in1>>num1;
				if (in1.good())
				  bnum1=true;
			}
			
			if(!bnum2)
			{
				in2>>num2;
				if (in2.good())
				  bnum2=true;
			}
			
			if(!in1.good() || !in2.good())//reached end of atleast one file!!!
			{
			  if(bnum1)
			    out<<num1<<endl;
		      if(bnum2)
				out<<num2<<endl;
		      break;
			}
			
			if (num1<num2)
			{
				out<<num1<<endl;
				bnum1=false;
			}
			else 
			{
				out<<num2<<endl;
				bnum2=false;
			}
		}
		
		while(true)
		{
			in1>>num1;
			
			if(!in1.good ())
				break;
				
			out<<num1<<endl;
		}
		
		while (true)
		{
			in2>>num2;
			
			if(!in2.good())
				break;
				
			out<<num2<<endl;
		}
		
		out.close ();
		in1.close ();
		in2.close ();
		
		remove(in1name);
		remove(in2name);
		rename(outname, in1name);
	}
	
	if(fragments%2 != 0)
	{
		sprintf(buffer, "%s%d", filename, fragments - 1);
		sprintf(outname, "%s%d", filename, i);
		rename(buffer,outname);
	}
	
	mergefragmentfiles(filename, i);
}
int left(int node)
{
	return (2*node+1);
}
int right(int node)
{
	return (2*node+2);
}
int heap_sort(int *array,int size)
{
	int i;
	build_max_heap(array,size);
	for(i=size-1;i>0;i--)
	{
			swap(array[0],array[i]);
			heapsize-=1;
			max_heapify(array,0,size);
	}
}
int build_max_heap(int *array,int size)
{
	int i;
	heapsize=size;
	for(i=size/2-1;i>=0;i--)
		max_heapify(array,i,size);
}
int max_heapify(int *array,int node,int size)
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
		max_heapify(array,largest,size);
	}
}	
int swap(int &a,int &b)
{
	int temp;
	temp=a;
	a=b;
	b=temp;
}
