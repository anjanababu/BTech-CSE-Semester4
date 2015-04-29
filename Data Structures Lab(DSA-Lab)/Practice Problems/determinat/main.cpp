#include<iostream>
#include<cmath>
using namespace std;
//Find the determinant of a matrix

int getMatrix(int matrix[100][100],int order);
int printMatrix(int matrix[100][100],int order);
int determinant(int matrix[100][100],int order);

int main()
{
  int matrix[100][100],order;
  int i,j;
  cout<<"\nEnter order of matrix : ";
  cin>>order;
  getMatrix(matrix,order);
  cout<<"Enter the elements of matrix\n";
  printMatrix(matrix,order);
  cout<<"\n \n";
  cout<<"\n Determinant of Matrix A is "<<determinant(matrix,order);
  return main();
}

int determinant(int matrix[100][100],int order)
{
  int sign,det=0,newmat[100][100],c[100],j,p,q;
  if(order==1)
    return matrix[1][1];
  if(order==2)
  {
    det=0;
    det=(matrix[1][1]*matrix[2][2])-(matrix[1][2]*matrix[2][1]);
    return(det);
   }
  else
  {
    for(j=1;j<=order;j++)//j : to move along the first line
    {
      int newrow=1,newcol=1;
      for(p=2;p<=order;p++)//p : to move vertically from sec row
        {
          for(q=1;q<=order;q++)//q : to move horizontally
            {
              if(q!=j)
              {
                newmat[newrow][newcol]=matrix[p][q];
                newcol++;
                if(newcol>order-1)
                 {
                   newrow++;
                   newcol=1;
                  }
               }
             }
         }
     sign=pow(-1,j+1);     // for(t=1,sign=1;t<=(1+j);t++)
                           // sign=(-1)*sign;
     c[j]=sign*determinant(newmat,order-1);
     }
     for(j=1;j<=order;j++)
     {
       det+=(matrix[1][j]*c[j]);
      }
     return(det);
   }
}
int getMatrix(int matrix[100][100],int order)
{
    int i,j;
    cout<<"Enter the elements of matrix\n";
    for(i=1;i<=order;i++)
    {
        for(j=1;j<=order;j++)
        {
            cout<<"matrix["<<i<<"]["<<j<<"] = ";
            cin>>matrix[i][j];
        }
    }
    return matrix[100][100];
}
int printMatrix(int matrix[100][100],int order)
{
    int i,j;
    cout<<"\n\n---------- Matrix is --------------\n";
    for(i=1;i<=order;i++)
     {
          cout<<"\n";
          for(j=1;j<=order;j++)
          {
               cout<<"\t"<<matrix[i][j]<<"\t";
          }
     }
}
