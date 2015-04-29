#include <iostream>
using namespace std;
//Search for an element in an array and print its position if found else -1
int main()
{
    int size,i;
    cout<<"Enter the size of the array : ";
    cin>>size;
    int a[100];
    cout<<"Enter the values : "<<endl;
    for(int i=0;i<size;i++)
        cin>>a[i];
    cout<<"Enter the value to be searched : ";
    int item;
    cin>>item;
    int pos=-1;
    for(int i=0;i<size;i++)
        if(a[i]==item)
            pos=i;
    cout<<pos;
    return 0;
}
