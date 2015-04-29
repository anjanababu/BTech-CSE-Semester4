#include<iostream>
#include<fstream>
#include<malloc.h>
#include<string.h>
#include<sys/time.h>
///////////RADIX SORT///////
using namespace std;

struct data
{
	char *str;
	int len;
};

void radix_sort (data *strings, int size, int maxlen);
void sort_with_index (data *strings, int size, int index);
bool less_than (data a, data b, int radix);
bool valid(char dig);
void printinvalidity();
int errorflag=0;
int main ()
{
	struct timeval start, end;
	
	char fname[66];
	int size,i,max = 0,m;
	
	cout<<"Enter the File Name  : ";	
	cin>>fname;
	ifstream myfile(fname);
	
	if(myfile.good())
	{
		myfile>>size;
		if(size>=0)//size valid
		{
		data *strings = (data *)malloc (size * sizeof(data)); //array of objects
		for(i=0;i<size;i++)
			strings[i].str = (char *)malloc (sizeof(char) * 100);
		
		//MAKE THE STRING ARRAY CONTAINING 0x NUMBERS		
		for(i=0;i<size && errorflag==0;i++)
		{
			myfile>>strings[i].str;
			strings[i].len = strlen(strings[i].str);
			m=0;
			while(m!=strings[i].len)
			{
				if(!valid(strings[i].str[m]))
					printinvalidity();
				m++;
			}
			if(strings[i].len>8 && errorflag==0)
			{
				errorflag=1;
				cout<<"\nERROR:Some hexadecimal number contains more than 8 digits\n";
			}
			else
				if(strings[i].len>max)
					max=strings[i].len;
		}//Array Made!!
		if(errorflag==0)
		{
			gettimeofday(&start,NULL);	//RADIX SORT begins
			radix_sort(strings,size,max);
			gettimeofday(&end,NULL);  //RADIX SORT ends
		
			ofstream myoutput("radixsortoutput.txt");
			for(i=0;i<size;i++)
				myoutput<<strings[i].str<<"\n";
			myoutput<<"Running Time : "<<((double) (end.tv_usec - start.tv_usec) / 1000000 + (double) (end.tv_sec - start.tv_sec))<<" sec";
			myoutput.close();
		}
	}
	else
		cout<<"ERROR:The size entered was not valid!!\n";
	}
	else
		cout<<"ERROR:Sorry!!!The file cannot be opened\n"; 
	myfile.close();
	
	return 0;
}

void radix_sort(data *strings,int size,int maxlen)
{
	int i;
	for (i=0;i<maxlen && errorflag==0;i++)
		sort_with_index(strings,size,i);
}

void sort_with_index(data *strings, int size, int index)
{
	int i, j;
	i=0;
	if(size==1)//if only 1 element invalidity condition
	{
		while(i!=strings[0].len && errorflag==0)
		{
			if(!valid(strings[0].str[i]))
			{
				errorflag=1;
				printinvalidity();
			}
			i++;
		}
	}
	
	for(i=0;i<size && errorflag==0;i++)//basically a bubblesort
	{
		for(j=0;j<size-i-1 && errorflag==0;j++)
			 if(!less_than(strings[j],strings[j + 1], index))
			 {
				data temp;
				temp.str = (char *) malloc (sizeof(char) * 100);
				
				temp.len = strings[j].len;
				strcpy(temp.str, strings[j].str);
				
				strings[j].len = strings[j + 1].len;
				strcpy(strings[j].str, strings[j + 1].str);
				
				strings[j + 1].len = temp.len;
				strcpy(strings[j + 1].str, temp.str);
				free(temp.str);
			}
	}
}

bool less_than (data hexnum1, data hexnum2, int radix)
{
  if (hexnum1.len > hexnum2.len)//check for abnormal zeroes(00)
  {
    int trimlen1=hexnum1.len;
    int trimlen2=hexnum2.len, i;
    
    for (i = 0; i < hexnum1.len; ++i)
      if (hexnum1.str[i] == '0')
        trimlen1--;
      else break;
      
    for (i = 0; i < hexnum2.len; ++i)
      if (hexnum2.str[i] == '0')
        trimlen2--;
      else break;
      
    if (trimlen1 < trimlen2)
      return true;
  }
  
	if(hexnum1.len<=radix && hexnum2.len<=radix)
			return true;
	else if(hexnum1.len<=radix && hexnum2.len>radix)
			return true;
	else if(hexnum1.len>radix && hexnum2.len<=radix)
			return false;
	else if(hexnum1.len>radix && hexnum2.len>radix)
			if (hexnum1.str[hexnum1.len - radix - 1] > hexnum2.str[hexnum2.len - radix - 1])
				return false;
	return true;
}
bool valid(char dig)
{
	if(dig>='0' && dig<='9')
		return true;
	else if(dig>='a' && dig<='f')
		return true;
	else if(dig>='A' && dig<='F')
		return true;
	else 
		return false;
}
void printinvalidity()
{
	errorflag=1;
	cout<<"\nERROR:Some invalid character in hexadecimal number";
	cout<<"\nVALID CHARACHTERS: 0-9 and A/a to F/f\n";
}
