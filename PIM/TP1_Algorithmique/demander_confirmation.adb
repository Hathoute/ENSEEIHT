with Ada.Text_IO;          use Ada.Text_IO;

-- Demander confirmation par 'o' ou 'n'.
procedure Demander_Confirmation is
	Reponse: Character;	-- la réponse de l'utilisateur
begin
	-- Demander la réponse

    Put("Confirmation (o/n) ? ");
    Get(Reponse);
    while Reponse /= 'o' and Reponse /= 'n' loop
        Put_Line("Merci de répondre par 'o' (oui) ou 'n' (non).");
        Put("Confirmation (o/n) ?");
        Get(Reponse);
    end loop;

	-- Afficher la réponse
	Put (Reponse);
end Demander_Confirmation;
