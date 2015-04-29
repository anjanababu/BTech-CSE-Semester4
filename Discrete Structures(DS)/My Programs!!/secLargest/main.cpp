#include <iostream>
using namespace std;
//Find second largest element in an array

int main()
{
    int n,i;
    cout<<"Enter the number of elements in the array : ";
    cin>>n;
    int *a=new int [n];
    cout<<"Enter the elements of the array\n";
    for(i=0;i<n;i++)
    {
        cin>>a[i];
    }
    int max,smax;
    if(a[0]>a[1])
        max=a[0];
    else
        smax=a[1];
    for(i=2;i<n;i++)
    {
        if(a[i]>max)
        {
            smax=max;
            max=a[i];
        }
        else if(a[i]>=smax && a[i]<max)
            smax=a[i];
    }
    cout<<"Second Largest is : "<<smax<<endl;
    delete[] a;
    return main();
}
