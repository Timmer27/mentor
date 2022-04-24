package com.mid.socket;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

// 개인 사용자에게 톡보내기 위한 시스템
public class HttpSessionConfig extends Configurator {
   @Override
	public void modifyHandshake(
		/* 아래의 config 에 저장한 내용은 ServerEndPoint 클래스에 전달된다 */
		ServerEndpointConfig config, 
		HandshakeRequest request, 
		HandshakeResponse response
	) {
	HttpSession session = (HttpSession) request.getHttpSession();
	ServletContext context = session.getServletContext();
	/* 위에서 구한 HttpSession 객체의 참조를 config에 저장한다 */
	config.getUserProperties().put("session", session);
	
	// 아래처럼 다수개의 값도 저장 가능
	config.getUserProperties().put("context", context);
	}
}
