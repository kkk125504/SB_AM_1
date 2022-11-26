package com.kjh.exam.demo.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ReplyRepository {
		
	@Insert("""
			<script>
			INSERT INTO reply
			SET regDate = NOW(),
			updateDate = NOW(),
			memberId = #{actorId},
			relTypeCode = #{relTypeCode},
			relId = #{relId},
			`body` = #{body}
			</script>
			""")
	void writeReply(int actorId, String relTypeCode, int relId, String body);

	@Select("""
			<script>
			SELECT LAST_INSERT_ID()
			</script>
			""")
	int getLastInsertId();
}
