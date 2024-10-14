package kopo.aisw.basic_mvc.board.service;

import kopo.aisw.basic_mvc.board.dao.BoardDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
@Service("boardService")
@Transactional(propagation = Propagation.REQUIRED)
public class BoardServiceImpl implements BoardService {
    @Autowired
    private BoardDAO boardDAO;
    @Override
    public List listArticles() throws DataAccessException {
        List articlesList = null;
        articlesList = boardDAO.selectAllMemberList();
        return articlesList;
    }
}
