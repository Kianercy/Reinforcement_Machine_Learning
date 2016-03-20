function qlearning
clear
%initial values
tmax=60;
%Qx=zeros(2,1);
Qx=[0;0];
%Qy=zeros(2,1);
Qy=[3;2];
rx=zeros(2,1);
ry=zeros(2,1);
Rx=zeros(2,1);
Ry=zeros(2,1);
x=zeros(tmax,2);
y=zeros(tmax,2);
alpha=0.01;
Tx=0.15;
Ty=0.15;
x0=exp(Qx(1)/Tx)/(exp(Qx(1)/Tx)+exp(Qx(2)/Tx))
y0=exp(Qy(1)/Ty)/(exp(Qy(1)/Ty)+exp(Qy(2)/Ty))
%A=[3,0;4,2];%PD
%B=[3,0;4,2];%PD
A=[3,0;1,2.5];%Coordination
%B=[4,0;3,2];%Coordination
B=A;
rep=4;


%playing
for t=1:tmax
     %update the strategeis
    repx1=0;
    repx2=0;
    repy1=0;
    repy2=0;
    x(t,1)=exp(Qx(1)/Tx)/(exp(Qx(1)/Tx)+exp(Qx(2)/Tx));
    x(t,2)=exp(Qx(2)/Tx)/(exp(Qx(1)/Tx)+exp(Qx(2)/Tx));
    y(t,1)=exp(Qy(1)/Ty)/(exp(Qy(1)/Ty)+exp(Qy(2)/Ty));
    y(t,2)=exp(Qy(2)/Ty)/(exp(Qy(1)/Ty)+exp(Qy(2)/Ty));
    rx=zeros(2,1);
    ry=zeros(2,1);
    for re=1:rep
        if rand<x(t,1)
           i=1;
           repx1=repx1+1;
        else
            i=2;
            repx2=repx2+1;
        end
        if rand<y(t,1)
           j=1;
           repy1=repy1+1;
        else
           j=2;
           repy2=repy2+1;
        end
        rx(i)=rx(i)+A(i,j);
        ry(j)=ry(j)+B(j,i);
    end
    % to avoid NAN 
    if repx1~=0
        Qx(1)=Qx(1)+alpha*((rx(1)/repx1)-Qx(1));
    end
  
    if repx2~=0
        Qx(2)=Qx(2)+alpha*((rx(2)/repx2)-Qx(2));
    end
 
    if repy1~=0
        Qy(1)=Qy(1)+alpha*((ry(1)/repy1)-Qy(1));
    end
  
    if repy2~=0
        Qy(2)=Qy(2)+alpha*((ry(2)/repy2)-Qy(2));
    end


end
figure;
time=1:tmax;
plot(time,x(:,1));
xlim([0 tmax]);
ylim([0 1]);
xlabel('Time')
ylabel('Probability of choosing action 1')
title('Agent X evolution in strategy')
% figure;
% plot(time,y(:,1))
% ylim([0 1])
% title('action1-y');

end
