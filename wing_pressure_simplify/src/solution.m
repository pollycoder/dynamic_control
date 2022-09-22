% Work out resistance and moment
% Principal vector
filename = 'streamline_up.txt';                   
delimiterIn = ' ';                       
headerlinesIn =2;                        
wing_up=importdata(filename,delimiterIn,headerlinesIn);
m_wing_up = wing_up.data;
x1=m_wing_up(:,1);
y1=m_wing_up(:,2);
P=m_wing_up(:,5);
R_resi=[0,0,0];
M_resi=[0,0,0];
for i=0:length(x1)-1
     % Micro resistance
    if i==0
        dy1=-x1(i+1,1);
        dx1=y1(i+1,1);
    else
        dy1=x1(i,1)-x1(i+1,1);
        dx1=y1(i+1,1)-y1(i,1);
    end
    dPx=dx1.*P(i+1,1);
    dPy=dy1.*P(i+1,1);
    dP=[dPx,dPy,0];
    % Principal vector
    R_resi(1,1)=R_resi(1,1)+dPx;
    R_resi(1,2)=R_resi(1,2)+dPy;
    % Moment
    r=[x1(i+1,1),y1(i+1,1),0];
    dM=cross(r,dP);
    M_resi=M_resi+dM;
end

% Work out lift force and moment
% Principal vector
filename1 = 'streamline_down.txt';                                       
wing_down=importdata(filename1,delimiterIn,headerlinesIn);
m_wing_down = wing_down.data;
x1=m_wing_down(:,1);
y1=m_wing_down(:,2);
P=m_wing_down(:,5);
R_lift=[0,0,0];
M_lift=[0,0,0];
for i=0:length(x1)-1
    if i==0
        dy1=x1(i+1,1);
        dx1=-y1(i+1,1);
    % Micro lift
    else
        dy1=x1(i+1,1)-x1(i,1);
        dx1=y1(i,1)-y1(i+1,1);
    end
    dPx=dx1.*P(i+1,1);
    dPy=dy1.*P(i+1,1);
    dP=[dPx,dPy,0];
    % Principal vector
    R_lift(1,1)=R_lift(1,1)+dPx;
    R_lift(1,2)=R_lift(1,2)+dPy;
    % Moment
    r=[x1(i+1,1),y1(i+1,1),0];
    dM=cross(r,dP);
    M_lift=M_lift+dM;
end

% Total moment
M_total=M_lift+M_resi;

% Zero-moment point
R=R_lift+R_resi;
R_norm=norm(R);
M_norm=norm(M_total);
r0=M_norm./R_norm;
temp=cross(R,M_total);      % Get the orientation of the position vector
temp_norm=norm(temp);
r0_fin=r0.*temp./temp_norm;

% Output
str1=['总阻力=',num2str(R(1,1)),'(N)'];
disp(str1);
str2=['总升力=',num2str(R(1,2)),'(N)'];
disp(str2);
str3=['总力矩=',num2str(M_lift(1,3)),'(N·m)'];
disp(str3);
str4=['主矩为零点=(',num2str(r0_fin(1,1)),',',num2str(r0_fin(1,2)),',',num2str(r0_fin(1,3)),')'];
disp(str4);



