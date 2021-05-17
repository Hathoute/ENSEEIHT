function x = filtrage_rect(Suite_diracs, Ns)

    h = ones(1, Ns);
    x = filter(h, 1, Suite_diracs);
    
end