function x=motionModel(xprev,u,alphas,w,h)

% x_vt=motionModel(x_vtminus1,u_vt,alphas)
%
% returns a sample x ~ p(x_t | u_t, x_{t-1}) using parameters alphas
%
% xv_tminus1 : 3xN matrix with each column being
%         (x_tminus1,y_tminus1,theta_tminus1)
% uv_t       : 6x1 matrix with the column being
%         (x_tminus1_odo,y_tminus1_odo,theta_tminus1_odo,x_t_odo,y_t_odo,theta_t_odo)
% alphas     : 4x1 vector of parameters that control probability distribution

u=repmat(u,1,size(xprev,2));

uprev=u(1:3,:);
u=u(4:6,:);

delrot1=atan2(u(2,:)-uprev(2,:),u(1,:)-uprev(1,:))-uprev(3,:);
deltrans=sqrt( (u(1,:)-uprev(1,:)).^2 + (u(2,:)-uprev(2,:)).^2 );
delrot2=u(3,:)-uprev(3,:)-delrot1;

delhatrot1=delrot1-sampleNormalDistribution(alphas(1)*delrot1+alphas(2)*deltrans);
delhattrans=deltrans-sampleNormalDistribution(alphas(3)*deltrans+alphas(4)*(delrot1+delrot2));
delhatrot2=delrot2-sampleNormalDistribution(alphas(1)*delrot2+alphas(2)*deltrans);

x=zeros(3,size(xprev,2));
x(1,:)=xprev(1,:)+delhattrans.*cos(xprev(3,:)+delhatrot1);
x(2,:)=xprev(2,:)+delhattrans.*sin(xprev(3,:)+delhatrot1);
x(3,:)=xprev(3,:)+delhatrot1+delhatrot2;

x(1,x(1,:)<1)=1;  x(1,x(1,:)>w)=w;
x(2,x(2,:)<1)=1; x(2,x(2,:)>h)=h;

end