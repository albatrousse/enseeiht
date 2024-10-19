package code;

import javax.swing.*;
import java.awt.*;

public class BullesChat {

	private JFrame frame;

	public BullesChat(int nivCoup) {

		JPanel bulleChat = new JPanel();
		bulleChat.setLayout(new BoxLayout(bulleChat, BoxLayout.Y_AXIS));

		JLabel nomIA = new JLabel("Adversaire");
		nomIA.setAlignmentX(Component.LEFT_ALIGNMENT);
		bulleChat.add(nomIA);

		JTextArea message = new JTextArea("");
		if (nivCoup == 0) {
			message = new JTextArea("Votre coup est à améliorer");
		} else if (nivCoup == 1) {
			message = new JTextArea("Excellent !");
		}
		message.setEditable(false);
		message.setAlignmentX(Component.LEFT_ALIGNMENT);
		bulleChat.add(message);

		this.frame = new JFrame();
		frame.setLayout(new BorderLayout());
		frame.add(bulleChat, BorderLayout.NORTH);
		frame.setSize(300, 100);
		frame.setVisible(true);

	}

	public void Fermer () {
		this.frame.dispose();
	}

}
