package code;


import java.awt.event.*;


public class DragAndDrop implements MouseListener, MouseMotionListener
{
    private  int positionInitialeX;
    private int positionInitialeY;
    private FenetreDeJeu fenetre;
    private boolean enTrainTirer = false;

    public DragAndDrop(FenetreDeJeu fenetre) 
    {
        this.fenetre = fenetre;
    }

    public void mouseClicked(MouseEvent e)
    {
        //inutile dans notre code
    }

    @Override
    public void mouseReleased(MouseEvent e)
    {
        this.fenetre.relacherPiece(e.getX(), e.getY());
        enTrainTirer = false;
    }

    @Override
    public void mousePressed(MouseEvent e) {
        this.positionInitialeX = e.getX();
        this.positionInitialeY = e.getY();
        enTrainTirer = true;

        this.fenetre.appuyerSurPiece(this.positionInitialeX, this.positionInitialeY);
    }

    public void mouseEntered(MouseEvent e)
    {
        //inutile
    }

    public void mouseExited(MouseEvent e)
    {
        //inutile
    }

    @Override 
    public void mouseDragged(MouseEvent e) {
        if (this.enTrainTirer)
        {
            this.fenetre.tirerPiece(e.getX(), e.getY());
        }
        
    }

    public void mouseMoved(MouseEvent e) 
    {

    }

}


