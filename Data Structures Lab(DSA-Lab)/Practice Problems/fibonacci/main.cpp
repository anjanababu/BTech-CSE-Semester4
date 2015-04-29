#include <iostream>
using namespace std;
//Program to print the fibonacci series

int main()
{
    unsigned long int n;
    cout<<"Enter the value of n "<<endl;
    cin>>n;
    int current=0;
    int previous=0;
    int next=1;
    for(int i=0;i<n;i++)
    {
        if (i==0)
            cout<<previous<<endl;
        else
            {
                cout<<next<<endl;
                previous=current;
                current=next;
                next=current+previous;

            }
    }
    return 0;
}

