function x = filtrage_rcos(Suite_diracs, Ns)

    ls = length(Suite_diracs);
    h=rcosdesign(0.7,floor(ls/Ns)+1,Ns);
    Suite_diracs = [Suite_diracs; zeros(floor(ls/2),1)];
    x = filter(h, 1, Suite_diracs);
    x = x(floor(ls/2)+1:end);
    
end