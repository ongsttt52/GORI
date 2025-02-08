package com.taek.gori.controller;


import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.taek.gori.dao.UserDao;
import com.taek.gori.dto.UserDto;

@Controller
public class RegistController {
	@Autowired UserDao udao;
	
	@GetMapping("/regist")
	public String regist() {
		return "register01";
	}
	
	@PostMapping("/regist")
	public String regist(String page, @ModelAttribute UserDto user, HttpServletRequest req, Model m, RedirectAttributes ra) {
		if("1".equals(page)) {
			System.out.println(user);
			m.addAttribute("user", user);
			return "register02";
		} else if("2".equals(page)) {
			m.addAttribute("user", user);
			return "register03";
		} else {
			String[] genres = req.getParameterValues("genre");
			String genre = String.join(",", genres);
			user.setGenre(genre);
			try {
				int res = udao.insert(user);
				if(res == 1) {
					String msg = "가입되었습니다. 즐거운 시간 보내세요!";
					String decoded = URLDecoder.decode(msg, "utf-8");
					ra.addFlashAttribute("msg", decoded);
					return "redirect:/login";
				}
				else throw new Exception();
			} catch(Exception e) {
				e.printStackTrace();
				return "redirect:/";
			}
		}
	}
	
	@PostMapping("/regist/check")
	@ResponseBody
	public String check(String col, String value) {
		try {
			UserDto user = udao.select(col, value);
			if(user==null) return "SUCCESS";
			else return "DUPLICATED";
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("RegistController-check() 에서 오류 발생");
			return "ERROR";
		}
	}
}
