package com.kjh.exam.demo.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kjh.exam.demo.repository.StatisticsRepository;

@Service
public class StatisticsService {
	@Autowired
	private StatisticsRepository statisticsRepository;

	public Map getStatisticsByArticle(String startDate, String lastDate, int boardId) {
		Map statisticsMapByArticle = statisticsRepository.getStatisticsByArticle(startDate, lastDate, boardId);
		return statisticsMapByArticle;
	}

	public Map getStatisticsByMember(String startDate, String lastDate) {
		Map statisticsMapByMember = statisticsRepository.getStatisticsByMember(startDate, lastDate);
		return statisticsMapByMember;
	}
}
