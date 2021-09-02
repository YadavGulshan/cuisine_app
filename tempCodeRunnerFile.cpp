#include <iostream>
#include<vector>

using namespace std;

void func(int a[],int sum,vector<int> &ans,int i,int n,int j)
{
   if(j==n)
   {
        if(sum==0) 
         {
            for(auto it : ans)
              cout<<it<<" ";
         } 
         cout<<endl;
     return ;
    }
    
    
    ans.push_back(a[i]);
    func(a,sum-a[i],ans,i,n,j+1);
    
    
    ans.pop_back();
    func(a,sum,ans,i+1,n,j+1);
    
}

int main()
{
  int a[5]={1,2,3,4,5};
  vector<int> ans;
  int sum;
  cin>>sum;
  int n=sizeof(a)/sizeof(int); // 20 /4 = 5
  func(a,sum,ans,0,n,0); // sum, ans, 0, 5, 0
}