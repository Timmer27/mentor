package com.mid.socket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.SessionAttribute;

@Component
//@ServerEndpoint("/websocket")
//Configurator의 값이 여러개이기 떄문에 값을 특정한 이름으로 지정해야한다.
@ServerEndpoint(value = "/websocket", configurator = HttpSessionConfig.class)
//위의 endpoint를 사용하여 URL로 접속하면 아래의 onOpen(event) 메서드가 돌아감
//웹소켓의 서버격 - 실제 채팅은 JSP를 참고
public class WebSocketTest {
    /* 웹소켓 세션 보관용 ArrayList */
    private static ArrayList<Session> sessionList = new ArrayList<Session>();
    private static Map<String, Session> mapSession = new HashMap<>();

    /* 웹소켓 사용자 접속시 호출됨  = 최초통신 */
	@OnOpen
	public void handleOpen(Session session, EndpointConfig config) {
		
//		접속을 했을 때 사람을 추적할 수 있는 별도의 일반 session이 생성됨
		HttpSession httpSession = (HttpSession) config.getUserProperties().get("session");
		
		String uid = (String)httpSession.getAttribute("id");
		String userType = (String)httpSession.getAttribute("userType");
		System.err.println("웹소켓에 전달된 이용자 ID테스트 : " + uid);
		
//		생성된 새로운 session을 list에 담아서 저장
	    if (session != null) {
            String sessionId = session.getId();
            
            System.out.println("client is connected. sessionId == [" + sessionId + "]");
//          접속 시 개발자가 누가 들어왔는지 확인
            
            sessionList.add(session);
//         	세션 아이디를 list에 저장해서 나중에 사용
            mapSession.put(uid, session);
            System.err.println("size test " + mapSession.size());
            System.err.println("size test " + mapSession.get("test").getId()+userType);
          
	        /* 웹소켓에 접속한 모든 이용자에게 메시지 전송 */
//          아래 메서드 활용
	        sendMessageToAll("--> [USER-" + sessionId + " | " + uid + "] is connected. ");
        }
    }

	/* 웹소켓 이용자로부터 메시지가 전달된 경우 실행됨 = 메세지받기 */
    @OnMessage
    public String handleMessage(String message, Session session) {
        if (session != null) {
            String sessionId = session.getId();
            System.err.println("세션 리스트 " + sessionList.size());
//            System.out.println("message is arrived. sessionId == [" + sessionId + "] / message == [" + message + "]");

            /* 웹소켓에 접속한 모든 이용자에게 메시지 전송 */
            sendMessageToAll("[USER-" + sessionId + "] " + message);
//            sendMessage(message);
        }
        return null;
    }

    /* 웹소켓 이용자가 연결을 해제하는 경우 실행됨 */
//  접속을 끊었을 때 이벤를 실행시키는 것인데, 굳이 의무적인 것은 아님!
    @OnClose
    public void handleClose(Session session) {
        if (session != null) {
            String sessionId = session.getId();
            System.out.println("client is disconnected. sessionId == [" + sessionId + "]");
            
            /* 웹소켓에 접속한 모든 이용자에게 메시지 전송 */
            sendMessageToAll("***** [USER-" + sessionId + "] is disconnected. *****");
        }
    }

    /* 웹소켓 에러 발생시 실행됨, 당연히 생길 오류 찍어서 보고 고치자*/
    @OnError
    public void handleError(Throwable t) {
        t.printStackTrace();
    }
    
    
    /* 웹소켓에 접속한 모든 이용자에게 메시지 전송 */
		private boolean sendMessageToAll(String message) {
	        if (sessionList == null) {
	            return false;
	        }
	
	        int sessionCount = sessionList.size();
	        if (sessionCount < 1) {
	            return false;
	        }
//	        세션리스트의 크기가 0이 아닐 때 for문을 돌려서 동작시킴
	        Session singleSession = null;
	
	        for (int i = 0; i < sessionCount; i++) {
	        	singleSession = sessionList.get(i);
//				하나의 세션이 null일때는 continue로 캔슬
	            if (singleSession == null) {
	                continue;
	            }
//	            하나의 세션이 isOpen, 즉 열린상태가 아니면 캔슬
	            if (!singleSession.isOpen()) {
	                continue;
	            }
//	            위의 조건을 다 만족하면 지정한 message를 getAsyncRemote()를 통해 전체 사용자에게 보냄
//	            getAsyncRemote = 비동기원격객체에게 sendText 
	            sessionList.get(i).getAsyncRemote().sendText(message);
	            
				//만약 map을 활용해서 Map<String, Session>을 저장하면 나중에 특정 이용자의 세션을 아무때나 뽑을 수 있다.
				//map.get("smith")의 형식으로 데이터를 추출하면 특정 사람의 session이 출력되고
				//map.get("smith").getAsyncRemote().sendText(message);으로 보내게되면 이 사람에게만 보낼 수 있다 = 전용 귓말
	        }
        return true;
    }
//    
		private boolean sendMessage(String message) {
//	    	세션이 없으면 false
	    	if (sessionList == null) {
	    		return false;
	    	}
//	    	세션이 단일이여도 false
	    	int sessionCount = sessionList.size();
	    	if (sessionCount < 1) {
	    		return false;
	    	}
//	    	getAsyncRemote = 비동기원격객체에게 sendText 
			sessionList.get(2).getAsyncRemote().sendText(message);
	    		
	    	return true;
	    }

}
