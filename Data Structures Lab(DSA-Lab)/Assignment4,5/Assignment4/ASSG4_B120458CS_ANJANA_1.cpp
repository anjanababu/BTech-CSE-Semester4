#include<iostream>
#include<fstream>
#include<stdlib.h>
using namespace std;

struct Node{
	int key;
	Node* parent;
	Node* left;
	Node* right;
};
/*Initial BST is empty*/
Node* root=NULL;

void insert(Node* &root,Node* element);
Node* search(Node* root,int k);
Node* findMin(Node* root);
Node* findMax(Node* root);
Node* predecessor(Node* root,Node* element);
Node* successor(Node* root,Node* element);
void deletee(Node* &root,Node* element);
void transplant(Node* &root,Node* &u,Node* &v);
void inorder(Node* root);
void preorder(Node* root);
void postorder(Node* root);


int main(){
	cout<<"Enter the filename : ";
	char fname[66];
	cin>>fname;
	
	
	int ch,data,k;
	Node* element=new Node;
	Node* result;
	Node* results;
	Node* resultp;

	ifstream myfile(fname);
	if(myfile.good()){
		myfile>>ch;
		while(myfile.good()){
			switch(ch){	
			case 0: cout<<"Program terminated manually...\n";
				myfile.close();
				exit(0);
				break;
			case 1: myfile>>element->key;
				if(element->key>=0)
					insert(root,element);
				else
					cout<<"INVALID INPUT\n";
				break;
			case 2: myfile>>k;
				result = search(root,k);
				if(result != NULL)
					cout<<"FOUND\n";
				else
					cout<<"NOT FOUND\n";
				break;
			case 3:	result = findMin(root);
				if(result != NULL)
					cout<<result->key<<"\n";
				else
					cout<<"NIL\n";
				break;
			case 4: result = findMax(root);
				if(result != NULL)
					cout<<result->key<<"\n";
				else
					cout<<"NIL\n";;
				break;
			case 5: myfile>>k;
				result = search(root,k);
				if(result!=NULL){
					Node* p = result;
					resultp = predecessor(root,p);
					if(resultp!=NULL)
						cout<<resultp->key<<endl;
					else
						cout<<"NIL\n";
				}
				else
					cout<<"NOT FOUND\n";
				break;		
			case 6: myfile>>k;
				result = search(root,k);
				if(result!=NULL){
					Node* s = result;
					results = successor(root,s);
					if(results!=NULL)
						cout<<results->key<<endl;
					else
						cout<<"NIL\n";
				}
				else
					cout<<"NOT FOUND\n";
				break;	
	
			case 7: myfile>>k;
				result = search(root,k);
				if(result!=NULL){
					element = result;
					deletee(root,element);
					cout<<endl;
				}
				else	
					cout<<"ELEMENT WAS ALREADY NOT PRESENT\n";
				break;
			case 8:	inorder(root);cout<<endl;break;
			case 9: preorder(root);cout<<endl;break;
			case 10: postorder(root);cout<<endl;break;
			default:cout<<"Invalid Choice....\n";
		}	
		myfile>>ch;
	}
	}
	else
		cout<<"ERROR: Sorry!! The file cannot be opened...\n";
		
	/*Clean up*/
	return 0;
}
void insert(Node* &root,Node* element){
	Node* e = new Node;
	e->key = element->key;
	e->left = NULL;
	e->right = NULL;

	Node* x = root;//to traverse through
	Node* y= NULL;//keep track of parent

	while(x!=NULL){
		y = x;
		if(e->key < x->key)
			x = x->left;
		else x = x->right;
	}
	e->parent = y;
	if(y == NULL) //tree was initially empty
		root = e;
	else if(e->key < y->key)
		y->left = e;
	else
		y->right = e;
	cout<<endl;
}

Node* search(Node* root,int k){
	if(root == NULL or root->key==k)
		return root;
	else if(k < root->key)
		return search(root->left,k);
	else
		return search(root->right,k);
}
Node* findMin(Node* root){
	if(root == NULL or root->left == NULL)
		return root;
	else
		return findMin(root->left);
}
Node* findMax(Node* root){
	if(root == NULL or root->right == NULL)
		return root;
	else
		return findMax(root->right);
}
Node* predecessor(Node* root,Node* element){
	if(element->left != NULL)
		return findMax(element->left);
	else{
		Node* y=element->parent;
		while(y!=NULL and element == y->left){
			element=y;
			y=y->parent;
		}
		return y;
	}
}	
Node* successor(Node* root,Node* element){
	if(element->right != NULL)
		return findMin(element->right);
	else{
		Node* y=element->parent;
		while(y!=NULL and element == y->right){
			element=y;
			y=y->parent;
		}
		return y;
	}
}	
void deletee(Node* &root,Node* element){
	if(element->left == NULL)//no left tree
		transplant(root,element,element->right);
	else if(element->right == NULL)//no right tree
		transplant(root,element,element->left);
	else{ //has both left and right trees
	      //replace with the successor
		Node* y = findMin(element->right);
		if(y->parent != element){
			transplant(root,y,y->right);
			y->right = element->right;
			y->right->parent = y;
		}
		transplant(root,element,y);
		y->left = element->left;
		y->left->parent = y;
	}
}
void transplant(Node* &root,Node* &u,Node* &v){
	if(u->parent == NULL)
		root=v;
	else if(u == u->parent->left)
		u->parent->left = v;
	else
		u->parent->right = v;
	if(v != NULL)
		v->parent = u->parent;
}
void inorder(Node* root){
	if(root==NULL)
		return;
	else{
		inorder(root->left);
		cout<<root->key<<" ";
		inorder(root->right);
	}
}
void preorder(Node* root){
	if(root==NULL)
		return;
	else{		
		cout<<root->key<<" ";
		preorder(root->left);
		preorder(root->right);
	}
}
void postorder(Node* root){
	if(root==NULL)
		return;
	else{				
		postorder(root->left);
		postorder(root->right);
		cout<<root->key<<" ";
	}
}
