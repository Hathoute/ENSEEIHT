function [X] = moduler(donnee, Ns, F0, F1, Fe)
    
    Te = 1/Fe;
    Ts = Ns*Te;
    t = [0:Te:Ts-Te];
    cos0 = cos(2*pi*t*F0);
    cos1 = cos(2*pi*t*F1);
    
    x = zeros(size(donnee, 1),size(t, 2));
    for i=1:size(donnee)
        if donnee(i) == 0
            x(i,:) = cos0';
        else
            x(i,:) = cos1';
        end
    end
    
    X = reshape(x', size(donnee, 1)*size(t, 2), 1);
end