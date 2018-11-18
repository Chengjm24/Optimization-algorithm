function result=fitness(X)
n=30;
sum=0;
for i=1:n
    sum=sum+(X(i)^2-10*cos(2*pi*X(i))+10);
end
result=sum;