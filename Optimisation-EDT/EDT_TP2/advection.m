function advection(scheme,Nt,Nx)
% Script calculant une approximation de la solution du problème 
% d'advection linéaire 1D.
% 
%  Inputs
%  ------
%
% scheme : schéma numérique à utiliser. 
%
% Nt : nombre de pas de temps.
%
% Nx: nombre de pas d'espace.
%
% Exemple: advection('LaxWendroff',200,500);


% Cadre experimental
a=1.; % vitesse
L=3; % longueur du domaine spatial.
T=1; % longueur de la fenêtre temporelle.
ic=1; % condition initiale : 0 -> porte, sinon densité gaussienne 

% Définition de la grille
dx=L/(Nx+1);
dt=T/(Nt+1);
xx=0:Nx+1;
xx=xx';
%dt=dx/a;

% Nombre de Courant 
lambda=a*dt/dx;

% Condition initiale
u0=zeros(Nx+2,1);
u0=reference(ic,lambda,Nx,dx,0);
rmse=zeros(Nt+1,1);

% Boucle temporelle
uh=u0;

for k=1:Nt+1
  
  % intérieur du domain
  switch scheme
      case "Explicite"
          uh(2:Nx+1) = (1-lambda)*uh(2:Nx+1) + lambda*uh(1:Nx);
      case "Implicit"
          A = spdiags([-lambda/2*ones(Nx+2,1),ones(Nx+2,1),lambda/2*ones(Nx+2,1)], [-1,0,1], Nx+2, Nx+2);
          uh = A\uh;
      case "LaxWendroff"
          uh(2:Nx+1) = uh(2:Nx+1) - lambda/2*(uh(3:Nx+2)-uh(1:Nx)) ...
                + lambda^2/2*(uh(3:Nx+2) - 2*uh(2:Nx+1) + uh(1:Nx));
      otherwise
          return
  end
  
  % Conditions aux limites
  uh(1) = 0;
  uh(Nx+2) = 0;
  
  %Erreur RMS
  uref=reference(ic,lambda,Nx,dx,k);
  rmse(k)=norm(uh-uref,2)/norm(uref,2);
   
  % Affichage de la solution
  figure(1)
  plot(dx*xx,uh,'b-',dx*xx,uref,'r-');
  axis([0 L -1 max(abs(u0))+1]);
  legend('Solution numerique','Solution de reference');
  xlabel('Domaine spatial')
  ylabel('u')
  pause(0.1);  
end
  
  % Affichage de l'erreur RMS 
  figure(2)
  plot(rmse);
  legend('Erreur RMS')

end
