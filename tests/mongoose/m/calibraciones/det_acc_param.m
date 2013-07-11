global am at

close all
%clear all
clc

g=9.81;
am = zeros(3,27);
at = zeros(3,27);
te = zeros(27,1);

k=0;
for i=1:3
    if i==1
        eje='x';
        otro='z';
    elseif i==2
        eje='y';
        otro='x';
    else
        eje='z';
        otro='y';
    end
    for j=1:5
        if j==1
           theta='00';
        elseif j==2
            theta='10';
        elseif j==3;
            theta='20';
        elseif j==4
            theta='30';
        else
            theta='45';
        end        
        for z=1:2
            if z==1 
                phi='00';
                k=k+1;
                 
            elseif z==2 && strcmp(theta,'00')
            else
                phi='45';
                 k=k+1; 
            end
            str=['./tests/mongoose/acc/logs_zparriba/' eje phi otro theta '.txt'];
            [a,w,c,t,b]=mong_read(str,0);
            te(k,1) = mean(t);
            am(:,k)=[mean(a(:,1)); mean(a(:,2));mean(a(:,3))];
            at(:,k)=acc_teo(eje,theta,phi);  
        end
    end
end

T_0 = mean(te/10);

%% Verificaciones
ataux = at;
amaux = am;

atverificacion = [];
amverificacion = [];

atminimizacion = [];
amminimizacion = [];
for i = 1:27;
    if mod(i,2)==0
        atverificacion = [atverificacion, ataux(:,i)];
        amverificacion = [amverificacion, amaux(:,i)];
        
    else
        atminimizacion = [atminimizacion, ataux(:,i)];
        amminimizacion = [amminimizacion, amaux(:,i)];
    end
end

at = atminimizacion;
am = amminimizacion;
%Aceleraciones teóricas
% at1 = at(:,1);
% at(:,1)=[];
% at2 = at(:,13);
% at(:,13)=[];
% at3 = at(:,21);
% at(:,21)=[];    
%Aceleraciones medidas
%am1 = am(:,1);
%am(:,1)=[];
%am2 = am(:,13);
%am(:,13)=[];
%am3 = am(:,21);
%am(:,21)=[];    

%% La majuga

x0=[1/(3.9e-3*g) 1/(3.9e-3*g) 1/(3.9e-3*g) 0 0 0 0 0 0 0 0 0];

[X,RESNORM,RESIDUAL,EXITFLAG]=lsqnonlin(@acc_cost,x0,[],[],optimset('MaxFunEvals',10000));

u=mean((RESIDUAL))
%sigma=sqrt(RESNORM/(length(a(1,:))-1));
sigma=std(RESIDUAL)

save('acc','X','sigma','T_0')

%% Verificación
K = [ X(1) 0 0;
    0 X(2) 0 ;
    0 0 X(3)];

b = [X(4); X(5); X(6)];

T = [1 -X(7) X(8);
    X(9) 1 -X(10);
    -X(11) X(12) 1];

for i =0:length(atverificacion)-1
    error(3*i+1:3*i+3) = atverificacion(:,i+1)-T*(K^(-1))*(amverificacion(:,i+1)-b);
end
 

