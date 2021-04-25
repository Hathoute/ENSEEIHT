import com.sun.org.apache.xpath.internal.operations.Bool;

import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;

public class Utils {

    private static final String resourcesPath = System.getProperty("java.io.tmpdir") + "Jeu-De-Role";
    private static final File resourcesDir = new File(resourcesPath);

    //region PDF
    public static Boolean sauvegarderCarte(JFrame parent, JPanel panel) {
        JFileChooser chooser = new JFileChooser();
        chooser.setDialogTitle("Choisir l'emplacement de sauvegarde");
        FileNameExtensionFilter filter =
                new FileNameExtensionFilter("Image (jpg seulement)", "jpg");
        chooser.setFileFilter(filter);

        if (chooser.showSaveDialog(parent) != JFileChooser.APPROVE_OPTION) {
            return false;
        }

        File dest = chooser.getSelectedFile();
        BufferedImage panelImg = convertirPanel(panel);
        try {
            ImageIO.write(panelImg, "jpg", dest);
        } catch (IOException e) {
            return false;
        }

        return true;
    }

    private static BufferedImage convertirPanel(JPanel panel) {
        BufferedImage img = new BufferedImage(
                panel.getWidth(),
                panel.getHeight(),
                BufferedImage.TYPE_INT_RGB);
        Graphics2D g = img.createGraphics();
        panel.paint(g);
        g.dispose();
        return img;
    }
    //endregion

    //region Image
    public static ImageIcon telechargerImage(JFrame parent) {
        File file = chooseFile(parent);
        if (file == null)
            return null;

        return loadImage(file);
    }

    private static File chooseFile(JFrame parent) {
        JFileChooser chooser = new JFileChooser();
        FileNameExtensionFilter filter =
                new FileNameExtensionFilter("Images", "png", "jpg", "jpeg", "gif");
        chooser.setFileFilter(filter);
        if (chooser.showOpenDialog(parent) == JFileChooser.APPROVE_OPTION) {
            return chooser.getSelectedFile();
        }

        return null;
    }

    private static ImageIcon loadImage(File file) {
        return new ImageIcon(file.getAbsolutePath());
    }
    //endregion

    //region Sauvegarde
    private static Boolean saveImage(File file, int id) {
        resourcesDir.mkdirs();

        String nom = id + ".img";
        Path dest = resourcesDir.toPath().resolve(nom);
        try {
            Files.copy(file.toPath(), dest, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            return false;
        }

        return true;
    }

    private static ImageIcon loadImage(int id) {
        String nom = id + ".img";
        Path src = Paths.get(resourcesPath).resolve(nom);
        return loadImage(src.toFile());
    }
    //endregion
}