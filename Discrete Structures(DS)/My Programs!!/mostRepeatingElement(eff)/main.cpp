#include<iostream>
using namespace std;

int find_majority_element(int arr[],int n)
{
int i,count=1,key=arr[0];
for(i=0;i<n;i++)
{
    if(arr[i]==key)
        count++;
    else
        count--;
    if(count==0)
    {
        key=arr[i];
        count=1;
    }
}
return key;
}
int main()
{
int n,i;
cout<<"Enter the number of elements in the array : ";
cin>>n;
int *arr=new int [n];
cout<<"Enter array elements\n";
for(i=0;i<n;i++)
    cin>>arr[i];
cout<<"Majority element = \n"<<find_majority_element(arr ,n);
delete[] arr;
return 0;
}
