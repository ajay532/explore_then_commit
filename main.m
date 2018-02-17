m=2000;
p1=0.9;
p2=0.6;

[count_1,count_2,value_1,value_2,cumm_regret]=ETC(m,p1,p2);
%%%%%%%%%%%%%%%%%%%%%plot for optimal arm %
y=zeros(1,100);
x = 1:100:10000;
%y = count_1(1,:);
j=0;
for i=1:100:10000
    j=j+1;
   y(1,j)=(count_1(1,i)*100)/i;
end
err=0.00001*ones(1,100);

errorbar(x,y,err, 'vertical')
hold on
title('plot between optimal arm % vs total arm pulled')
xlabel('total arm pulled') % x-axis label
ylabel('optimal arm percentage') % y-axis label
legend('m=240','m=500', 'm=1000', 'm=2000');
hold off;

m=2000;
p1=0.9;
p2=0.6;

[count_1,count_2,value_1,value_2,cumm_regret]=ETC(m,p1,p2);

%%%%%%%%%%%%%%%%%%%%%plot for cummulative regret
y=zeros(1,100);
x = 1:100:10000;
%y = count_1(1,:);
j=0;
for i=1:100:10000
    j=j+1;
   y(1,j)=cumm_regret(1,i);
end
err=0.00001*ones(1,100);
errorbar(x,y,err)
hold on
title('plot between total regret vs total arm pulled')
xlabel('total arm pulled') % x-axis label
ylabel('Total regret') % y-axis label
legend('m=240','m=500', 'm=1000', 'm=2000');
hold off;


