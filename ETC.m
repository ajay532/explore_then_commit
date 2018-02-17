function [count_1,count_2,value_1,value_2,cumm_regret]=ETC(m,p1,p2)
explore_c=m;
exploit_a=1;
n_arms=2;
horizon=10000;
experiment_c=1;

prob_a=[0,0];
prob_a(1,1)=p1;
prob_a(1,2)=p2;
regret=abs(prob_a(1,1)-prob_a(1,2));
count_1=zeros(experiment_c,horizon); % store no of times each arm pulled
count_2=zeros(experiment_c,horizon);
value_1=zeros(experiment_c,horizon); % store what is the value of each arm
value_2=zeros(experiment_c,horizon);
cumm_regret=zeros(experiment_c,horizon); %store cummulative regret

for i=1:experiment_c
    for j=1:horizon
        if(j<=explore_c)
            if(j==1)
                count_1(i,j)=1;
                value_1(i,j)=binornd(1,prob_a(1,1));
            else
                count_1(i,j)=count_1(i,j-1)+1;
                value_1(i,j)=(value_1(i,j-1)*(count_1(i,j-1))+binornd(1,prob_a(1,1)))/count_1(i,j);
            end
        end
        if(j<=explore_c*n_arms && j>explore_c)
            if(j==explore_c+1)
                count_2(i,j)=1;
                value_2(i,j)=binornd(1,prob_a(1,2));
            else
                count_2(i,j)=count_2(i,j-1)+1;
                value_2(i,j)=(value_2(i,j-1)*(count_2(i,j-1))+binornd(1,prob_a(1,2)))/count_2(i,j);
            end
            count_1(i,j)=count_1(i,j-1);
            value_1(i,j)=value_1(i,j-1);
        end
        if(j==explore_c*n_arms)
            value_1(i,j),value_2(i,j)
            exploit_a=max_index(value_1(i,j),value_2(i,j));
        end
        if(j>explore_c*n_arms)
            if(exploit_a==1)
                count_1(i,j)=count_1(i,j-1)+1;
                value_1(i,j)=(value_1(i,j-1)*(count_1(i,j-1))+binornd(1,prob_a(1,1)))/count_1(i,j);
                count_2(i,j)=count_2(i,j-1);
                value_2(i,j)=value_2(i,j-1);
            else
                count_2(i,j)=count_2(i,j-1)+1;
                value_2(i,j)=(value_2(i,j-1)*(count_2(i,j-1))+binornd(1,prob_a(1,2)))/count_2(i,j);
                count_1(i,j)=count_1(i,j-1);
                value_1(i,j)=value_1(i,j-1);
            end
        end
        cumm_regret(i,j)=regret*count_2(i,j);
        %count_1(i,j)=count_1(i,j)/j;
    end
end



%function to calculate max index
function ind=max_index(v1,v2)
    if(v1>v2)
        ind=1;
        return ;
    else
        ind=2;
        return;
    end
end
 
end

                
