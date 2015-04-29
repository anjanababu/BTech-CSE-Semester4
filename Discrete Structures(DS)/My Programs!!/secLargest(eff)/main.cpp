#include <iostream>

using namespace std;

int main()
{
    cout<<"Enter the number of elements of the array : ";
    int n,i;
    cin>>n;
    int mid=n/2;
    int *a=new int [n];
    cout<<"Enter the values of the array\n";
    for(i=0;i<n;i++)
        cin>>a[i];
    int lmax=a[0];
    int rmax=a[mid];
    int temp;
    for(i=1;i<mid;i++)
    {
        if(a[i]>lmax)
            lmax=a[i];
        else
        {
            temp=a[i];
            a[i]=a[i-1];
            a[i-1]=temp;
        }
    }
    for(i=(mid+1);i<n;i++)
    {
        if(a[i]>rmax)
            {
                rmax=a[i];
            }
        else
        {
            temp=a[i];
            a[i]=a[i-1];
            a[i-1]=temp;
        }

    }

    if(lmax>rmax)
    {
        for(i=0;i<(mid-1);i++)
        {
            if(a[i]>rmax)
                rmax=a[i];
        }
        cout<<"Second Largest is : "<<rmax<<endl;
    }
    else
    {
        for(i=mid;i<(n-1);i++)
        {
            if(a[i]>lmax)
                lmax=a[i];
        }
        cout<<"Second Largest is : "<<lmax<<endl;
    }


    delete[] a;
    return main();
}
