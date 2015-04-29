#include <iostream>
#include <math.h>
using namespace std;
int n,size;
//Program to check whether a solution to sudoku is correct
void getInput(int a[100][100]);
void printArray(int b[100][100]);
int repeatsInRow(int element,int sol[100][100],int ipos,int jpos);
int repeatsInColumn(int element,int sol[100][100],int ipos,int jpos);
int sumEquals(int sol[100][100],int p,int q,int sum);


int main()
{
    cout<<"Enter the size(greater than 3) : ";
    int inp[100][100],sol[100][100];
    int sum=0;
    int i,j;
    cin>>size;
    n=sqrt(size);
    if(size%n==0)
    {
    	cout<<"Enter the input Sudoku\n";
    	getInput(inp);
    	cout<<"Enter the solution Sudoku\n";
    	getInput(sol);
    	cout<<"-------INPUT--------\n";
    	printArray(inp);
    	cout<<"\n-------SOLUTION------\n";
    	printArray(sol);
    	cout<<endl;
    	int sum=0;
    	for(i=0;i<size;i++)
    		sum+=(i+1)*(i+1);

    	//Checks for consistency
    	int flagc=1;
    	for(i=0;i<size;i++)
        {
            for(j=0;j<size;j++)
            {
                if(sol[i][j]!=inp[i][j] && inp[i][j]!=0)
                {
                    flagc=0;break;//not consistent
                }
            }
            if(flagc==0)
                break;
        }

    	if(flagc==1)//if consistent
    	{
    		//perform other checks
    		//perform row check
    		int flagr=0,flagcol=0,flags=0;//doesnt repeat in row,coloumn and sum of squares not equal
    		for(i=0;i<size;i++)
    		{
    			for(j=0;j<size;j++)
    			{
    				flagr=repeatsInRow(sol[i][j],sol,i,j+1);
    				if(flagr==1)//repeats in row
    				{
						cout<<"\nNo,repeated "<<sol[i][j]<<" in row "<<i+1<<endl;
                        break;
					}
					else
					{
						//checks in column
						flagcol=repeatsInColumn(sol[i][j],sol,i+1,j);
						if(flagcol==1)//repeats in column
						{
							cout<<"\nNo,repeated "<<sol[i][j]<<" in column "<<j+1<<endl;
							break;
						}
					}
				}
				if(flagr==1 || flagcol==1)
                    break;
            }
            if(flagr==0 && flagcol==0)
            {
                //sumcheck;

                int start=0,end=-n;
                int z,x,box=0;
                for(z=1;z<=size;z+=n)
                {
                    for(x=0;x<size;x+=n)
                    {
                        start=start;
                        end+=n;
                        box++;
                        flags=sumEquals(sol,start,end,sum);
                        if(flags==0)
                        {
                            cout<<"\nNo...Repetion in Small Square "<<box<<endl;
                            break;
                        }
                    }
                    if (flags==0)
                        break;
                    start+=n;//when reach end
                    end=-n;
                }
            }
            if(flagc==1 && flagr==0 && flagcol==0 and flags==1)
				cout<<"\nYes...Correct Solution\n";
    }
    else
    	cout<<"\nNo,solution inconsistent with Sudoku, "<<" in column "<<j+1<<" ,row "<<i+1<<endl;

    }
    else
    	cout<<"\nThe size entered is not valid\n";

    return 0;
}
void getInput(int a[100][100])
{
	int i,j;
    for(i=0;i<size;i++)
        for(j=0;j<size;j++)
           		cin>>a[i][j];
}
void printArray(int b[100][100])
{
	int i,j;
    for(i=0;i<size;i++)
    {
        cout<<endl;
        for(j=0;j<size;j++)
            cout<<" "<<b[i][j];
    }
}
int repeatsInRow(int element,int sol[100][100],int ipos,int jpos)
{
	int flag=0;
	int j;
	for(j=jpos;j<size;j++)
	{
		if(element==sol[ipos][j])
		{
			flag=1;
			break;
		}
	}
	return flag;
}
int repeatsInColumn(int element,int sol[100][100],int ipos,int jpos)
{
	int flag=0;
	int i;
	for(i=ipos;i<size;i++)
	{
		if(element==sol[i][jpos])
		{
			flag=1;
			break;
		}
	}
	return flag;
}
int sumEquals(int sol[100][100],int sp,int ep,int sum)
{
	int sumsquare=0;
	int p,q;
	for(p=sp;p<sp+n;p++)
		for(q=ep;q<ep+n;q++)
			sumsquare+=(sol[p][q])*(sol[p][q]);

	if(sumsquare==sum)
		return 1;
	else
		return 0;
}






