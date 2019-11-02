package 달리기9;
/* 2019-03-31 ~ 2019-04-03 
 *  201714284 문승훈
 *  https://blog.naver.com/shimchan2/70109242620 << GUI 디자인 출처
 */
import java.awt.*;
import java.awt.event.*;
import java.util.*;
public class ThreadClass {	
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int input;
		
		System.out.print("플레이어 수를 입력하세요(2 ~ 10) : ");
		input = sc.nextInt();
		
		while(input < 2 || input > 10) {
			System.out.print("2 ~ 10 까지의 수만 입력하세요 : ");
			input = sc.nextInt();
		}
		
		Rungame frame = new Rungame(input);
		
		frame.setLocation(300, 100);
		frame.setSize(1300, 1000); //실행 창 전체 화면 크기
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
	final int LENGTH = 1000; // 트랙길이 1000m
	//Font f;
	boolean stopFlag;
	
	// 생성자
	public Rungame(int size) {
		super("달리기 게임");
		
		// 초기화
		this.size = size;
		thread = new RunnerThread[size];
		rank = new int[size];
		arrive = new boolean[size];
		//f = new Font("고딕체", Font.PLAIN, 30); // 글씨체 변경시 렉걸림현상
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
		// 쓰레드 생성
		for(int i=0; i<size; i++)
			thread[i] = new RunnerThread(this, 10, (i+1)*90, 10, 50, size);
	}
	
	public void actionPerformed(ActionEvent e) {
		String str = e.getActionCommand();
		System.out.println(str);
		
		// 쓰레드 시작
		if (str.equals("Start")) {
			for(int i=0; i<size; i++)
				thread[i].start();
		}
	}
	
	public void update(Graphics g) {
		super.update(g);
	}
	
	public void paint(Graphics g) {
		// 1000m 결승선 표현
		g.drawLine(LENGTH, 0, LENGTH, 1000);
		//g.setFont(f);
		
		// 플레이어 색상
		g.setColor(Color.red);
		// 플레이어 (사각형) 그림 그리기
		for(int i=0; i<size; i++)
			g.fillRect(thread[i].x, thread[i].y, thread[i].w, thread[i].h);
		
		// 등수 1~10 판별
		for (int i=0; i<size; i++) {
			// 랭크가 이미 기록되어있으면 pass
			if(rank[i] > 0)
				continue;
			
			// 모든 선수에 대한 결승선에 도착한 선수 순위 검사
			for(int j=0; j<size; j++) {
				if(thread[j].x >= LENGTH && !arrive[j]) { 
					rank[i] = j+1;
					arrive[j] = true;
					break;
				}
			}
		}
		// 결승선 통과하면 등수 표시
		for(int i=0; i<size; i++) {
			if(rank[i] > 0) {
				if(i == 0)
					g.drawString(i+1 + "등 " + rank[i] + "번 플레이어 우승",  260,  350 + 40*i); // 플레이결과 Text출력
				else
					g.drawString(i+1 + "등 " + rank[i] + "번 플레이어",  260,  350 + 40*i);
			}
		}
	}
}
// 쓰레드
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
		Random 보폭 = new Random(); //
		Dimension d = frame.getSize();
		
		 // 1000m까지 랜덤넘버 보폭 1~10m구간설정. 원래는 100m이나 구간이 너무 짧아 1000m로 확대하였습니다.
		for (; x <= 1000; x += 보폭.nextInt(10)+1) {
			try {
				frame.repaint(); // 그림이 움직이고 깜빡이게 하는 효과 (달리는 효과)
				
				// 모든 플레이어가 전부 멈춰야 종료				
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