endtime = 70;
L = 15;

dt = 1e-3;
tpoints = 0:dt:endtime;
tsize = length(tpoints);

dx = 1e-2;
xpoints = -L:dx:L;
xsize = length(xpoints);
energy=1;




function [phi, phi0] = kinksim(v, tpoints, xpoints, boundary, x0, numkinks, kinktype)

    endtime = tpoints(end);
    L = xpoints(end);
    dt = tpoints(2) - tpoints(1);
    dx = xpoints(2) - xpoints(1);
    tsize = length(tpoints);
    xsize = length(xpoints);

    %Parameters
    %boundary = 'p'; % d for Dirichlet, n for Neumann, p for wave-preserving

    energy  = 1;% an 'energy' parameter. e = 1 gives travelling waves; e > 1 gives radiation                
    lorentz = 1 / sqrt(1 - v^2);

    if numkinks == 1
        initsol = @(x,t) 4 * atan( exp( lorentz * (energy*x + x0 - v*t) ) );
    end

    if numkinks == 2
        if strcmp(kinktype, 'antikink')
            initsol = @(x,t) 4 * atan( exp( lorentz * (energy*x + x0 - v*t) ) ) - 4 * atan( exp( lorentz * (energy*x - x0 + v*t) ) );
        end
        if strcmp(kinktype, 'kink')
            initsol = @(x,t) 4*atan( exp(lorentz *(energy*x + x0 - v*t))) + 4 * atan( exp( lorentz * (energy*x - x0 + v*t))) - 2*pi;
        end
    end

    phi = NaN(xsize+2, tsize); %Initialise matrix to store evolution of system
    phi(2:end-1,1) = initsol(xpoints,0);
    phi(2:end-1,2) = initsol(xpoints,dt);
    phi(1,1)   = phi(2,1);
    phi(end,1) = phi(end-1,1);
    phi(1,2)   = phi(2,2);
    phi(end,2) = phi(end-1,2);


    for t = 2:tsize-1

        phi(2:end-1,t+1) = (dt/dx)^2 .* (phi(3:end,t) - 2*phi(2:end-1,t) + phi(1:end-2,t)) - dt^2 .* sin(phi(2:end-1,t))+ 2*phi(2:end-1,t) - phi(2:end-1,t-1);

        switch boundary
            case 'd'   % Dirichlet
                phi(1,t+1)   = 0;
                phi(end,t+1) = 0;

            case 'n'   %Neumann
                phi(1,t+1)   = phi(2,t+1);
                phi(end,t+1) = phi(end-1,t+1);

            case 'p'    % Wave-preserving
                phi(1,t+1) = phi(1,t) + (phi(3,t+1) - phi(2,t+1))*(dt/dx);
                phi(end,t+1) = phi(end,t) - (phi(end-1,t+1) - phi(end-2,t+1))*(dt/dx);
        end
    end


    midpt = round(xsize/2);%Record midpoint movement to check total 'bounces' for different v
    phi0 = phi(midpt,:);

    finalTime = tsize;
end

%Test simple kink for error values
vtest = 0.25;
lorentztest = 1 / (sqrt(1 - vtest^2));
x0test = 0;
kink1 = @(x, t) tanh(lorentztest*(x + x0test - vtest*t));

%Display a color plot of the current kink collision

%testvelocities = [0.1, 0.2, 0.3]; %kinkkink
testvelocities = [0.0001, 0.1, 0.3]; %kinkantikink

%Values to sample from the matrix for fast plotting
tlongstep = round(1/dt);
xlongstep = round(1/dx);

endtime = 70;
L = 15;

figure
tiledlayout(1,3,TileSpacing='compact',Padding='loose')

for i = 1:3
    nexttile
    phi = kinksim(testvelocities(i), tpoints, xpoints, 'p', 5, 2, 'antikink');
    phi_trange = 1:tlongstep:endtime/dt;
    phi_xrange = 1:xlongstep:xsize;
    condensedphi = phi(phi_xrange, phi_trange);
    s = pcolor(1:endtime, -L:L, condensedphi);
    s.FaceColor = 'interp';
    s.LineWidth = 0.5;
    set(s,'EdgeColor','none')
    clim([-2*pi 2*pi])
    title(['$v = ', num2str(testvelocities(i)), '$'],fontsize=16, Interpreter='latex')
    xlabel('$t$',Interpreter='latex', FontSize= 16)
    if i == 1
        ylabel('$x$',Interpreter='latex', fontsize= 16)
    else
        yticklabels({})
    end
    axis square
end

colorbar(gca,'TickLabelInterpreter','latex')
%exportgraphics(gcf, 'sineGordon_kinkantikink.png', 'Resolution', 300);