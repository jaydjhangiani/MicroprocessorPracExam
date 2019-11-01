#include<stdio.h>
void main(){
	int c,n;
	do{
	printf("Enter value of cursor : ");
	scanf("%d",&c);
	printf("\nEnter Choice : \n1.Increment \n2.Decrement \n3.Exit \n");
	scanf("%d",&n);
	switch(n){
		case 1:
		asm mov cx,c;
		asm mov ah,01h;
		asm inc cl;
		asm int 10h;
		printf("\n\n\n");
		break;

		case 2:
		asm mov cx,c;
		asm mov ah,01h;
		asm dec cl;
		asm int 10h;
		printf("\n\n\n");
		break;

		case 3:
		asm mov ah,01h;
		asm int 10h;
		break;
	}
	}while(n!=3);
	getch();
}