#include <iostream>
using namespace std;
//Program to find the gcd and lcm of 2 numbers

int gcd(int m,int n,int t);
int lcm(int m,int n,int t);

int main()
{
    int m,n;
    cout<<"Enter the values of m and n"<<endl;
    cin>>m>>n;
    cout<<"GCD : ";
    (m<=n)?(cout<<gcd(m,n,m)):(cout<<gcd(m,n,n));
    cout<<endl;
    cout<<"LCM : ";
    (m>=n)?(cout<<lcm(m,n,m)):(cout<<lcm(m,n,n));
    return 0;
}
int gcd(int m,int n,int t)
{
    for(int i=t;t>=1;t--)
    {
        if (m%t==0 && n%t==0)
            return t;
    }
}
int lcm(int m,int n,int t)//lcm=m*n/gcd
{
    if (m==0 || n==0)
        return 0;
    else
        for(int i=t;t<=(m*n);t++)
        {
            if (t%m==0 && t%n==0)
                return t;
        }
}

