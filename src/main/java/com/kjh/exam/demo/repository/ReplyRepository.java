package com.kjh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.kjh.exam.demo.vo.Reply;

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

	@Select("""
			<script>
			SELECT R.*, M.nickname AS extra__writerName
			FROM reply AS R
			LEFT JOIN `member` AS M
			ON R.memberId = M.id
			WHERE R.relTypeCode = #{relTypeCode}
			AND R.relId = #{relId}
			</script>
			""")
	List<Reply> getForPrintReplies(String relTypeCode, int relId);

	@Select("""
			SELECT R.*,
			M.nickname AS extra__writerName
			FROM reply AS R
			LEFT JOIN `member` AS M
			ON R.memberId = M.id
			WHERE R.id = #{id}
			""")
	Reply getForPrintReply(int id);

	@Delete("""
			DELETE FROM reply
			WHERE id = #{id}
			""")
	void deleteReply(int id);

	@Update("""
			UPDATE reply
			SET updateDate = NOW(),
			`body` = #{body}
			WHERE id= #{id}
			""")
	void modifyReply(int id, String body);
	
	@Delete("""
			DELETE FROM reply
			WHERE relId = #{id}
			AND relTypeCode = 'reply'
			""")
	void deleteReplyOfReply(int id);

}
