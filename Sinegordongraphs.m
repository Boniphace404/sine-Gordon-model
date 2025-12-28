%figure 1, potential
xs = -(2*pi+pi/10):pi/100:(2*pi+pi/10);
fun = @(x) 1-cos(x);
figure;
plot(xs, fun(xs), LineWidth=2);
xlabel('$\phi$',Interpreter='latex', FontSize=16);
ylabel('$U(\phi)$', Interpreter='latex',FontSize=16);
grid on
axis([-(2*pi+pi/10) (2*pi+pi/10) -0.2 2])

hold on
plot(-2*pi, 0, 'ro', MarkerSize=8, MarkerFaceColor='r');
plot( 2*pi, 0, 'ro', MarkerSize=8, MarkerFaceColor='r');
plot( 0, 0, 'ro', MarkerSize=8, MarkerFaceColor='r');
text( -2*pi+0.6, -0.1, '$\phi = -2\pi$', HorizontalAlignment='center', Interpreter='latex',FontSize=15);
text( 2*pi-0.5, -0.1, '$\phi =  2\pi$', HorizontalAlignment='center',Interpreter='latex',FontSize=15);
text( 0, -0.1, '$\phi =  0$', HorizontalAlignment='center',Interpreter='latex',FontSize=15);
hold off




%figure 2, static kink
xs = -4:0.01:4;
fun = @(x) 4*atan(exp(x));
figure;
plot(xs, fun(xs), linewidth=2);
ylabel('$\phi$',Interpreter='latex', FontSize=16);
xlabel('$x$',Interpreter='latex', FontSize=16);
grid on

hold on
plot([-4, -2], [0.03, 0.03], 'r--', LineWidth=2);
text(-1.5, 0.3, '$\phi \rightarrow 0$', HorizontalAlignment='center',fontsize=15, Interpreter='latex');
plot([ 2, 4], [ 2*pi, 2*pi], 'r--', LineWidth=2);
text( 1.5,  6.3, '$\phi \rightarrow  2\pi$', HorizontalAlignment='center',fontsize=15, Interpreter='latex');
hold off




%figure 3, static antikink
xs = -4:0.01:4;
fun = @(x) 4*atan(exp(-x))-2*pi;
figure;
plot(xs, fun(xs), linewidth=2);
ylabel('$\phi$',Interpreter='latex', FontSize=16);
xlabel('$x$',Interpreter='latex', FontSize=16);
grid on

hold on
plot([-4, -2],[ -0.03, -0.03], 'r--', LineWidth=2);
text(-1.5, -0.3, '$\phi \rightarrow 0$', HorizontalAlignment='center',fontsize=15, Interpreter='latex');
plot([ 2, 4], [-2*pi,-2*pi] , 'r--', LineWidth=2);
text( 1.5,  -6.3, '$\phi \rightarrow  2\pi$', HorizontalAlignment='center',fontsize=15, Interpreter='latex');
hold off