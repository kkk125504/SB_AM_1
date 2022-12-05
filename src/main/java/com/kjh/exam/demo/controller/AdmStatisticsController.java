package com.kjh.exam.demo.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kjh.exam.demo.service.StatisticsService;

@Controller
public class AdmStatisticsController {
	@Autowired
	private StatisticsService statisticsService;

	@RequestMapping("adm/statistics/article")
	@ResponseBody
	public Map getStatisticsByArticle(String startDate, String lastDate,@RequestParam(defaultValue = "0") int boardId) {
		return statisticsService.getStatisticsByArticle(startDate, lastDate, boardId);
	}
	
	@RequestMapping("adm/statistics/member")
	@ResponseBody
	public Map getStatisticsByMember(String startDate, String lastDate) {
		return statisticsService.getStatisticsByMember(startDate, lastDate);
	}
}