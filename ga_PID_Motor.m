% Programmed by   : Huynh Thai Hoang, University of Technology at Ho Chi Minh City.
% Last updated    : November 25, 2005

clc;
clear all
rand('state',sum(100*clock));

max_generation=200;
max_stall_generation=50;
epsilon=10^(-6);

pop_size= 20; %kich thuoc quan the
npar = 3; %so tham so [Kp, Ki, Kd]
range=[ 0 0 0;...   %gia tri min cua cac tham so
       10 10 10];     %gia tri max cua tham so

dec=[2 2 2];   % vi tri dau cham thap phan
sig=[5 5 5];   % so chu so co nghia

cross_prob = 0.9; %xac xuat lai ghep
mutate_prob = 0.1; % xac suat dot bien
elitism = 1;       % bao toan ca the tot nhat trong quan the

rho=0.02;

par=Init(pop_size,npar,range);

Terminal=0;
generation = 0;
stall_generation=0;
Ts = 1e-4;
%%
for pop_index=1:pop_size, %vong lap danh gia do thich nghi
    
    %%
    Kp=par(pop_index,1);  % cua quan the ban dau
    Ki=par(pop_index,2);
    Kd=par(pop_index,3);
    out = sim('DC_motor.slx');
    J=((out.e'*out.e)+rho*(out.u'*out.u))*Ts;
    fitness(pop_index)=1/(J+eps);
    %%
end;
[bestfit0,bestchrom]=max(fitness);

Kp0=par(bestchrom,1);
Ki0=par(bestchrom,2);
Kd0=par(bestchrom,3);
J0=1/bestfit0-0.001;

Kp_ = [];
Ki_ = [];
Kd_ = [];
while ~Terminal,
    generation = generation+1;
    disp(['generation #' num2str(generation) ' of maximum ' num2str(max_generation)]);
    pop=Encode_Decimal_Unsigned(par,sig,dec);
    parent=Select_Linear_Ranking(pop,fitness,0.5,elitism,bestchrom);
    child=Cross_Twopoint(parent,cross_prob,elitism,bestchrom);
    pop=Mutate_Uniform(child,mutate_prob,elitism,bestchrom);
    par=Decode_Decimal_Unsigned(pop,sig,dec);
    
    for pop_index=1:pop_size,
        Kp=par(pop_index,1);
        Ki=par(pop_index,2);
        Kd=par(pop_index,3);
        
        out = sim('DC_motor.slx');
        J=(out.e'*out.e)*Ts+rho*(out.u'*out.u)*Ts;
        fitness(pop_index)=1/(J+eps);
    end;
    [bestfit(generation),bestchrom]=max(fitness);
    Kp_ = [ Kp_ ;par(bestchrom,1)];
    Ki_ = [ Ki_ ;par(bestchrom,2)];
    Kd_ = [ Kd_ ;par(bestchrom,3)];
    bestfit(generation)
    
    if generation == max_generation
        Terminal = 1;
    elseif generation>1,
        if abs(bestfit(generation)-bestfit(generation-1))<epsilon,
            stall_generation=stall_generation+1;
            if stall_generation == max_stall_generation, Terminal = 1;end
        else
            stall_generation=0;
        end;
    end;
    
end; %While
%%
plot(1./bestfit)
%%
figure
hold on
plot(Kp_)
plot(Ki_)
plot(Kd_)
legend('Kp', 'Ki', 'Kd');
Kp0
Ki0
Kd0
J0

Kp=par(bestchrom,1)
Ki=par(bestchrom,2)
Kd=par(bestchrom,3)
J=1/bestfit(end)
    out = sim('DC_motor.slx');






