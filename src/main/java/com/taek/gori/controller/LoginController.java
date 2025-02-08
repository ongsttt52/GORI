package com.taek.gori.controller;

import java.sql.Timestamp;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.taek.gori.dao.UserDao;
import com.taek.gori.dto.UserDto;

@Controller
public class LoginController {
	@Autowired UserDao udao;
	
	@GetMapping("/login")
	public String login(@CookieValue(value="id", required=false) Cookie cookie) {
		return "login";
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute UserDto user, @RequestParam boolean rememberMe, @RequestParam(required=false) String toUrl, HttpServletResponse resp, HttpSession session) {
		try {
			if(rememberMe) {
				Cookie cookie = new Cookie("email", user.getEmail());
				cookie.setMaxAge(7*24*60*60);
				resp.addCookie(cookie);
			} else {
				Cookie cookie = new Cookie("email", "");
				cookie.setMaxAge(0);
				resp.addCookie(cookie);
			}
			session.setAttribute("user", udao.select("email", user.getEmail()));
			if(toUrl!=null) return "redirect:"+toUrl ;
		else return "redirect:/";
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/login";
		}
	}
	
	@PostMapping("/login/check")
	@ResponseBody
	public String loginCheck(String email, String pwd) {
		try {
			UserDto selected = udao.select("email", email);
			Timestamp ts = selected.getDeactivate();
			
			if(ts != null && ts.after(new Timestamp(System.currentTimeMillis()))) return "DENIED";
			if(selected != null && selected.getPwd().equals(pwd)) return "SUCCESS";
			else return "FAIL";
		} catch(Exception e) {
			e.printStackTrace();
			return "ERROR";
		}
	}
	
	@GetMapping("/logout") 
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
