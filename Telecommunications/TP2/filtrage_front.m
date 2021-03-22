function x = filtrage_front(Suite_diracs, Ns)

    h = [ones(1, floor(Ns/2)) -ones(1, ceil(Ns/2))];
    x = filter(h, 1, Suite_diracs);
    
end