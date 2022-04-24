package com.mid.socket;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.ui.Model;

@Controller
@RequestMapping("socketTest")
@SessionAttributes({"id", "userType"})
public class chatController {
	
    @GetMapping("")
    public String chat(Model m) {
    	m.addAttribute("id", "test");
    	m.addAttribute("userType", "menti");
        return "/websocket/chat";
        
	}
}


