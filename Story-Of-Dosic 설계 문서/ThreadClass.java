package �޸���9;
/* 2019-03-31 ~ 2019-04-03 
 *  201714284 ������
 *  https://blog.naver.com/shimchan2/70109242620 << GUI ������ ��ó
 */
import java.awt.*;
import java.awt.event.*;
import java.util.*;
public class ThreadClass {	
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int input;
		
		System.out.print("�÷��̾� ���� �Է��ϼ���(2 ~ 10) : ");
		input = sc.nextInt();
		
		while(input < 2 || input > 10) {
			System.out.print("2 ~ 10 ������ ���� �Է��ϼ��� : ");
			input = sc.nextInt();
		}
		
		Rungame frame = new Rungame(input);
		
		frame.setLocation(300, 100);
		frame.setSize(1300, 1000); //���� â ��ü ȭ�� ũ��
		frame.setVisible(true);
		frame.addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				System.exit(1);
			}
		});
	}
}
@SuppressWarnings("serial") 
class Rungame extends Frame implements ActionListener {
	int size;
	RunnerThread[] thread;
	int[] rank;
	boolean[] arrive; // 
	Button startButton = new Button("Start");
	final int LENGTH = 1000; // Ʈ������ 1000m
	//Font f;
	boolean stopFlag;
	
	// ������
	public Rungame(int size) {
		super("�޸��� ����");
		
		// �ʱ�ȭ
		this.size = size;
		thread = new RunnerThread[size];
		rank = new int[size];
		arrive = new boolean[size];
		//f = new Font("���ü", Font.PLAIN, 30); // �۾�ü ����� ���ɸ�����
		stopFlag = true;
		makeButton();
		makeThread();
	}
	
	public void makeButton() {
		setLayout(new BorderLayout());
		startButton.addActionListener(this);
		startButton.setSize(30, 20);
		Panel p = new Panel();
		add("North", p);
		p.add(startButton);
	}
	
	public void makeThread() {
		// ������ ����
		for(int i=0; i<size; i++)
			thread[i] = new RunnerThread(this, 10, (i+1)*90, 10, 50, size);
	}
	
	public void actionPerformed(ActionEvent e) {
		String str = e.getActionCommand();
		System.out.println(str);
		
		// ������ ����
		if (str.equals("Start")) {
			for(int i=0; i<size; i++)
				thread[i].start();
		}
	}
	
	public void update(Graphics g) {
		super.update(g);
	}
	
	public void paint(Graphics g) {
		// 1000m ��¼� ǥ��
		g.drawLine(LENGTH, 0, LENGTH, 1000);
		//g.setFont(f);
		
		// �÷��̾� ����
		g.setColor(Color.red);
		// �÷��̾� (�簢��) �׸� �׸���
		for(int i=0; i<size; i++)
			g.fillRect(thread[i].x, thread[i].y, thread[i].w, thread[i].h);
		
		// ��� 1~10 �Ǻ�
		for (int i=0; i<size; i++) {
			// ��ũ�� �̹� ��ϵǾ������� pass
			if(rank[i] > 0)
				continue;
			
			// ��� ������ ���� ��¼��� ������ ���� ���� �˻�
			for(int j=0; j<size; j++) {
				if(thread[j].x >= LENGTH && !arrive[j]) { 
					rank[i] = j+1;
					arrive[j] = true;
					break;
				}
			}
		}
		// ��¼� ����ϸ� ��� ǥ��
		for(int i=0; i<size; i++) {
			if(rank[i] > 0) {
				if(i == 0)
					g.drawString(i+1 + "�� " + rank[i] + "�� �÷��̾� ���",  260,  350 + 40*i); // �÷��̰�� Text���
				else
					g.drawString(i+1 + "�� " + rank[i] + "�� �÷��̾�",  260,  350 + 40*i);
			}
		}
	}
}
// ������
class RunnerThread extends Thread {
	Rungame frame;
	int x, y, w, h, size;
	
	public RunnerThread(Rungame frame, int x, int y, int w, int h, int size) {
		this.frame = frame;
		this.x = x;
		this.y = y;
		this.w = w; 
		this.h = h;
		this.size = size;
	}
	
	public void run() {
		Random ���� = new Random(); //
		Dimension d = frame.getSize();
		
		 // 1000m���� �����ѹ� ���� 1~10m��������. ������ 100m�̳� ������ �ʹ� ª�� 1000m�� Ȯ���Ͽ����ϴ�.
		for (; x <= 1000; x += ����.nextInt(10)+1) {
			try {
				frame.repaint(); // �׸��� �����̰� �����̰� �ϴ� ȿ�� (�޸��� ȿ��)
				
				// ��� �÷��̾ ���� ����� ����				
				for(int i=0; i<size; i++) {
					if(frame.rank[i] == 0)
						frame.stopFlag = false;
				}
				if(frame.stopFlag)
					break;
					
				Thread.sleep(30);
			} catch (Exception e) {
			}
		}
		
		frame.repaint();
	}
}