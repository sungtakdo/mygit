package kopo.aisw.basic_mvc.board.dao;

import kopo.aisw.basic_mvc.board.vo.BoardVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository("memberDAO")
public class BoardDAOImpl implements BoardDAO {
    @Autowired
    private SqlSession sqlSession;
    @Override
    public List selectAllMemberList() throws DataAccessException {
        List<BoardVO> articlesList = null;
        articlesList = sqlSession.selectList("mapper.board.selectAllArticlesList");
        return articlesList;
    }
}
