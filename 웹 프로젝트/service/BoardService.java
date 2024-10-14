package kopo.aisw.basic_mvc.board.service;

import org.springframework.dao.DataAccessException;
import java.util.List;
public interface BoardService {
    public List listArticles() throws DataAccessException;
}