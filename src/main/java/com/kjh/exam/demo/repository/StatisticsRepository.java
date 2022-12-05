package com.kjh.exam.demo.repository;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface StatisticsRepository {
	@Select("""			
			<script>
			SELECT COUNT(*) AS articlesCount, 
			SUM(hitCount) AS totalViews, 
			AVG(hitCount) AS averageViews, 
			MAX(hitCount) AS topViews 
			FROM article
			WHERE regDate BETWEEN CONCAT(#{startDate}, ' 00:00:00') AND CONCAT(#{lastDate}, ' 23:59:59')
			<if test="boardId != 0">	
			AND boardId = #{boardId}
			</if>
			</script>
			""")	
	Map getStatisticsByArticle(String startDate, String lastDate, int boardId);
	
	@Select("""			
			<script>
			SELECT IFNULL(COUNT(*),0) AS 'newMembersCount', 
			(SELECT COUNT(*) FROM `member`
			WHERE updateDate BETWEEN CONCAT(#{startDate}, ' 00:00:00') AND CONCAT(#{lastDate}, ' 23:59:59')
			AND delStatus = 1 ) AS 'withdrawalMembersCount',
			(SELECT COUNT(*) FROM `member`) AS 'totalMembersCount',
			(SELECT COUNT(IF(delStatus &gt; 0, delStatus, NULL)) FROM `member`) AS 'totalWithdrawalMembersCount'
			FROM `member`
			WHERE regDate BETWEEN CONCAT(#{startDate}, ' 00:00:00') AND CONCAT(#{lastDate}, ' 23:59:59')
			</script>
			""")	
	Map getStatisticsByMember(String startDate, String lastDate);
}