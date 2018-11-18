clc;
clear all;
format long;
N=100;
n=30;
MaxDT=100;
X=zeros(N,n);
X_new1=zeros(N,n);
X_new2=zeros(N,n);
X_new3=zeros(N,n);
X_new4=zeros(N,n);
mu=zeros(1,n);
A=zeros(1,N);
A1=zeros(1,N);
A2=zeros(1,N);
diff_mean=zeros(1,n);
Xmin=ones(1,n)*-5.12;
Xmax=ones(1,n)*5.12;

for i=1:N
	for j=1:n
		X(i,j)=Xmin(j)+rand*(Xmax(j)-Xmin(j));
	end
end

for t=1:MaxDT
	for i=1:N
		A(i)=fitness(X(i,:));
	end
	[b,c]=sort(A);
	teacher=X(c(1),:);

	for j=1:n
		mu(j)=mean(X(:,j));
	end
	
	for i=1:N
		tf=randi(2,1,1);
		diff_mean=rand*(teacher-tf*mu);
		X_new1(i,:)=X(i,:)+diff_mean;
		A1(i)=fitness(X_new1(i,:));
	end
	
	for i=1:N
		if A1(i)>A(i)
			X_new2(i,:)=X(i,:);
		else 
			X_new2(i,:)=X_new1(i,:);
		end
	end
	
	for i=1:N
		A2(i)=fitness(X_new2(i,:));
	end
%Learner phase
	i=randi(N,1,1);
	j=randi(N,1,1);
	if(i==j)
		 j=randi(N,1,1);
    end
	
    for i=1:N
		if A2(i)<A2(j)
			X_new3(i,:)=X_new2(i,:)+rand*(X_new2(i,:)-X_new2(j,:));
		else
			X_new3(i,:)=X_new2(i,:)+rand*(X_new2(j,:)-X_new2(i,:));
        end
    end
	
	for i=1:N
		A3(i)=fitness(X_new3);
	end
    
	for i=1:N
       if A3(i)<A2(i)
           X_new4(i,:)=X_new3(i,:);
	   else
           X_new4(i,:)=X_new2(i,:);
       end
    end
	
	for i=1:N
		A4(i)=fitness(X_new4(i,:));	
    end
	X=X_new4;			
end	

[b3,c3]=sort(A4);
Xopt=X_new3(c3(1),:);
Fmin=b3(1);
disp 'minimum';Fmin
disp 'design point';Xopt
	
	