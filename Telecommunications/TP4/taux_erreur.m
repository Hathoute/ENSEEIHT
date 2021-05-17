function err = taux_erreur(bits_original, bits_calcule)

    err = 1 - sum(bits_original == bits_calcule)/length(bits_original);

end