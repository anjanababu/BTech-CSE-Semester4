#include <iostream>
#include <stdio.h>
#include <string.h>
/*Given two strings s1 and s2, the relation alike is defined as follows
S1 and s2 are alike if they are of the same length and differ in zero, one or two places only.
For example, xyz and xab are alike, but xywz and xabw are not alike, zab and xa are not alike.*/
using namespace std;
int spaces(char s[350]);
int main()
{
    cout <<"\nEnter 2 strings\n";
    char s1[350],s2[350];
    gets(s1);
    gets(s2);
    int i=0,j=0,flag1=0,flag2=0,count=0;
    int sp1,sp2;
    sp1=spaces(s1);
    sp2=spaces(s2);
    if(sp1!=sp2)
        cout<<"\nInput length doesnt match\n";
    else
    {
        while(s1[i]!='\0' || s2[j]!='\0')//till end of any sentence(string)
        {
            if(s1[i]==' ' && s2[j]==' ' && count<=2 && flag1==flag2)//if alike
            {
                count=0;
                cout<<"1";
            }
            else if(count>2)//not alike
            {
                cout<<"0";
                count=0;
                flag1=0;
                flag2=0;
                while(s1[i]!=' ')
                    i++;
                while(s2[j]!=' ')
                    j++;
            }
            else if(count<=2)//check not over
            {
                if(s1[i]==' ' || s1[i]=='\0')
                {
                    flag1--;
                    i--;
                }
                if(s2[j]==' ' || s2[j]=='\0')
                {
                    flag2--;
                    j--;
                }
                if(s1[i]!=s2[j])
                    count++;
                flag1++,flag2++;
            }
            i++,j++;
        }
        if(count<=2 && flag1==flag2)//after the loop terminate for the alikness of last word
            cout<<"1";
        else
            cout<<"0";
    }
    return 0;
}
//To calculate number of words in a given string...indirectly calculating number of spaces...
//n(words)=n(spaces)+1
int spaces(char s[350])
{
    int key=0,i=0;
    while(s[i]!='\0')
        {
            if(s[i]==' ')
                key++;
            i++;
        }
    return key;
}
