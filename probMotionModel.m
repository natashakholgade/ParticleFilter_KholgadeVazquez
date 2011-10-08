function p=probMotionModel(x,u,xprev,alphas)

% p=probMotionModel(x_vt,u_vt,x_vtminus1,alphas)
%
% gives the p(x_t | u_t, x_{t-1}) using parameters alphas
%
% xv_t       : 3xN matrix with each column being (x_t,y_t,theta_t)'.
% uv_t       : 6xN matrix with each column being
%         (x_tminus1_odo,y_tminus1_odo,theta_tminus1_odo,x_t_odo,y_t_odo,theta_t_odo)
% xv_tminus1 : 3xN matrix with each column being
%         (x_tminus1,y_tminus1,theta_tminus1)
% alphas     : 4x1 vector of parameters that control probability distribution

u=repmat(u,1,size(x,2));

uprev=u(1:3,:);
u=u(4:6,:);

delrot1=atan2(u(2,:)-uprev(2,:),u(1,:)-uprev(1,:))-uprev(3,:);
deltrans=sqrt( (u(1,:)-uprev(1,:)).^2 + (u(2,:)-uprev(2,:)).^2 );
delrot2=u(3,:)-uprev(3,:)-delrot1;

delhatrot1=atan2(x(2,:)-xprev(2,:),x(1,:)-xprev(1,:))-xprev(3,:);
delhattrans=sqrt( (x(1,:)-xprev(1,:)).^2 + (x(2,:)-xprev(2,:)).^2 );
delhatrot2=x(3,:)-xprev(3,:)-delhatrot1;

p1=probNormalDistribution(delrot1-delhatrot1,alphas(1)*delhatrot1+alphas(2)*delhattrans);
p2=probNormalDistribution(deltrans-delhattrans,alphas(3)*delhattrans+alphas(4)*(delhatrot1+delhatrot2));
p3=probNormalDistribution(delrot2-delhatrot2,alphas(1)*delhatrot2+alphas(2)*delhattrans);

p=exp(log(p1)+log(p2)+log(p3));

end