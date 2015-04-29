#include <iostream>
using namespace std;
//It is known that, in an array, more than half the elements have the same value.
//Write an efficient program to find that element.
int main()
{
    int n,i;
    cout<<"Enter the size of array ";
    cin>>n;
    int *a=new int [n];
    cout<<"Enter the array elements\n";
    for(i=0;i<n;i++)
        cin>>a[i];
    int h = (n/2 + 1);
    int counts[100],k;
    for(i=0;i<n;i++)
    {
        k = a[i];
        counts[i]=0;
        for(int j=0;j<n;j++)
        {
            if(k==a[j])
                (counts[i]+=1);
        }
    }
    int value;
    for(i=0;i<n;i++)
    {
        if(counts[i]>=h)
            value=a[i];
    }
    cout<<"The number is "<<value;
    delete[] a;
    return 0;
}
